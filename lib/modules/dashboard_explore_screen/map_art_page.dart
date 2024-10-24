import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/async_dropdown_menu.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/map_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

Widget get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.art_for_all',
      // Use the recommended flutter_map_cancellable_tile_provider package to
      // support the cancellation of loading tiles.
      tileProvider: CancellableNetworkTileProvider(),
    );

class NearMeScreen extends StatefulWidget {
  static String name = 'NearMeScreen';
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> with TickerProviderStateMixin {
  final bloc = locator.get<MapArtBloc>();
  final navigator = locator.get<NavigationService>();
  final filterController = TextEditingController();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final carouselController = CarouselSliderController();
  final listController = CarouselSliderController();
  final LatLng _center = const LatLng(51.5, -0.09);
  bool showFilters = false;
  double _currentSliderValue = 20;

  bool showTabBar = false;
  late final TabController tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    bloc.init(_center);
    super.initState();
  }

  bool lock = false;

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
      ),
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
    );
    final cardHeight = context.vHeight / 7;
    return BlocConsumer<MapArtBloc, MapArtBlocState>(
      listenWhen: (previous, current) => previous.focusedArt != current.focusedArt,
      listener: (context, state) {
        final data = state.focusedArt;
        if (data == null) return;

        final index = state.arts.indexOf(data);
        _animatedMapController.animateTo(
          dest: data.geoLocation,
          offset: Offset(0, -cardHeight),
        );

        if (carouselController.ready && !lock) carouselController.jumpToPage(index);
        // if (tabController.index == 1) {
        //   carouselController.jumpToPage(index);
        // }

        // if (tabController.index == 0) {
        //   listController.jumpToPage(index);
        // }
        setState(() {
          lock = false;
        });
      },
      bloc: bloc,
      builder: (context, state) {
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            PinnedHeaderSliver(child: header),
            PinnedHeaderSliver(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.primaryContainer,
                  border: Border(
                    bottom: kExtraTinyBorder.copyWith(
                      color: context.colorTheme.onPrimaryContainer,
                    ),
                  ),
                ),
                padding: kMediumPadding,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AsyncDropdownMenu<ArtAbstractModel>(
                            hintText: 'Search...',
                            items: state.arts
                                .map(
                                  (e) => DropdownMenuEntry<ArtAbstractModel>(
                                    value: e,
                                    label: e.title,
                                  ),
                                )
                                .toList(),
                            onChanged: (query) {
                              bloc.filter(
                                _animatedMapController.mapController.camera.center,
                                _currentSliderValue,
                                query,
                              );
                            },
                            controller: filterController,
                            isLoading: false,
                            onSelected: (item) {
                              bloc.setFocusedArt(item);
                            },
                            isEnabled: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            setState(() {
                              showFilters = !showFilters;
                            });
                          },
                          child: SizedBox(
                            height: 42,
                            child: Icon(
                              Icons.filter_alt,
                              color: context.colorTheme.onPrimaryContainer,
                              size: 36,
                            ),
                          ),
                        )
                      ],
                    ),
                    AnimatedContainer(
                      duration: kLoadingDuration,
                      height: showFilters ? 56 : 0,
                      child: SizedBox(
                        height: 56,
                        child: !showFilters
                            ? null
                            : Slider(
                                value: _currentSliderValue,
                                min: 5,
                                max: 50,
                                divisions: 5,
                                label: "${_currentSliderValue.round()} km",
                                onChanged: (double value) {
                                  bloc.filter(
                                    _animatedMapController.mapController.camera.center,
                                    value,
                                    filterController.text,
                                  );
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (showTabBar) PinnedHeaderSliver(child: _buildTabBar(context)),
            SliverFillRemaining(
              child: TabBarView(
                viewportFraction: 0.999,
                controller: tabController,
                children: [
                  SizedBox(
                    child: FlutterMap(
                      mapController: _animatedMapController.mapController,
                      options: MapOptions(
                        initialCenter: _center,
                        onPositionChanged: (camera, hasGesture) {
                          if (_center == camera.center) {
                            return;
                          }
                        },
                        onMapEvent: (e) {
                          if (e is! MapEventMoveEnd) {
                            return;
                          }
                          bloc.onCenterChanged(e.camera.center);
                        },
                        keepAlive: true,
                      ),
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.onBackground,
                            context.colorTheme.onBackground.isLight
                                ? BlendMode.exclusion
                                : BlendMode.hue,
                          ),
                          child: openStreetMapTileLayer,
                        ),
                        MarkerLayer(markers: [
                          ...state.arts.mapIndexed((i, item) {
                            return _buildMapMarker(item, i, context);
                          }),
                          if (state.focusedArt != null)
                            _buildSelectedMapMarker(state, context)
                        ]),
                        if (state.arts.isNotEmpty)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: kMediumPadding.bottom),
                              child: CarouselSlider.builder(
                                carouselController: carouselController,
                                itemCount: state.arts.length,
                                itemBuilder: (context, index, pageViewIndex) {
                                  final data = state.arts[index];
                                  return ArtCardContainer.small(
                                    data: data,
                                    constraints: const BoxConstraints(),
                                    onTap: () {
                                      final homeUrl = navigator.homeUrl;
                                      navigator.homeContext.push(
                                        '$homeUrl/${ArtDetailScreen.name}/${data.id}',
                                      );
                                    },
                                  );
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      lock = true;
                                    });
                                    if (reason == CarouselPageChangedReason.manual) {
                                      bloc.setFocusedArt(state.arts[index]);
                                    }
                                  },
                                  viewportFraction: 0.7,
                                  height: cardHeight,
                                  enlargeCenterPage: true,
                                  clipBehavior: Clip.none,
                                ),
                              ),
                            ),
                          ),
                        const MapCopyrightInfo(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: _buildRefreshButton(context, state),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: kMediumPadding.right,
                      left: kMediumPadding.left,
                      top: kMediumPadding.bottom,
                    ),
                    child: CarouselSlider.builder(
                      carouselController: listController,
                      itemCount: state.arts.length,
                      itemBuilder: (context, index, pageViewIndex) {
                        final data = state.arts[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: kMediumPadding.top),
                          child: ArtCardContainer.small(
                            data: data,
                            constraints: const BoxConstraints(),
                            onTap: () {},
                          ),
                        );
                      },
                      options: CarouselOptions(
                        padEnds: false,
                        pageSnapping: false,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index, reason) {
                          final data = state.arts[index];
                          bloc.setFocusedArt(data);
                        },
                        viewportFraction: (cardHeight * 2) / context.vHeight,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        clipBehavior: Clip.none,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildRefreshButton(BuildContext context, MapArtBlocState state) {
    if (state.hasPositionChanged) {
      return Padding(
        padding: kMediumPadding,
        child: AFAElevatedButton(
          onPressed: () {
            bloc.searchByCenter();
          },
          child: Icon(
            Icons.refresh,
            color: context.colorTheme.onPrimary,
          ),
        ),
      );
    }
    if (state.isLoadingArts == LoadingState.loading) {
      return Padding(
        padding: kMediumPadding,
        child: AFAElevatedButton(
          onPressed: () {},
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: context.colorTheme.onPrimary,
            ),
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Marker _buildSelectedMapMarker(MapArtBlocState state, BuildContext context) {
    return Marker(
      width: 70,
      height: 70,
      alignment: Alignment.bottomCenter,
      point: state.focusedArt!.geoLocation,
      child: InkWell(
        child: Icon(
          Icons.pin_drop_rounded,
          color: context.colorTheme.primary,
          size: 70,
        ),
      ),
    );
  }

  Marker _buildMapMarker(ArtAbstractModel item, int i, BuildContext context) {
    return Marker(
      width: 70,
      height: 70,
      point: item.geoLocation,
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          bloc.setFocusedArt(item);
        },
        child: Icon(
          Icons.pin_drop_outlined,
          color: context.colorTheme.onPrimaryContainer,
          size: 70,
        ),
      ),
    );
  }

  Container _buildTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
        border: Border(
          bottom: kExtraTinyBorder.copyWith(
            color: context.colorTheme.onPrimaryContainer,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        tabs: const [
          Tab(icon: Icon(Icons.map)),
          Tab(icon: Icon(Icons.list)),
        ],
      ),
    );
  }
}

class MapCopyrightInfo extends StatelessWidget {
  const MapCopyrightInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichAttributionWidget(
      animationConfig: const ScaleRAWA(), // Or `FadeRAWA` as is default
      attributions: [
        TextSourceAttribution(
          'OpenStreetMap contributors',
          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
        ),
      ],
    );
  }
}

class MapScreenHeader extends StatelessWidget {
  const MapScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.primaryContainer,
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
    );
  }
}
