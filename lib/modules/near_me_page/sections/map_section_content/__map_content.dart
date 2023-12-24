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

import 'package:recive/core/components/flutter_map_card_container/flutter_map_search_refresh_button.dart';
import 'package:recive/core/components/flutter_map_card_container/map_card_container.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/widgets/empty_result_snackbar.dart';
import 'package:recive/modules/near_me_page/widgets/selected_marker.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

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
  final NearbyCubit bloc;
  final NearbyState state;

  @override
  State<NearbyMapContent> createState() => NearbyMapContentState();
}

class NearbyMapContentState extends State<NearbyMapContent> {
  void showEmptySnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(emptySearchResultSnackbar);
  }

  Marker _createMarker(
    BuildContext context,
    LatLng point,
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
            color: context.colorTheme.tertiaryContainer,
            size: 50,
          ),
        ),
      );

  late final SelectedMarker2Controller sc = SelectedMarker2Controller(
    widget.state.loadingState == LoadingState.done &&
            widget.state.nearbyArts.isNotEmpty
        ? widget.state.nearbyArts.first.geoLocation
        : widget.state.defautlPoint,
  );

  late final FlutterMapMarkerClusterLayerController fc =
      FlutterMapMarkerClusterLayerController();

  late final FlutterMapSearchRefreshController fr =
      FlutterMapSearchRefreshController();

  @override
  Widget build(BuildContext context) {
    useBlocComparativeListener<NearbyCubit, NearbyState>(
      widget.bloc,
      (bloc, current, context) {
        final newPos = current.nearbyArts[current.preSelectedIndex].geoLocation;
        widget.mapController.animateTo(
          dest: newPos,
        );
        sc.updateValue(newPos);
      },
      listenWhen: (old, updated) {
        return old.preSelectedIndex != updated.preSelectedIndex;
      },
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fc.updateValue(
          widget.state.nearbyArts
              .mapIndexed(
                (index, point) => _createMarker(
                  context,
                  point.geoLocation,
                  index,
                ),
              )
              .toList(),
        );

        if (widget.state.loadingState != LoadingState.done ||
            widget.state.isRefreshLoading != false) {
          return;
        }
        final updated = widget.state.nearbyArts.isEmpty
            ? widget.state.defautlPoint
            : widget
                .state.nearbyArts[widget.state.preSelectedIndex].geoLocation;
        sc.updateValue(updated);
        widget.mapController.animateTo(dest: updated);
      });

      return;
    }, [widget.state.nearbyArts]);

    return MultiSliver(children: [
      Builder(builder: (context) {
        return MapCardContainer(
          onPositionUpdated: (position) => {},
          onRefreshDataClicked: (mapBloc, mapState) {
            fr.updateValue(true);
            widget.bloc
                .loadNearbyArts(
                  latitude: mapState.center.latitude,
                  longitude: mapState.center.longitude,
                  maxDistance: mapState.zoom * 10000,
                  minDistance: 0,
                  onBackground: true,
                  callback: (isEmpty) => isEmpty ? showEmptySnackBar() : null,
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
