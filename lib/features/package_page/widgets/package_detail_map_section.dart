import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/widgets/map_button.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:latlong2/latlong.dart';

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
    final zoom = useState(10.0);
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
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (center.value != null) {
          mapController.animateTo(dest: center.value);
        }
      });
      index.addListener(updateCenter);
      return () => index.removeListener(updateCenter);
    }, [widget.events]);

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
              height: context.vHeight - 320,
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
                              UserMarker(geolocation: geolocation),
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

class EventCardMarker extends StatelessWidget {
  const EventCardMarker({
    super.key,
    required this.data,
    required this.color,
    required this.fontColor,
    required this.onTap,
    this.useCompact = true,
  });

  final NearbyEvent data;
  final Color color;
  final Color fontColor;
  final VoidCallback? onTap;
  final bool useCompact;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          height: useCompact ? 50 : 140,
          width: useCompact ? 50 : 280,
          point: data.latLng,
          rotate: true,
          builder: (ctx) => GestureDetector(
            onTap: onTap,
            child: CardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(4),
              color: color,
              child: Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: data.imageUrl,
                      placeholder: (context, _) => const SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            opacity: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  if (!useCompact) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            maxLines: 3,
                            style: context.labelLargeOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat.yMMMd().format(data.startDate),
                            maxLines: 1,
                            style: context.labelSmallOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.location,
                            maxLines: 2,
                            style: context.labelSmallOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
