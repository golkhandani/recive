import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';

import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';

import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/home_page/sections/map_section.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container.dart';
import 'package:recive/ioc/geo_location_service.dart';
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
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: MultiSliver(
        children: [
          _MapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            bloc: bloc,
          ),
          const SliverGap(height: 12),
          _CarouselContent(
            switchIndex: switchIndex,
            listSectionHeight: listSectionHeight,
            mapController: mapController,
            bloc: bloc,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}

class _MapContent extends StatefulHookWidget {
  static const double maxZoom = 18;
  static const double minZoom = 10;
  static const double initalZoom = 15;
  const _MapContent({
    required this.mapSectionHeight,
    required this.mapController,
    required this.bloc,
  });

  final double mapSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  State<_MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<_MapContent> {
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
            print("CHANGE ON MAP $index");
            widget.bloc.changeSelectedIndex(index);
          },
          child: Iconify(
            Bx.bxs_map,
            color: color,
            size: 50,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final state = useBlocBuilder(widget.bloc);
    final items = state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();

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

    final markers = items
        .mapIndexed(
          (index, data) => _createMarker(
            data.latLng,
            Colors.deepOrange,
            index,
          ),
        )
        .toList();

    useEffect(() {
      if (geolocation != null) {
        ltlg = LatLng(
          geolocation.latitude,
          geolocation.longitude,
        );
      }

      return;
    }, [geolocation?.timestamp]);

    // useEffect(() {
    //   if (geolocation != null)
    //     widget.bloc.loadNearbyEvents(
    //       latitude: geolocation.latitude,
    //       longitude: geolocation.longitude,
    //       maxDistance: (zoom.value * 10000).toInt(), // 10000000,
    //       minDistance: 0,
    //     );
    //   return;
    // }, [zoom.value]);

    // useEffectOnce(() {
    //   // widget.mapController.mapController.l
    // });

    final showRefresh = useState(false);

    return MultiSliver(children: [
      SliverCardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        sliver: SliverToBoxAdapter(
          child: LayoutBuilder(builder: (context, box) {
            return Hero(
              tag: 'MapHeroTag',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                width: box.maxWidth,
                height: widget.mapSectionHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FlutterMap(
                          mapController: widget.mapController.mapController,
                          options: MapOptions(
                              center: center.value,
                              zoom: zoom.value,
                              adaptiveBoundaries: false,
                              keepAlive: true,
                              maxZoom: _MapContent.maxZoom,
                              minZoom: _MapContent.minZoom,
                              onPositionChanged: (position, hasGesture) {
                                showRefresh.value = true;
                                center.value = position.center!;
                                zoom.value = position.zoom!;
                              }),
                          nonRotatedChildren: const [
                            FlutterMapAttribution(),
                          ],
                          children: [
                            const FlutterMapTileLayer(),
                            if (geolocation != null)
                              UserMarker(geolocation: geolocation),
                            SuperclusterLayer.mutable(
                              initialMarkers: markers,
                              indexBuilder: IndexBuilders.rootIsolate,
                              clusterWidgetSize: const Size(40, 40),
                              maxClusterRadius: 40,
                              minimumClusterSize: 4,
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
                                    color: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      markerCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SelectedMarker(
                              latLng: items[state.preSelectedEventIndex].latLng,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            MapButton(
                                icon: Icons.center_focus_strong,
                                onClicked: () {
                                  widget.mapController.animateTo(
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
                                widget.mapController.animatedZoomTo(zoom.value);
                              },
                            ),
                            MapButton(
                              icon: Icons.zoom_out,
                              onClicked: () {
                                if (zoom.value < _MapContent.minZoom) {
                                  return;
                                }
                                zoom.value = zoom.value - 1;
                                widget.mapController.animatedZoomTo(zoom.value);
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
                          icon: Icons.refresh,
                          onClicked: () {
                            if (geolocation != null)
                              widget.bloc.loadNearbyEvents(
                                latitude: center.value.latitude,
                                longitude: center.value.longitude,
                                maxDistance: (zoom.value * 10000).toInt(),
                                minDistance: 0,
                                onBackground: true,
                              );
                            showRefresh.value = false;
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

class _CarouselContent extends StatefulHookWidget {
  const _CarouselContent({
    required this.switchIndex,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
  });

  final ValueNotifier<int> switchIndex;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  State<_CarouselContent> createState() => _CarouselContentState();
}

class _CarouselContentState extends State<_CarouselContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isUpdating = useState(false);
    final state = useBlocBuilder(widget.bloc);
    final items = state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();

    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      widget.bloc,
      (_, state, context) {
        if (!isUpdating.value) {
          isUpdating.value = true;
          controller.animateToPage(state.preSelectedEventIndex);
        }
        widget.mapController
            .animateTo(
              dest: items[state.preSelectedEventIndex].latLng,
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
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              // Warning: To prevent rebuild issue
              // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
              final list = items
                  .mapIndexed((index, data) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: EventCardContainer(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 1.1,
                          ),
                          data: data,
                        ),
                      ))
                  .toList();
              return FlutterCarousel.builder(
                options: CarouselOptions(
                  controller: controller,
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: .7,
                  height: widget.listSectionHeight,
                  indicatorMargin: 12.0,
                  enableInfiniteScroll: true,
                  showIndicator: false,
                  padEnds: true,
                  onPageChanged: (index, reason) {
                    if (!isUpdating.value) {
                      isUpdating.value = true;
                      widget.bloc.changeSelectedIndex(index);
                      // widget.mapController.animateTo(
                      //   dest: items[state.preSelectedEventIndex].latLng,
                      // );
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
