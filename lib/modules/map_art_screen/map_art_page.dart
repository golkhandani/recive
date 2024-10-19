import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/async_dropdown_menu.dart';
import 'package:art_for_all/modules/detail_art_screen/detail_art_page.dart';
import 'package:art_for_all/modules/map_art_screen/widgets/art_on_map_card.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
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
  final navigationService = locator.get<NavigationService>();
  final filterController = TextEditingController();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final carouselController = CarouselSliderController();
  final listController = CarouselSliderController();
  final LatLng _center = const LatLng(51.5, -0.09);

  @override
  void initState() {
    bloc.init(_center);
    super.initState();
  }

  bool showFilters = false;
  double _currentSliderValue = 20;
  bool mapLocked = true;
  late final TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      color: context.colorTheme.primaryContainer,
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Find the arts!',
            style: context.typographyTheme.titleSmall.textStyle.copyWith(
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );

    return BlocConsumer<MapArtBloc, MapArtBlocState>(
      // listenWhen: (previous, current) =>
      //     previous.focusedArt == null && current.focusedArt != null,
      listener: (context, state) {
        if (state.focusedArt != null &&
            _animatedMapController.mapController.camera.center !=
                state.focusedArt!.geoLocation) {
          _animatedMapController.animateTo(
            dest: state.focusedArt!.geoLocation,
            offset: const Offset(0, -100),
          );
        }
      },
      bloc: bloc,
      builder: (context, state) {
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            PinnedHeaderSliver(child: header),
            PinnedHeaderSliver(
              child: Container(
                color: context.colorTheme.primaryContainer,
                padding: EdgeInsets.only(
                  left: kMediumPadding.left,
                  right: kMediumPadding.right,
                  bottom: kSmallPadding.bottom,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AsyncDropdownMenu<ArtAbstractModel>(
                            hintText: 'Search for tags!!!',
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
                            height: 56,
                            child: Icon(
                              Icons.filter_alt,
                              color: context.colorTheme.onPrimary,
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
            PinnedHeaderSliver(
              child: ColoredBox(
                color: context.colorTheme.primaryContainer,
                child: TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(icon: Icon(Icons.map)),
                    Tab(icon: Icon(Icons.list)),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                viewportFraction: 0.9999,
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

                          // bloc.filter(_currentSliderValue, filterController.text);
                        },
                        onMapEvent: (e) {
                          if (e is! MapEventMoveEnd) {
                            return;
                          }
                          // bloc.filter(
                          //   e.camera.center,
                          //   _currentSliderValue,
                          //   filterController.text,
                          // );
                        },
                        keepAlive: true,
                      ),
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.secondary,
                            BlendMode.hue,
                          ),
                          child: openStreetMapTileLayer,
                        ),
                        MarkerLayer(markers: [
                          ...state.arts.mapIndexed((i, item) {
                            return Marker(
                              width: 70,
                              height: 70,
                              point: item.geoLocation,
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  carouselController.animateToPage(
                                    i,
                                    duration: kLoadingDuration,
                                    curve: Curves.bounceIn,
                                  );
                                  _animatedMapController.animateTo(
                                    dest: item.geoLocation,
                                    offset: const Offset(0, -100),
                                  );
                                },
                                child: const Icon(
                                  Icons.pin_drop_outlined,
                                  size: 70,
                                ),
                              ),
                            );
                          }),
                          if (state.focusedArt != null)
                            Marker(
                              width: 70,
                              height: 70,
                              alignment: Alignment.bottomCenter,
                              point: state.focusedArt!.geoLocation,
                              child: InkWell(
                                onTap: () {
                                  final i = state.arts.indexOf(state.focusedArt!);
                                  carouselController.animateToPage(
                                    i,
                                    duration: kLoadingDuration,
                                    curve: Curves.bounceIn,
                                  );
                                  _animatedMapController.animateTo(
                                    dest: state.focusedArt!.geoLocation,
                                  );
                                },
                                child: Icon(
                                  Icons.pin_drop_outlined,
                                  color: context.colorTheme.success,
                                  size: 70,
                                ),
                              ),
                            )
                        ]),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: kMediumPadding.bottom),
                            child: CarouselSlider.builder(
                              carouselController: carouselController,
                              itemCount: state.arts.length,
                              itemBuilder: (context, index, pageViewIndex) {
                                final data = state.arts[index];
                                final extraJson = ExtraData(
                                  summary: ArtDetailSummaryData(
                                    id: data.id,
                                    title: data.title,
                                    imageUrl: data.imageUrl,
                                  ),
                                  heroTag: index.toString(),
                                ).toJson((inner) => inner.toJson());
                                return GestureDetector(
                                  onTap: () {
                                    navigationService.pushTo(
                                      NearMeScreen.name + ArtDetailScreen.name,
                                      pathParameters: {
                                        ArtDetailScreen.pathParamId: data.id,
                                      },
                                      extra: extraJson,
                                    );
                                  },
                                  child: ArtOnMapCard(key: Key(data.id), data: data),
                                );
                              },
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    final data = state.arts[index];
                                    bloc.setFocusedArt(data);
                                    _animatedMapController.animateTo(
                                      dest: data.geoLocation,
                                      offset: const Offset(0, -100),
                                    );
                                    if (tabController.index == 0) {
                                      listController.jumpToPage(index);
                                    }
                                  });
                                },
                                viewportFraction: 0.7,
                                height: 142,
                                enlargeCenterPage: true,
                                clipBehavior: Clip.none,
                              ),
                            ),
                          ),
                        ),
                        RichAttributionWidget(
                          animationConfig: const ScaleRAWA(), // Or `FadeRAWA` as is default
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () =>
                                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: kMediumPadding.right,
                      left: kMediumPadding.left,
                      bottom: kMediumPadding.bottom,
                    ),
                    child: CarouselSlider.builder(
                      carouselController: listController,
                      itemCount: state.arts.length,
                      itemBuilder: (context, index, pageViewIndex) {
                        final data = state.arts[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: kMediumPadding.top),
                          child: ArtOnMapCard(key: Key(data.id), data: data),
                        );
                      },
                      options: CarouselOptions(
                        padEnds: false,
                        pageSnapping: false,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index, reason) {
                          final data = state.arts[index];
                          bloc.setFocusedArt(data);
                          _animatedMapController.animateTo(
                            dest: data.geoLocation,
                            offset: const Offset(0, -100),
                          );
                          if (tabController.index == 1) {
                            carouselController.jumpToPage(index);
                          }
                        },
                        viewportFraction: 0.4,
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
}
