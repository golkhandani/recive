part of 'map_section.dart';

class _MapContent extends StatefulHookWidget {
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
    useEffect(() {
      updateItems();

      if (widget.state.preSelectedEventIndex != 0) {
        return;
      }

      if (widget.state.loadingState != LoadingState.done ||
          widget.state.isRefreshLoading != false) {
        return;
      }
      locator.logger.w("GOING TO UPDATE MARKERS");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateMarkers();
        widget.mapController.animateTo(dest: items.first.latLng);
      });

      return;
    }, [widget.state.nearbyEvents]);

    return MultiSliver(children: [
      MapCardContainer(
        onPositionUpdated: (position) => {},
        clusterController: sc,
        markers: items.map((e) => e.latLng).toList(),
        selectedLatLng: items[widget.state.preSelectedEventIndex].latLng,
        isRefreshingData: widget.state.isRefreshLoading,
        onRefreshDataClicked: (mapBloc, mapState) {
          widget.bloc
              .loadNearbyEvents(
                latitude: mapState.center.latitude,
                longitude: mapState.center.longitude,
                maxDistance: (mapState.zoom * 10000).toInt(),
                minDistance: 0,
                onBackground: true,
              )
              .then(
                (value) => mapBloc.updateState(
                  mapState.copyWith(showRefresh: false),
                ),
              );
        },
        height: widget.mapSectionHeight,
        mapController: widget.mapController,
      )
    ]);
  }
}
