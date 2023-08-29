import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
// import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class HomePageMapSection extends StatefulHookWidget {
  const HomePageMapSection({
    super.key,
  });

  @override
  State<HomePageMapSection> createState() => _HomePageMapSectionState();
}

class _HomePageMapSectionState extends State<HomePageMapSection>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final geolocation = useLocationData(debugLabel: 'HomePageMapSection');
    final center = useState<LatLng?>(geolocation?.latLng);
    final zoom = useState(15.0);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    useEffect(() {
      if (geolocation != null) {
        final updatedCenter = LatLng(
          geolocation.latitude,
          geolocation.longitude,
        );

        if (center.value == null) {
          center.value = updatedCenter;
          return;
        }

        if (center.value!.latitude != updatedCenter.latitude ||
            center.value!.longitude != updatedCenter.longitude) {
          center.value = updatedCenter;
          return;
        }
      }
      return;
    }, [geolocation?.timestamp]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (center.value != null) {
        mapController.animateTo(dest: center.value);
      }
    });

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "City Highlights (Map)",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: Hero(
              tag: 'MapHeroTag',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  navigationService.navigateTo(NearMeScreen.name);
                },
                child: AbsorbPointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    height: 200,
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
                                  maxZoom: 17,
                                  minZoom: 10,
                                ),
                                nonRotatedChildren: const [
                                  FlutterMapAttribution(),
                                ],
                                children: [
                                  const FlutterMapTileLayer(),
                                  if (geolocation != null)
                                    UserMarker(geolocation: geolocation),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlutterMapTileLayer extends StatelessWidget {
  const FlutterMapTileLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate:
          'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}.png?key=cKGhx1kSOrw1anX1ljgw',
      tileProvider: FMTC.instance('FlutterMapTileStore').getTileProvider(),
    );
  }
}

class FlutterMapAttribution extends StatelessWidget {
  const FlutterMapAttribution({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichAttributionWidget(
      attributions: [
        TextSourceAttribution(
          'OpenStreetMap contributors',
          onTap: () => launchUrl(Uri.parse(
            'https://openstreetmap.org/copyright',
          )),
        ),
      ],
    );
  }
}
