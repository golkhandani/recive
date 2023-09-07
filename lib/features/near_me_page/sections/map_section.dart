import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container.dart';
import 'package:recive/features/near_me_page/widgets/map_button.dart';
import 'package:recive/features/near_me_page/widgets/selected_marker.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NearMeScreenMapViewContent extends HookWidget {
  const NearMeScreenMapViewContent({
    super.key,
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
    required this.state,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;
  final NearbyEventsState state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2),
      sliver: MultiSliver(
        children: [
          _MapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 12),
          _CarouselContent(
            switchIndex: switchIndex,
            listSectionHeight: listSectionHeight,
            mapController: mapController,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}

class _MapContent extends HookWidget {
  static const double maxZoom = 18;
  static const double minZoom = 10;
  static const double initalZoom = 15;
  const _MapContent({
    required this.mapSectionHeight,
    required this.mapController,
    required this.bloc,
    required this.state,
  });

  final double mapSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;
  final NearbyEventsState state;

  Marker _createMarker(
    LatLng point,
    Color color,
    int index,
  ) =>
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        rotateAlignment: AnchorAlign.top.rotationAlignment,
        height: 50,
        width: 50,
        point: point,
        rotate: true,
        builder: (ctx) => InkWell(
          onTap: () {
            bloc.changeSelectedIndex(index);
          },
          child: Iconify(
            Bx.bxs_map,
            color: color,
            size: 50,
          ),
        ),
      );

  List<EventCardContainerData> calcItems() {
    return state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<EventCardContainerData> items = calcItems();

    if (kDebugMode) {
      print('_________________| build _MapContent');
    }
    LatLng? ltlg;
    const defaultPosition = LatLng(51.509364, -0.128928);
    final geolocation = useLocationData(debugLabel: 'MapContent');
    final zoom = useState(_MapContent.initalZoom);

    final center = useState(
      items.isNotEmpty ? items.first.latLng : (ltlg ?? defaultPosition),
    );

    List<Marker> markers = items
        .mapIndexed(
          (index, data) => _createMarker(
            data.latLng,
            context.colorScheme.errorContainer,
            index,
          ),
        )
        .toList();

    final showRefresh = useState(false);
    final isRefreshLoading = useState(false);
    final mapInitialized = useState(false);

    useEffect(() {
      if (geolocation != null) {
        ltlg = LatLng(
          geolocation.latitude,
          geolocation.longitude,
        );
      }
      return;
    }, [geolocation?.timestamp]);

    useEffect(() {
      if (state.preSelectedEventIndex != 0) {
        items = calcItems();
        showRefresh.value = false;
        isRefreshLoading.value = false;
        return;
      }
      if (state.loadingState != LoadingState.done) {
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.animateTo(dest: items.first.latLng).then((value) {
          showRefresh.value = false;
          isRefreshLoading.value = false;
        });
      });

      return;
    }, [state.nearbyEvents]);

    final interations = useState(InteractiveFlag.all & ~InteractiveFlag.rotate);

    return MultiSliver(children: [
      SliverCardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: kTinyPadding,
        sliver: SliverToBoxAdapter(
          child: LayoutBuilder(builder: (context, box) {
            return Hero(
              tag: 'MapHeroTag',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orangeAccent,
                ),
                width: box.maxWidth,
                height: mapSectionHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FlutterMap(
                          mapController: mapController.mapController,
                          options: MapOptions(
                            center: center.value,
                            zoom: zoom.value,
                            adaptiveBoundaries: false,
                            keepAlive: true,
                            interactiveFlags: interations.value,
                            maxZoom: _MapContent.maxZoom,
                            minZoom: _MapContent.minZoom,
                            rotationThreshold: 45,
                            pinchMoveThreshold: 1,
                            pinchZoomThreshold: 45,
                            rotationWinGestures: MultiFingerGesture.rotate,
                            pinchZoomWinGestures: MultiFingerGesture.pinchZoom,
                            pinchMoveWinGestures: MultiFingerGesture.pinchMove,
                            onPositionChanged: (position, hasGesture) {
                              showRefresh.value = true;
                              center.value = position.center!;
                              zoom.value = position.zoom!;
                              mapInitialized.value = true;
                            },
                          ),
                          nonRotatedChildren: const [
                            FlutterMapAttribution(),
                          ],
                          children: [
                            const FlutterMapTileLayer(),
                            SuperclusterLayer.mutable(
                              initialMarkers: markers,
                              indexBuilder: IndexBuilders.rootIsolate,
                              clusterWidgetSize: const Size(40, 40),
                              maxClusterRadius: 40,
                              minimumClusterSize: 2,
                              anchor: AnchorPos.align(AnchorAlign.center),
                              calculateAggregatedClusterData: true,
                              builder: (
                                context,
                                position,
                                markerCount,
                                extraClusterData,
                              ) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: context.colorScheme.errorContainer,
                                  ),
                                  child: Center(
                                    child: Text(
                                      markerCount.toString(),
                                      style: TextStyle(
                                        color: context
                                            .colorScheme.onErrorContainer,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SelectedMarker(
                              latLng: items[state.preSelectedEventIndex].latLng,
                            ),
                            if (geolocation != null) ...[
                              UserMarker(geolocation: geolocation),
                            ]
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            MapButton(
                                icon: Icons.center_focus_strong,
                                onClicked: () {
                                  mapController.animateTo(
                                    dest: geolocation?.latLng,
                                  );
                                }),
                            MapButton(
                              icon: Icons.zoom_in,
                              onClicked: () {
                                if (zoom.value > _MapContent.maxZoom) {
                                  return;
                                }
                                zoom.value = zoom.value + 1;
                                mapController.animatedZoomTo(zoom.value);
                              },
                            ),
                            MapButton(
                              icon: Icons.zoom_out,
                              onClicked: () {
                                if (zoom.value < _MapContent.minZoom) {
                                  return;
                                }
                                zoom.value = zoom.value - 1;
                                mapController.animatedZoomTo(zoom.value);
                              },
                            ),
                            MapButton(
                              icon: Icons.near_me_outlined,
                              onClicked: () {
                                mapController.animatedRotateReset();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (showRefresh.value)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: MapButton(
                          text: 'Search in this area!',
                          icon: Icons.refresh,
                          isLoading: isRefreshLoading.value,
                          onClicked: () {
                            if (geolocation != null) {
                              isRefreshLoading.value = true;
                              bloc.loadNearbyEvents(
                                latitude: center.value.latitude,
                                longitude: center.value.longitude,
                                maxDistance: (zoom.value * 10000).toInt(),
                                minDistance: 0,
                                onBackground: true,
                              );
                            }
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
        ),
      )
    ]);
  }
}

class _CarouselContent extends HookWidget {
  const _CarouselContent({
    required this.switchIndex,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
    required this.state,
  });

  final ValueNotifier<int> switchIndex;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;
  final NearbyEventsState state;

  List<EventCardContainerData> calcItems() {
    return state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();

    final isUpdating = useState(false);
    List<EventCardContainerData> items = calcItems();

    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      bloc,
      (_, state, context) {
        if (!isUpdating.value) {
          isUpdating.value = true;
          controller.animateToPage(state.preSelectedEventIndex);
        }
        mapController
            .animateTo(
              dest: state.nearbyEvents[state.preSelectedEventIndex].latLng,
            )
            .then((value) => isUpdating.value = false);
        isUpdating.value = false;
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedEventIndex !=
          currentState.preSelectedEventIndex,
    );

    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              // Warning: To prevent rebuild issue
              // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
              final list = items
                  .mapIndexed((index, data) => EventCardContainer(
                        constraints: BoxConstraints.expand(
                          width: box.maxWidth / 1.1,
                        ),
                        data: data,
                      ))
                  .toList();
              return FlutterCarousel.builder(
                options: CarouselOptions(
                  controller: controller,
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: .8,
                  height: listSectionHeight,
                  indicatorMargin: 8.0,
                  enableInfiniteScroll: true,
                  showIndicator: false,
                  padEnds: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    if (!isUpdating.value) {
                      isUpdating.value = true;
                      bloc.changeSelectedIndex(index);
                    }
                  },
                ),
                itemCount: items.length,
                itemBuilder: (context, index, _) {
                  return list[index];
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
