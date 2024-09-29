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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  final carouselController = CarouselController(initialItem: 0);
  LatLng _center = const LatLng(51.5, -0.09);

  @override
  void initState() {
    bloc.init(_center);
    super.initState();
  }

  bool showFilters = false;
  double _currentSliderValue = 20;
  bool mapLocked = true;

  @override
  Widget build(BuildContext context) {
    final cardMaxWidth = context.vWidth / 1.2;
    final cardMaxHeight = context.vHeight / 5;
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
      listener: (context, state) {
        if (state.focusedArt == null) {
          return;
        }

        if (state.focusedArt!.geoLocation == _center) {
          return;
        }

        _center = state.focusedArt!.geoLocation;
        final i = state.arts.indexOf(state.focusedArt!);
        _animatedMapController
            .animateTo(dest: state.focusedArt!.geoLocation)
            .whenComplete(() => setState(() {
                  mapLocked = false;
                }));

        if (!mapLocked) {
          return;
        }
        carouselController.animateTo(
          i * cardMaxWidth,
          duration: kLoadingDuration,
          curve: Curves.bounceIn,
        );
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
            )),
            SliverFillRemaining(
              child: SizedBox(
                height: 300,
                width: 400,
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
                      bloc.filter(
                        e.camera.center,
                        _currentSliderValue,
                        filterController.text,
                      );
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
                      ...state.arts.map((ArtAbstractModel item) {
                        return Marker(
                          point: item.geoLocation,
                          width: 100,
                          height: 100,
                          child: InkWell(
                            onTap: () {
                              final i = state.arts.indexOf(item);
                              carouselController.animateTo(
                                i * cardMaxWidth,
                                duration: kLoadingDuration,
                                curve: Curves.bounceIn,
                              );
                              _animatedMapController.animateTo(dest: item.geoLocation);
                            },
                            child: Icon(
                              Icons.pin_drop_outlined,
                              color: context.colorTheme.primary,
                              size: 70,
                            ),
                          ),
                        );
                      }),
                      if (state.focusedArt != null)
                        Marker(
                          point: state.focusedArt!.geoLocation,
                          width: 100,
                          height: 100,
                          child: InkWell(
                            onTap: () {
                              final i = state.arts.indexOf(state.focusedArt!);
                              carouselController.animateTo(
                                i * cardMaxWidth,
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
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: cardMaxHeight + 16,
                          maxWidth: context.vWidth,
                        ),
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CarouselView(
                          controller: carouselController,
                          itemSnapping: true,
                          padding: kMediumPadding,
                          elevation: 1,
                          itemExtent: cardMaxWidth,
                          shrinkExtent: cardMaxWidth,
                          shape: RoundedRectangleBorder(borderRadius: kSmallBorderRadius),
                          onTap: (index) {
                            final data = state.arts[index];
                            final extraJson = ExtraData(
                              summary: ArtDetailSummaryData(
                                id: data.id,
                                title: data.title,
                                imageUrl: data.imageUrl,
                              ),
                              heroTag: index.toString(),
                            ).toJson((inner) => inner.toJson());
                            navigationService.pushTo(
                              NearMeScreen.name + ArtDetailScreen.name,
                              pathParameters: {
                                ArtDetailScreen.pathParamId: data.id,
                              },
                              extra: extraJson,
                            );
                          },
                          children: state.arts.map((ArtAbstractModel item) {
                            return VisibilityDetector(
                              key: Key(item.id),
                              onVisibilityChanged: (visibilityInfo) {
                                if (visibilityInfo.visibleFraction != 1) {
                                  return;
                                }
                                bloc.setFocusedArt(item);
                                _animatedMapController.animateTo(
                                  dest: item.geoLocation,
                                );
                              },
                              child: ArtOnMapCard(data: item),
                            );
                          }).toList(),
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
            )
          ],
        );
      },
    );
  }
}
