import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_use_geolocation/flutter_use_geolocation.dart';
import 'package:location/location.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class PageViewKeepAlive extends StatefulWidget {
  const PageViewKeepAlive({super.key, required this.data});

  final String data;

  @override
  State<PageViewKeepAlive> createState() => _PageViewKeepAliveState();
}

class _PageViewKeepAliveState extends State<PageViewKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(widget.data);
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NearMeScreen extends StatefulHookWidget {
  static const name = 'near_me';
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen>
    with TickerProviderStateMixin {
  final Location location = Location();
  bool? _serviceEnabled;
  Future<void> _checkService() async {
    final serviceEnabledResult = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
  }

  Future<void> _requestService(
      {required VoidCallback onGrantedPermission}) async {
    if (_serviceEnabled ?? false) {
      return;
    }

    final serviceRequestedResult = await location.requestService();
    setState(() {
      _serviceEnabled = serviceRequestedResult;
    });
    print("TESTED ${serviceRequestedResult}");
    onGrantedPermission();
  }

  @override
  Widget build(BuildContext context) {
    final switchIndex = useState(0);
    final pageController = usePageController(initialPage: switchIndex.value);
    final switchItems = ['Map', 'List'];
    const switchDuration = Duration(milliseconds: 300);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    useEffect(() {
      _requestService(onGrantedPermission: () {
        // location.onLocationChanged.listen(
        //   (location) => {
        //     if (location.latitude != null && location.longitude != null)
        //       {
        //         mapController.animateTo(
        //           dest: LatLng(location.latitude!, location.longitude!),
        //         )
        //       }
        //   },
        // );
      });
      return;
    }, []);

    final points = <LatLng>[
      LatLng(37.725834, -122.416417),
      LatLng(37.785834, -122.416417),
      LatLng(37.785834, -122.426417),
      LatLng(37.755834, -122.406417),
      LatLng(37.715834, -122.416417),
      LatLng(37.731834, -122.436417),
      LatLng(37.742834, -122.426417),
    ];

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 32;
        final mapSectionHeight = (contentHeight * 0.8) - 24 - 12;
        final listSectionHeight = (contentHeight * 0.2) - 24 - 12;
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Near me!',
            ),
            const SliverGap(height: 12),
            SliverLayoutBuilder(builder: (context, sliver) {
              return SliverToBoxAdapter(
                child: Center(
                  child: ToggleSwitch(
                    minWidth: sliver.crossAxisExtent / 4,
                    minHeight: 42.0,
                    fontSize: 16.0,
                    initialLabelIndex: switchIndex.value,
                    activeBgColor: [context.theme.colorScheme.primaryContainer],
                    activeFgColor: context.theme.colorScheme.onPrimaryContainer,
                    inactiveBgColor: context.theme.colorScheme.tertiary,
                    inactiveFgColor: context.theme.colorScheme.onTertiary,
                    totalSwitches: 2,
                    labels: switchItems,
                    animate: true,
                    animationDuration: switchDuration.inMilliseconds,
                    onToggle: (index) {
                      final val = index ?? 0;
                      switchIndex.value = val;
                      pageController.animateToPage(
                        val,
                        duration: switchDuration,
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
              );
            }),
            const SliverGap(height: 12),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.transparent,
                height: contentHeight + 100,
                width: box.maxWidth,
                child: PageView(
                  allowImplicitScrolling: false,
                  controller: pageController,
                  onPageChanged: (value) => switchIndex.value = value,
                  children: [
                    CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        _NearMeScreenMapViewContent(
                          switchIndex: switchIndex,
                          switchItems: switchItems,
                          mapSectionHeight: mapSectionHeight,
                          listSectionHeight: listSectionHeight,
                          mapController: mapController,
                          items: points,
                          location: location,
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        _NearMeScreenListViewContent(
                          items: points,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _NearMeScreenListViewContent extends HookWidget {
  const _NearMeScreenListViewContent({
    required this.items,
  });
  final List<LatLng> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 112),
      sliver: SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CardContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueAccent,
                  ),
                  child: Center(child: Text(items[index].toString())),
                ),
              ),
            );
          }),
    );
  }
}

extension PositionToLatLon on GeolocationState {
  LatLng? get latLng => position != null
      ? LatLng(
          position!.latitude,
          position!.longitude,
        )
      : null;
}

class _NearMeScreenMapViewContent extends HookWidget {
  const _NearMeScreenMapViewContent({
    required this.items,
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
    required this.mapController,
    required this.location,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final Location location;
  final List<LatLng> items;

  Marker _createMarker(LatLng point, Color color) => Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        rotateAlignment: AnchorAlign.top.rotationAlignment,
        height: 50,
        width: 50,
        point: point,
        rotate: true,
        builder: (ctx) => Icon(
          Icons.pin_drop,
          color: color,
          size: 50,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final defaultPosition = const LatLng(51.509364, -0.128928);
    final geolocation = useGeolocation();
    LatLng? ltlg;
    if (geolocation.position != null) {
      ltlg = LatLng(
        geolocation.position!.latitude,
        geolocation.position!.longitude,
      );
    }

    // final user = useState(ltlg);
    final center = useState(
      items.isNotEmpty ? items.first : (ltlg ?? defaultPosition),
    );
    final zoom = useState(15.0);

    final markersA =
        items.map((point) => _createMarker(point, Colors.blue)).toList();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: MultiSliver(
        children: [
          MultiSliver(children: [
            SliverCardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(12),
              sliver: SliverLayoutBuilder(builder: (context, sliver) {
                return SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    width: sliver.crossAxisExtent,
                    height: mapSectionHeight,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FlutterMap(
                              mapController: mapController.mapController,
                              options: MapOptions(
                                center: center.value,
                                zoom: zoom.value,
                                adaptiveBoundaries: false,
                                keepAlive: true,
                                maxZoom: 17,
                                minZoom: 10,
                              ),
                              nonRotatedChildren: [
                                RichAttributionWidget(
                                  attributions: [
                                    TextSourceAttribution(
                                      'OpenStreetMap contributors',
                                      onTap: () => launchUrl(Uri.parse(
                                        'https://openstreetmap.org/copyright',
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}.png?key=J4ktALZX8GCz9Hw7i0tK',
                                ),
                                if (geolocation.latLng != null)
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: geolocation.latLng!,
                                        width: 80,
                                        height: 80,
                                        builder: (context) => Icon(
                                          Icons.person,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                SuperclusterLayer.immutable(
                                  initialMarkers: markersA,
                                  indexBuilder: IndexBuilders.rootIsolate,
                                  clusterWidgetSize: const Size(40, 40),
                                  anchor: AnchorPos.align(AnchorAlign.center),
                                  calculateAggregatedClusterData: true,
                                  builder: (context, position, markerCount,
                                      extraClusterData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: Text(
                                          markerCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MapButton(
                                    icon: Icons.center_focus_strong,
                                    onClicked: () {
                                      mapController.animateTo(
                                        dest: geolocation.latLng,
                                      );
                                    }),
                                MapButton(
                                  icon: Icons.zoom_in,
                                  onClicked: () {
                                    if (zoom.value > 17) {
                                      return;
                                    }
                                    zoom.value = zoom.value + 1;
                                    mapController.animatedZoomTo(zoom.value);
                                  },
                                ),
                                MapButton(
                                  icon: Icons.zoom_out,
                                  onClicked: () {
                                    if (zoom.value < 10) {
                                      return;
                                    }
                                    zoom.value = zoom.value - 1;
                                    mapController.animatedZoomTo(zoom.value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )
          ]),
          const SliverGap(height: 12),
          MultiSliver(
            children: [
              SliverCardContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(12),
                sliver: SliverLayoutBuilder(builder: (context, sliver) {
                  return SliverToBoxAdapter(
                    child: FlutterCarousel.builder(
                      options: CarouselOptions(
                        autoPlay: false,
                        disableCenter: true,
                        viewportFraction: .7,
                        height: listSectionHeight,
                        indicatorMargin: 12.0,
                        enableInfiniteScroll: true,
                        showIndicator: false,
                        padEnds: true,
                        // slideIndicator: CircularWaveSlideIndicator(),
                        onPageChanged: (index, reason) {
                          center.value = items[index];
                          mapController.animateTo(dest: items[index]);
                        },
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index, _) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          width: sliver.asBoxConstraints().maxWidth / 1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueAccent,
                          ),
                          child: Center(child: Text(items[index].toString())),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  const MapButton({
    Key? key,
    required this.icon,
    this.onClicked,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          hoverColor: Colors.orange,
          splashColor: Colors.black,
          focusColor: Colors.yellow,
          highlightColor: Colors.amber,
          onTap: onClicked,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
