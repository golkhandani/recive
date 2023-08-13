import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
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

    final points = <LatLng>[
      LatLng(51.509324, -0.128128),
      LatLng(51.502334, -0.128528),
      LatLng(51.503214, -0.128128),
      LatLng(51.504564, -0.128228),
      LatLng(51.5055264, -0.125928),
      LatLng(51.501164, -0.128428),
      LatLng(51.502464, -0.128228),
      LatLng(51.504564, -0.128328),
    ];

    return ColoredBox(
      color: Colors.amber[100]!,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 32;
        final mapSectionHeight = (contentHeight * 0.72) - 24 - 12;
        final listSectionHeight = (contentHeight * 0.28) - 24 - 12;
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

class _NearMeScreenMapViewContent extends HookWidget {
  const _NearMeScreenMapViewContent({
    required this.items,
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
    required this.mapController,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final List<LatLng> items;

  @override
  Widget build(BuildContext context) {
    final center = useState(LatLng(51.509364, -0.128928));
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
                                zoom: 15,
                                adaptiveBoundaries: false,
                                keepAlive: true,
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
                                MarkerLayer(
                                  markers: [
                                    ...List.generate(
                                      items.length,
                                      (index) => Marker(
                                        point: items[index],
                                        width: 80,
                                        height: 80,
                                        builder: (context) => const Icon(
                                          Icons.pin_drop,
                                          color: Colors.blueAccent,
                                          size: 60,
                                        ),
                                      ),
                                    )
                                  ],
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
                                  onClicked: () => mapController.animateTo(
                                    dest: center.value,
                                  ),
                                ),
                                const MapButton(
                                  icon: Icons.zoom_in,
                                ),
                                const MapButton(
                                  icon: Icons.zoom_out,
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
                        viewportFraction: .9,
                        height: listSectionHeight,
                        indicatorMargin: 12.0,
                        enableInfiniteScroll: true,
                        padEnds: true,
                        slideIndicator: const CircularSlideIndicator(),
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
