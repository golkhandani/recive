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
    int? index,
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
            if (index == null) return;
            widget.bloc.changeSelectedIndex(index);
          },
          child: Icon(
            FluentIcons.location_12_filled,
            color: color,
            size: 50,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  late final SelectedMarker2Controller sc = SelectedMarker2Controller(
    widget.state.nearbyEvents.first.latLng,
  );

  late final FlutterMapMarkerClusterLayerController fc =
      FlutterMapMarkerClusterLayerController();

  late final FlutterMapSearchRefreshController fr =
      FlutterMapSearchRefreshController();

  @override
  Widget build(BuildContext context) {
    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      widget.bloc,
      (bloc, current, context) {
        final newPos =
            current.nearbyEvents[current.preSelectedEventIndex].latLng;
        widget.mapController.animateTo(
          dest: newPos,
        );
        sc.updateValue(newPos);
      },
      listenWhen: (old, updated) {
        return old.preSelectedEventIndex != updated.preSelectedEventIndex;
      },
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fc.updateValue(
          widget.state.nearbyEvents
              .mapIndexed(
                (index, point) => _createMarker(
                  point.latLng,
                  context.colorScheme.errorContainer,
                  index,
                ),
              )
              .toList(),
        );

        if (widget.state.loadingState != LoadingState.done ||
            widget.state.isRefreshLoading != false) {
          return;
        }
        final updated = widget
            .state.nearbyEvents[widget.state.preSelectedEventIndex].latLng;
        sc.updateValue(updated);
        widget.mapController.animateTo(dest: updated);
      });

      return;
    }, [widget.state.nearbyEvents]);

    return MultiSliver(children: [
      Builder(builder: (context) {
        return MapCardContainer(
          onPositionUpdated: (position) => {},
          onRefreshDataClicked: (mapBloc, mapState) {
            fr.updateValue(true);
            widget.bloc
                .loadNearbyEvents(
                  latitude: mapState.center.latitude,
                  longitude: mapState.center.longitude,
                  maxDistance: mapState.zoom * 10000,
                  minDistance: 0,
                  onBackground: true,
                )
                .then((value) => fr.updateValue(false))
                .then(
                  (value) => mapBloc.updateState(
                    mapState.copyWith(showRefresh: false),
                  ),
                );
          },
          height: widget.mapSectionHeight,
          mapController: widget.mapController,
          selectedController: sc,
          markersController: fc,
          refreshController: fr,
        );
      })
    ]);
  }
}
