import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/map_card_container/flutter_map_search_refresh_button.dart';
import 'package:recive/components/map_card_container/map_card_container.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/widgets/selected_marker.dart';
import 'package:recive/layout/context_ui_extension.dart';

class NearbyMapContent extends StatefulHookWidget {
  const NearbyMapContent({
    super.key,
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
  State<NearbyMapContent> createState() => NearbyMapContentState();
}

class NearbyMapContentState extends State<NearbyMapContent> {
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
    widget.state.nearbyEvents.first.geoLocation,
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
            current.nearbyEvents[current.preSelectedEventIndex].geoLocation;
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
                  point.geoLocation,
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
            .state.nearbyEvents[widget.state.preSelectedEventIndex].geoLocation;
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
