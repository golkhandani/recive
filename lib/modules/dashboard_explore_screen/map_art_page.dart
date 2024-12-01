import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/services/location_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/services/web_cache_store.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/async_search_field.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/artist_detail_screen/news_detail_screen.dart';
import 'package:art_for_all/modules/category_detail_screen/category_list_bloc.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/map_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/widgets/category_filter.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/widgets/filters_overlay.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_page.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

Widget get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.art_for_all',
      tileProvider: CachedTileProvider(
        maxStale: const Duration(days: 30),
        store: locator.get<CacheStore>(),
      ),
    );

class NearMeScreen extends StatefulWidget {
  static String name = 'compass';
  const NearMeScreen({super.key, this.query});

  final String? query;

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> with TickerProviderStateMixin {
  final bloc = locator.get<MapArtBloc>();
  final navigator = locator.get<NavigationService>();
  final geolocator = locator.get<ILocationService>();
  late final categoryBloc = BlocProvider.of<CategoryListBloc>(context);
  final portalController = locator.get<OverlayPortalController>();

  final filterContainerController = FilterContainerController();
  final filterController = TextEditingController();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final carouselController = CarouselSliderController();
  final listController = CarouselSliderController();
  bool showFilters = false;

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
  void didUpdateWidget(covariant NearMeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query?.isEmpty ?? true) return;
    bloc.filter(_center, widget.query!);
    filterController.text = widget.query!;
  }

  @override
  void dispose() {
    geolocator.removeListener(_onLocationUpdate);
    tabController.dispose();
    _animatedMapController.dispose();
    super.dispose();
  }

  final ValueNotifier<double> headerHeightNotifier = ValueNotifier<double>(0.0);

  bool lock = false;

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.vHeight / 6;
    return BlocListener<MapArtBloc, MapArtBlocState>(
      listenWhen: (previous, current) {
        return previous.focusedArt != current.focusedArt ||
            previous.arts.hashCode != current.arts.hashCode;
      },
      listener: (context, state) {
        final data = state.focusedArt;

        if (data == null || state.arts.isEmpty) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final index = state.arts.indexOf(data);
          if (carouselController.ready && !lock) {
            carouselController.animateToPage(index);
          }
          _animatedMapController
              .animateTo(
            dest: data.geoLocation,
            offset: const Offset(0, -0),
          )
              .then((_) {
            setState(() {
              lock = false;
            });
          });
        });
      },
      bloc: bloc,
      child: Builder(
        builder: (context) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              PinnedHeaderSliver(
                child: Container(
                  height: kToolbarHeight + context.vTopSafeHeight,
                  decoration: BoxDecoration(
                    color: context.colorTheme.primaryContainer,
                    border: Border(
                      bottom: kExtraTinyBorder.copyWith(
                        color: context.colorTheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.zero.copyWith(
                    left: kMediumPadding.left,
                    right: kMediumPadding.left,
                    top: context.vTopSafeHeight + kTinyPadding.bottom,
                    bottom: kTinyPadding.bottom,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: AsyncSearchField<String>(
                        hintText: 'Search...',
                        items: const [],
                        onChanged: (query) {
                          bloc.filter(
                            _animatedMapController.mapController.camera.center,
                            query,
                          );
                        },
                        controller: filterController,
                        isLoading: false,
                        isEnabled: true,
                      )),
                      BlocBuilder<MapArtBloc, MapArtBlocState>(
                        bloc: bloc,
                        builder: (context, state) {
                          return FilterContainer(
                            controller: filterContainerController,
                            description: Padding(
                              padding: kMediumPadding,
                              child: Column(
                                children: [
                                  ...[
                                    Gap(kExtraTinyPadding.bottom),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Filters',
                                            style: context.typographyTheme.subtitleLarge
                                                .onBackground.textStyle,
                                          ),
                                        ),
                                        if (state.hasFilter)
                                          TextButton(
                                            style: ButtonStyle(
                                              foregroundColor: WidgetStateProperty.all(
                                                context.colorTheme.primary,
                                              ),
                                              padding:
                                                  WidgetStateProperty.all(EdgeInsets.zero),
                                              minimumSize: WidgetStateProperty.all(Size.zero),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            onPressed: bloc.resetFilters,
                                            child: const Text('Reset'),
                                          )
                                      ],
                                    ),
                                    Gap(kExtraTinyPadding.bottom),
                                    const Divider(),
                                    Gap(kExtraTinyPadding.bottom),
                                    Row(
                                      children: [
                                        Text(
                                          "Type",
                                          style: context.typographyTheme.subtitleMedium
                                              .onBackground.textStyle,
                                        ),
                                        const Spacer(),
                                        EntityTypeSwitch(
                                          initialSelected: state.type,
                                          onChanged: (type) {
                                            bloc.updateType(type);
                                          },
                                        ),
                                      ],
                                    ),
                                    Gap(kExtraTinyPadding.bottom),
                                    const Divider(),
                                    Gap(kExtraTinyPadding.bottom),
                                    Row(
                                      children: [
                                        Text(
                                          "Distance",
                                          style: context.typographyTheme.subtitleMedium
                                              .onBackground.textStyle,
                                        ),
                                        const Spacer(),
                                        DistanceSlider(
                                          initialValue: state.distance,
                                          onChanged: (d) => bloc.updateDistance(d),
                                        ),
                                      ],
                                    ),
                                    Gap(kExtraTinyPadding.bottom),
                                    const Divider(),
                                    Gap(kExtraTinyPadding.bottom),
                                    Expanded(
                                      child: CategoryGrid<CategoryAbstractModel>(
                                        items: (categoryBloc.state.categories ?? [])
                                            .where((c) =>
                                                state.type == null || c.type == state.type)
                                            .toList(),
                                        selectedItem: state.category,
                                        itemBuilder: (context, item, isSelected) {
                                          return InkWell(
                                            onTap: () {
                                              bloc.updateCategory(item);
                                            },
                                            borderRadius: kSmallBorderRadius,
                                            child: Container(
                                              padding: kTinyPadding,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? context.colorTheme.primary
                                                    : context
                                                        .colorTheme.chipDisabledBackground,
                                                borderRadius: kSmallBorderRadius,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  item.title,
                                                  style: context.typographyTheme
                                                      .subtitleMedium.onPrimary.textStyle,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                filterContainerController.toggle();
                              },
                              icon: const Icon(Icons.filter_list_sharp),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (showTabBar) PinnedHeaderSliver(child: _buildTabBar(context)),
              SliverFillRemaining(
                hasScrollBody: true,
                child: AbsorbPointer(
                  absorbing: filterContainerController.isVisible,
                  child: TabBarView(
                    clipBehavior: Clip.none,
                    viewportFraction: 1,
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
                            BlocBuilder<MapArtBloc, MapArtBlocState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return MarkerClusterLayerWidget(
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
                                );
                              },
                            ),
                            BlocBuilder<MapArtBloc, MapArtBlocState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return MarkerLayer(markers: [
                                  if (state.focusedArt != null)
                                    _buildSelectedMapMarker(state.focusedArt!, context),
                                ]);
                              },
                            ),
                            BlocBuilder<MapArtBloc, MapArtBlocState>(
                                bloc: bloc,
                                builder: (context, state) {
                                  final list = state.arts;
                                  if (list.isEmpty) return const SizedBox();
                                  final key = Key(list.hashCode.toString());
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: kLargePadding.bottom),
                                      child: CarouselSlider.builder(
                                        key: key,
                                        carouselController: carouselController,
                                        itemCount: list.length,
                                        itemBuilder: (context, index, pageViewIndex) {
                                          final data = list[index];
                                          final page = switch (data.entityType) {
                                            EntityType.art => ArtDetailScreen.name,
                                            EntityType.artist => ArtistDetailScreen.name,
                                            EntityType.news => NewsDetailScreen.name,
                                            EntityType.event => EventDetailScreen.name,
                                            EntityType.community =>
                                              CommunityDetailScreen.name,
                                            EntityType.unknown => null,
                                          };
                                          if (page == null) {
                                            // todo alert for update
                                            return const SizedBox();
                                          }
                                          return SearchableOnMapCardContainer.small(
                                            data: data,
                                            constraints: const BoxConstraints(),
                                            onTap: () {
                                              final homeUrl = navigator.homeUrl;
                                              navigator.homeContext.push(
                                                '$homeUrl/$page/${data.id}',
                                                extra: data.toJson(),
                                              );
                                            },
                                          );
                                        },
                                        options: CarouselOptions(
                                          onPageChanged: (index, reason) {
                                            if (reason == CarouselPageChangedReason.manual) {
                                              setState(() {
                                                lock = true;
                                              });
                                              bloc.setFocusedArt(list[index]);
                                            }
                                          },
                                          viewportFraction: 0.7,
                                          height: cardHeight,
                                          enableInfiniteScroll: list.length > 2,
                                          enlargeCenterPage: true,
                                          enlargeFactor: 0.3,
                                          clipBehavior: Clip.none,
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                            BlocBuilder<MapArtBloc, MapArtBlocState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: _buildRefreshButton(context, state),
                                );
                              },
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
                                          _animatedMapController.animatedRotateReset();
                                        },
                                        icon: Icon(
                                          Icons.explore_outlined,
                                          color: context.colorTheme.onPrimaryContainer,
                                        ),
                                      ),
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
                            // temp fix for bottom issue
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 1,
                                color: context.colorTheme.background,
                              ),
                            ),
                            const MapCopyrightInfo(),
                          ],
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
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

  Marker _buildSelectedMapMarker(SearchableAbstractModel selected, BuildContext context) {
    return Marker(
      width: 75,
      height: 75,
      alignment: Alignment.center,
      point: selected.geoLocation,
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

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  final void Function(double) onChanged;
  final double? initialValue;

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  late double x = (widget.initialValue ?? 100000) / 1000;

  @override
  void didUpdateWidget(covariant DistanceSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    x = (widget.initialValue ?? 100000) / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: x,
      min: 5,
      max: 100,
      divisions: 21,
      label: "${x.toInt()} km",
      onChanged: (double value) {
        setState(() {
          x = value;
        });
        widget.onChanged(value * 1000);
      },
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
      animationConfig: const FadeRAWA(), // Or `FadeRAWA` as is default
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
