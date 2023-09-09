part of 'map_section.dart';

class _MapContent extends StatefulHookWidget {
  static const double maxZoom = 18;
  static const double minZoom = 10;
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
            widget.bloc.changeSelectedIndex(index);
          },
          child: Icon(
            FluentIcons.location_12_filled,
            color: color,
            size: 24,
          ),
        ),
      );

  final SuperclusterMutableController sc = SuperclusterMutableController();

  late List<EventCardContainerData> items;

  @override
  void initState() {
    super.initState();
    updateItems();
  }

  List<EventCardContainerData> updateItems() {
    items = widget.state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();
    return items;
  }

  List<Marker> updateMarkers() {
    final updatedMarkers = items
        .mapIndexed(
          (index, data) => _createMarker(
            data.latLng,
            context.colorScheme.errorContainer,
            index,
          ),
        )
        .toList();
    sc.clear();
    sc.replaceAll(updatedMarkers);
    return updatedMarkers;
  }

  @override
  Widget build(BuildContext context) {
    final geolocation = useLocationData(debugLabel: 'MapContent');
    final mapBloc = useBloc<MapControlCubit>();
    final mapState = useBlocComparativeBuilder(
      mapBloc,
      buildWhen: (old, updated) {
        return old != updated;
      },
    );

    final positionUpdater = useDebounce<MapControlState>(
      debounceDelay: 500,
      callback: (val) => mapBloc.updateState(val),
    );

    useEffect(() {
      updateItems();

      if (widget.state.preSelectedEventIndex != 0) {
        mapBloc.updateState(mapState.copyWith(showRefresh: false));
        return;
      }
      if (widget.state.loadingState != LoadingState.done ||
          widget.state.isRefreshLoading != false) {
        return;
      }
      locator.logger.w("GOING TO UPDATE MARKERS");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateMarkers();
        widget.mapController.animateTo(dest: items.first.latLng).then((value) {
          mapBloc.updateState(mapState.copyWith(showRefresh: false));
        });
      });

      return;
    }, [widget.state.nearbyEvents]);

    return MultiSliver(children: [
      SliverCardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: kTinyPadding,
        sliver: SliverToBoxAdapter(
          child: RepaintBoundary(
            child: LayoutBuilder(builder: (context, box) {
              return Hero(
                tag: 'MapHeroTag',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orangeAccent,
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
                              center: mapState.center,
                              zoom: mapState.zoom,
                              adaptiveBoundaries: false,
                              keepAlive: true,
                              interactiveFlags: mapState.interations,
                              maxZoom: _MapContent.maxZoom,
                              minZoom: _MapContent.minZoom,
                              rotationThreshold: 45,
                              pinchMoveThreshold: 1,
                              pinchZoomThreshold: 45,
                              rotationWinGestures: MultiFingerGesture.rotate,
                              pinchZoomWinGestures:
                                  MultiFingerGesture.pinchZoom,
                              pinchMoveWinGestures:
                                  MultiFingerGesture.pinchMove,
                              onPositionChanged: (position, hasGesture) {
                                positionUpdater.onChanged(
                                  mapState.copyWith(
                                    showRefresh: true,
                                    center: position.center!,
                                    zoom: position.zoom!,
                                    mapInitialized: true,
                                  ),
                                );
                              },
                            ),
                            nonRotatedChildren: const [
                              FlutterMapAttribution(),
                            ],
                            children: [
                              const FlutterMapTileLayer(),
                              FutterMapClusterLayer(controller: sc),
                              SelectedMarker(
                                latLng:
                                    items[widget.state.preSelectedEventIndex]
                                        .latLng,
                              ),
                              if (geolocation != null) ...[
                                FlutterMapUserMarker(geolocation: geolocation),
                              ]
                            ],
                          ),
                        ),
                      ),
                      FlutterMapControlButtons(
                        mapController: widget.mapController,
                        geolocation: geolocation,
                        mapState: mapState,
                        mapBloc: mapBloc,
                      ),
                      if (mapState.showRefresh &&
                          mapState.center != items.first.latLng)
                        FlutterMapSearchRefreshButton(
                          geolocation: geolocation,
                          mapState: mapState,
                          searchState: widget.state,
                          searchBloc: widget.bloc,
                        )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      )
    ]);
  }
}

class FlutterMapSearchRefreshButton extends StatelessWidget {
  const FlutterMapSearchRefreshButton({
    super.key,
    required this.geolocation,
    required this.mapState,
    required this.searchState,
    required this.searchBloc,
  });

  final Position? geolocation;
  final MapControlState mapState;
  final NearbyEventsState searchState;
  final NearbyEventsCubit searchBloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 12,
      child: MapButton(
        text: 'Search in this area!',
        icon: Icons.refresh,
        isLoading: searchState.isRefreshLoading,
        onClicked: () {
          if (geolocation != null) {
            searchBloc.loadNearbyEvents(
              latitude: mapState.center.latitude,
              longitude: mapState.center.longitude,
              maxDistance: (mapState.zoom * 10000).toInt(),
              minDistance: 0,
              onBackground: true,
            );
          }
        },
      ),
    );
  }
}

class FutterMapClusterLayer extends StatelessWidget {
  const FutterMapClusterLayer({
    super.key,
    required this.controller,
  });

  final SuperclusterMutableController controller;

  @override
  Widget build(BuildContext context) {
    return SuperclusterLayer.mutable(
      initialMarkers: const [],
      controller: controller,
      loadingOverlayBuilder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      indexBuilder: IndexBuilders.rootIsolate,
      clusterWidgetSize: const Size(40, 40),
      maxClusterRadius: 40,
      minimumClusterSize: 2,
      anchor: AnchorPos.align(AnchorAlign.center),
      calculateAggregatedClusterData: true,
      builder: (context, position, markerCount, extraClusterData) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: context.colorScheme.errorContainer,
          ),
          child: Center(
            child: Text(
              markerCount.toString(),
              style: TextStyle(
                color: context.colorScheme.onErrorContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FlutterMapControlButtons extends StatelessWidget {
  const FlutterMapControlButtons({
    super.key,
    required this.geolocation,
    required this.mapState,
    required this.mapBloc,
    required this.mapController,
  });

  final Position? geolocation;
  final MapControlState mapState;
  final MapControlCubit mapBloc;
  final AnimatedMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                if (mapState.zoom > _MapContent.maxZoom) {
                  return;
                }
                final updatedZoom = mapState.zoom + 1;
                mapBloc.updateState(
                  mapState.copyWith(zoom: updatedZoom),
                );
                mapController.animatedZoomTo(
                  updatedZoom,
                );
              },
            ),
            MapButton(
              icon: Icons.zoom_out,
              onClicked: () {
                if (mapState.zoom < _MapContent.minZoom) {
                  return;
                }
                final updatedZoom = mapState.zoom - 1;
                mapBloc.updateState(
                  mapState.copyWith(zoom: updatedZoom),
                );
                mapController.animatedZoomTo(
                  updatedZoom,
                );
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
    );
  }
}
