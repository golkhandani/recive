import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/layout/flutter_map/flutter_map_attribution.dart';
import 'package:recive/layout/flutter_map/flutter_map_tile_layer.dart';
import 'package:recive/layout/flutter_map/flutter_map_user_marker.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/widgets/map_button.dart';
import 'package:recive/features/package_page/widgets/event_card_marker.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';

class PackageDetailMapSection extends StatefulHookWidget {
  const PackageDetailMapSection(
      {super.key, required this.events, required this.polyline});

  final List<NearbyEvent> events;
  final List<LatLng> polyline;

  @override
  State<PackageDetailMapSection> createState() =>
      _PackageDetailMapSectionState();
}

class _PackageDetailMapSectionState extends State<PackageDetailMapSection>
    with TickerProviderStateMixin {
  static const double maxZoom = 18;
  static const double minZoom = 10;

  @override
  Widget build(BuildContext context) {
    final geolocation = useLocationData(debugLabel: 'PackageDetailMapSection');
    final zoom = useState(15.0);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
    final center = useState<LatLng?>(
      widget.events.firstOrNull?.latLng ?? geolocation?.latLng,
    );

    final index = useState<int?>(null);
    updateCenter() {
      if (index.value == null) {
        return;
      }
      center.value = widget.events[index.value!].latLng;
      mapController.animateTo(dest: center.value);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (center.value != null) {
          mapController.animateTo(dest: center.value);
        }
      });
      index.addListener(updateCenter);
      return () => index.removeListener(updateCenter);
    }, []);

    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.orange,
              ),
              height: context.vHeight - 480,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Builder(builder: (context) {
                        return FlutterMap(
                          mapController: mapController.mapController,
                          options: MapOptions(
                            center: center.value,
                            zoom: zoom.value,
                            adaptiveBoundaries: false,
                            keepAlive: true,
                            maxZoom: maxZoom,
                            minZoom: minZoom,
                            interactiveFlags: InteractiveFlag.pinchMove |
                                InteractiveFlag.drag,
                            onMapEvent: (e) {
                              if (e.source == MapEventSource.mapController) {
                                return;
                              }
                              index.value = null;
                            },
                          ),
                          nonRotatedChildren: const [
                            FlutterMapAttribution(),
                          ],
                          children: [
                            const FlutterMapTileLayer(),
                            if (geolocation != null) ...[
                              FlutterMapUserMarker(geolocation: geolocation),
                            ],
                            if (widget.polyline.isNotEmpty)
                              Builder(builder: (context) {
                                return PolylineLayer(
                                  polylines: [
                                    Polyline(
                                      points: widget.polyline,
                                      color: Colors.pink,
                                      strokeWidth: 5,
                                    ),
                                  ],
                                );
                              }),
                            ...widget.events.mapIndexed(
                              (i, e) => EventCardMarker(
                                data: e,
                                color: context.colorScheme.tertiary,
                                fontColor: context.colorScheme.onTertiary,
                                onTap: () => index.value = i,
                              ),
                            ),
                            if (index.value != null)
                              EventCardMarker(
                                data: widget.events[index.value!],
                                color: context.colorScheme.primary,
                                fontColor: context.colorScheme.onPrimary,
                                onTap: null,
                                useCompact: false,
                              ),
                          ],
                        );
                      }),
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
                              if (zoom.value > maxZoom) {
                                return;
                              }
                              zoom.value = zoom.value + 1;
                              mapController.animatedZoomTo(zoom.value);
                            },
                          ),
                          MapButton(
                            icon: Icons.zoom_out,
                            onClicked: () {
                              if (zoom.value < minZoom) {
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
                  Positioned(
                    top: 0,
                    right: 42,
                    left: 42,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MapButton(
                              text: 'Previous',
                              icon: Icons.navigate_before,
                              onClicked: () {
                                if ((index.value ?? 0) <= 0) {
                                  return;
                                }
                                index.value = (index.value ?? 0) - 1;
                              },
                            ),
                          ),
                          MapButton(
                              icon: Icons.filter_tilt_shift_rounded,
                              onClicked: () {
                                index.value = 0;
                              }),
                          Expanded(
                            child: MapButton(
                                text: 'Next',
                                textPosition: MapButtonTextPosition.left,
                                icon: Icons.navigate_next,
                                onClicked: () {
                                  if ((index.value ?? 0) >=
                                      widget.events.length - 1) {
                                    return;
                                  }

                                  index.value = (index.value ?? 0) + 1;
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
