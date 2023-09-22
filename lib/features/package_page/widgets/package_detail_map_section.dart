import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/widgets/map_button.dart';
import 'package:recive/features/package_page/widgets/event_card_marker.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/flutter_map/flutter_map_attribution.dart';
import 'package:recive/layout/flutter_map/flutter_map_tile_layer.dart';
import 'package:recive/layout/flutter_map/flutter_map_user_marker.dart';

// Note: this thing need a major refactoring
// for now I have more important things to do

class PackageDetailMapSection extends StatefulHookWidget {
  const PackageDetailMapSection(
      {super.key, required this.events, required this.polyline});

  final List<ArtAbstractModel> events;
  final List<LatLng> polyline;

  @override
  State<PackageDetailMapSection> createState() =>
      _PackageDetailMapSectionState();
}

class _PackageDetailMapSectionState extends State<PackageDetailMapSection>
    with TickerProviderStateMixin {
  static const double maxZoom = 18;
  static const double minZoom = 10;

  late AnimatedMapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final geolocation = useLocationData(debugLabel: 'PackageDetailMapSection');

    final zoom = useState(15.0);
    final center = useState<LatLng?>(
      widget.events.firstOrNull?.geoLocation ?? geolocation?.latLng,
    );
    final index = useState<int?>(0);

    updateCenter() {
      if (index.value == null) {
        return;
      }
      center.value = widget.events[index.value!].geoLocation;
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
            child: RepaintBoundary(
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
                              MarkerLayer(
                                markers: [
                                  ...widget.events
                                      .mapIndexed(
                                        (i, e) => EventCardMarker(
                                          data: e,
                                          color: context.colorScheme.tertiary,
                                          fontColor:
                                              context.colorScheme.onTertiary,
                                          onTap: () => index.value = i,
                                        ).marker(context),
                                      )
                                      .toList(),
                                  if (index.value != null)
                                    EventCardMarker(
                                      data: widget.events[index.value!],
                                      color: context.colorScheme.primary,
                                      fontColor: context.colorScheme.onPrimary,
                                      onTap: null,
                                      useCompact: false,
                                    ).marker(context),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    FlutterMapLocalButtons(
                      mapController: mapController,
                      geolocation: geolocation,
                      zoom: zoom,
                      maxZoom: maxZoom,
                      minZoom: minZoom,
                    ),
                    FlutterMapItemControlButtons(
                      index: index,
                      itemMaxLength: widget.events.length - 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlutterMapItemControlButtons extends StatelessWidget {
  const FlutterMapItemControlButtons({
    super.key,
    required this.index,
    required this.itemMaxLength,
  });

  final ValueNotifier<int?> index;
  final int itemMaxLength;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                  if ((index.value ?? 0) >= itemMaxLength) {
                    return;
                  }

                  index.value = (index.value ?? 0) + 1;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlutterMapLocalButtons extends StatelessWidget {
  const FlutterMapLocalButtons({
    super.key,
    required this.mapController,
    required this.geolocation,
    required this.zoom,
    required this.maxZoom,
    required this.minZoom,
  });

  final AnimatedMapController mapController;
  final Position? geolocation;
  final ValueNotifier<double> zoom;
  final double maxZoom;
  final double minZoom;

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
    );
  }
}
