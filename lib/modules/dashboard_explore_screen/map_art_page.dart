import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/services/location_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/async_dropdown_menu.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/map_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

Widget get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.art_for_all',
      tileProvider: CachedTileProvider(
        maxStale: const Duration(days: 30),
        store: locator.get<FileCacheStore>(),
      ),
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
  final geolocator = locator.get<ILocationService>();

  final filterController = TextEditingController();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final carouselController = CarouselSliderController();
  final listController = CarouselSliderController();
  bool showFilters = false;
  double _currentSliderValue = 20;

  bool showTabBar = false;
  late final TabController tabController = TabController(length: 2, vsync: this);
  LatLng get _center => geolocator.userLatLng;

  void _onLocationUpdate(latLng) {
    bloc.init(latLng);
  }

  @override
  void initState() {
    bloc.init(_center);
    geolocator.addListener(_onLocationUpdate);
    super.initState();
  }

  @override
  void dispose() {
    geolocator.removeListener(_onLocationUpdate);
    tabController.dispose();
    _animatedMapController.dispose();
    super.dispose();
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
          offset: const Offset(0, -0),
        );

        if (carouselController.ready && !lock) {
          carouselController.jumpToPage(index);
        }

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
                          child: AsyncDropdownMenu<SearchableAbstractModel>(
                            hintText: 'Search...',
                            items: state.arts
                                .map(
                                  (e) => DropdownMenuEntry<SearchableAbstractModel>(
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
                        // const SizedBox(width: 12),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       showFilters = !showFilters;
                        //     });
                        //   },
                        //   child: SizedBox(
                        //     height: 42,
                        //     child: Icon(
                        //       Icons.filter_alt,
                        //       color: context.colorTheme.onPrimaryContainer,
                        //       size: 36,
                        //     ),
                        //   ),
                        // )
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
                          colorFilter: context.colorTheme.onBackground.isLight
                              ? const ColorFilter.matrix(<double>[
                                  -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
                                  -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
                                  -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
                                  0, 0, 0, 1, 0, // Alpha channel
                                ])
                              : ColorFilter.mode(
                                  context.colorTheme.onBackground.isDark
                                      ? Colors.black
                                      : const Color.fromARGB(172, 204, 196, 196),
                                  context.colorTheme.onBackground.isDark
                                      ? BlendMode.hue
                                      : BlendMode.difference,
                                ),
                          child: openStreetMapTileLayer,
                        ),
                        MarkerLayer(markers: [
                          _buildUserMarker(context),
                        ]),
                        MarkerClusterLayerWidget(
                          options: MarkerClusterLayerOptions(
                            maxClusterRadius: 45,
                            showPolygon: false,
                            size: const Size(40, 40),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(50),
                            disableClusteringAtZoom: 14,
                            maxZoom: 16,
                            markers: [
                              ...state.arts.mapIndexed((i, item) {
                                return _buildMapMarker(item, i, context);
                              }),
                            ],
                            builder: (context, markers) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        MarkerLayer(markers: [
                          if (state.focusedArt != null)
                            _buildSelectedMapMarker(state, context),
                        ]),
                        // MarkerLayer(markers: [
                        //   _buildUserMarker(context),
                        //   ...state.arts.mapIndexed((i, item) {
                        //     return _buildMapMarker(item, i, context);
                        //   }),
                        //   if (state.focusedArt != null)
                        //     _buildSelectedMapMarker(state, context),
                        // ]),
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
                                  return SearchableOnMapCardContainer.small(
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
                        Align(
                          alignment: Alignment.topRight,
                          child: IntrinsicHeight(
                            child: Container(
                              margin: kExtraTinyPadding,
                              decoration: BoxDecoration(
                                color: context.colorTheme.primaryContainer,
                                borderRadius: kSmallBorderRadius,
                              ),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _animatedMapController.animatedZoomIn();
                                    },
                                    icon: Icon(
                                      Icons.zoom_in,
                                      color: context.colorTheme.onPrimaryContainer,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _animatedMapController.animatedZoomOut();
                                    },
                                    icon: Icon(
                                      Icons.zoom_out,
                                      color: context.colorTheme.onPrimaryContainer,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _animatedMapController.animateTo(dest: _center);
                                      bloc.onCenterChanged(_center);
                                    },
                                    icon: Icon(
                                      Icons.my_location,
                                      color: context.colorTheme.onPrimaryContainer,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                          child: SearchableOnMapCardContainer.small(
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
    Widget? child;

    if (state.hasPositionChanged) {
      final style = context.typographyTheme.label.onPrimaryContainer.textStyle;
      child = Padding(
        padding: kMediumPadding,
        child: AFAElevatedButton(
          padding: kSmallPadding,
          background: context.colorTheme.primaryContainer,
          onPressed: () {
            bloc.searchByCenter();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Search in this area",
                style: style,
              ),
              SizedBox(width: kTinyPadding.right),
              Icon(
                Icons.refresh,
                color: context.colorTheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      );
    }
    if (state.isLoadingArts == LoadingState.loading) {
      child = Padding(
        padding: kMediumPadding,
        child: AFAElevatedButton(
          background: context.colorTheme.primaryContainer,
          onPressed: () {},
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      );
    }

    return child == null
        ? const SizedBox()
        : AnimatedSwitcher(
            duration: kLoadingDuration,
            child: child,
          );
  }

  Marker _buildUserMarker(BuildContext context) {
    return Marker(
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      point: _center,
      child: InkWell(
        child: CircleAvatar(
          backgroundColor: context.colorTheme.tertiaryContainer,
          child: Icon(
            Icons.location_history,
            color: context.colorTheme.onTertiaryContainer,
            size: 30,
          ),
        ),
      ),
    );
  }

  Marker _buildSelectedMapMarker(MapArtBlocState state, BuildContext context) {
    return Marker(
      width: 75,
      height: 75,
      alignment: Alignment.center,
      point: state.focusedArt!.geoLocation,
      child: InkWell(
        child: Icon(
          Icons.location_pin,
          color: context.colorTheme.primary,
          size: 75,
        ),
      ),
    );
  }

  Marker _buildMapMarker(SearchableAbstractModel item, int i, BuildContext context) {
    return Marker(
      width: 75,
      height: 75,
      point: item.geoLocation,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          bloc.setFocusedArt(item);
        },
        child: Icon(
          Icons.location_pin,
          color: context.colorTheme.onPrimaryContainer.withOpacity(kTinyOpacity),
          size: 75,
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
