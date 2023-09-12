import 'package:flutter/material.dart';

import 'package:debounce_hook/debounce_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/components/map_card_container/cubit/map_control_cubit.dart';
import 'package:recive/components/map_card_container/flutter_map_control_buttons.dart';
import 'package:recive/components/map_card_container/flutter_map_search_refresh_button.dart';
import 'package:recive/components/map_card_container/futter_map_cluster_layer.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/features/near_me_page/widgets/selected_marker.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/flutter_map/flutter_map_attribution.dart';
import 'package:recive/layout/flutter_map/flutter_map_tile_layer.dart';
import 'package:recive/layout/flutter_map/flutter_map_user_marker.dart';
import 'package:recive/layout/ui_constants.dart';

class MapCardContainer extends StatefulHookWidget {
  static const double maxZoom = 18;
  static const double minZoom = 10;
  const MapCardContainer({
    super.key,
    this.onPositionUpdated,
    this.clusterController,
    this.mapController,
    this.markers = const [],
    required this.height,
    this.selectedLatLng,
    this.isRefreshingData = false,
    this.onRefreshDataClicked,
    this.onMapContainerCliked,
    this.showControls = true,
    this.userLocationCentered = false,
  });

  final double height;
  final SuperclusterMutableController? clusterController;
  final List<LatLng> markers;

  final Function(MapPosition)? onPositionUpdated;
  final AnimatedMapController? mapController;
  final LatLng? selectedLatLng;
  final bool isRefreshingData;
  final Function(MapControlCubit, MapControlState)? onRefreshDataClicked;
  final VoidCallback? onMapContainerCliked;
  final bool showControls;
  final bool userLocationCentered;

  @override
  State<MapCardContainer> createState() => _MapCardContainerState();
}

class _MapCardContainerState extends State<MapCardContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller =
        widget.mapController ?? AnimatedMapController(vsync: this);
    final geolocation = useLocationData(debugLabel: 'MapCardContainer');

    final mapBloc = useBloc<MapControlCubit>();
    final mapState = useBlocComparativeBuilder(
      mapBloc,
      buildWhen: (old, updated) {
        return old != updated;
      },
    );
    final positionUpdater = useDebounce<MapControlState>(
      debounceDelay: 300,
      callback: (val) => mapBloc.updateState(val),
    );

    useEffect(() {
      if (geolocation != null) {
        final updatedCenter = LatLng(
          geolocation.latitude,
          geolocation.longitude,
        );

        final center = mapState.center;

        if (center.latitude != updatedCenter.latitude ||
            center.longitude != updatedCenter.longitude) {
          mapBloc.updateState(mapState.copyWith(userLocation: center));
        }
      }
      return;
    }, [geolocation?.timestamp]);

    if (widget.userLocationCentered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (geolocation.latLng != null) {
          mapBloc.updateState(mapState.copyWith(
            userLocation: geolocation.latLng!,
          ));
          final center = geolocation.latLng;
          controller.animateTo(dest: center);
        }
      });
    }

    return SliverCardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: kTinyPadding,
      sliver: SliverToBoxAdapter(
        child: RepaintBoundary(
          child: LayoutBuilder(builder: (context, box) {
            final mapContainer = Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.orangeAccent,
              ),
              width: box.maxWidth,
              height: widget.height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FlutterMap(
                        mapController: controller.mapController,
                        options: MapOptions(
                          center: mapState.center,
                          zoom: mapState.zoom,
                          adaptiveBoundaries: false,
                          keepAlive: true,
                          interactiveFlags: mapState.interations,
                          maxZoom: MapCardContainer.maxZoom,
                          minZoom: MapCardContainer.minZoom,
                          rotationThreshold: 45,
                          pinchMoveThreshold: 1,
                          pinchZoomThreshold: 45,
                          rotationWinGestures: MultiFingerGesture.rotate,
                          pinchZoomWinGestures: MultiFingerGesture.pinchZoom,
                          pinchMoveWinGestures: MultiFingerGesture.pinchMove,
                          onPositionChanged: (position, hasGesture) {
                            if (widget.onMapContainerCliked != null) {
                              return;
                            }
                            final isSameLatLng = widget.markers.isNotEmpty &&
                                position.center != widget.markers.first;
                            positionUpdater.onChanged(
                              mapState.copyWith(
                                showRefresh:
                                    isSameLatLng && mapState.mapInitialized,
                                center: position.center!,
                                zoom: position.zoom!,
                                mapInitialized: true,
                              ),
                            );
                            widget.onPositionUpdated?.call(position);
                          },
                        ),
                        nonRotatedChildren: const [
                          FlutterMapAttribution(),
                        ],
                        children: [
                          const FlutterMapTileLayer(),
                          FutterMapClusterLayer(
                            controller: widget.clusterController,
                          ),
                          if (widget.selectedLatLng != null)
                            SelectedMarker(latLng: widget.selectedLatLng!),
                          if (geolocation != null) ...[
                            FlutterMapUserMarker(geolocation: geolocation),
                          ]
                        ],
                      ),
                    ),
                  ),
                  if (widget.showControls)
                    FlutterMapControlButtons(
                      mapController: controller,
                      mapState: mapState,
                      mapBloc: mapBloc,
                    ),
                  if (mapState.showRefresh &&
                      widget.onRefreshDataClicked != null)
                    FlutterMapSearchRefreshButton(
                      isRefreshingData: widget.isRefreshingData,
                      onRefreshDataClicked: () => widget.onRefreshDataClicked!(
                        mapBloc,
                        mapState,
                      ),
                    )
                ],
              ),
            );
            if (widget.onMapContainerCliked != null) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onMapContainerCliked,
                child: AbsorbPointer(
                  child: mapContainer,
                ),
              );
            }
            return Hero(
              tag: 'MapHeroTag',
              child: mapContainer,
            );
          }),
        ),
      ),
    );
  }
}
