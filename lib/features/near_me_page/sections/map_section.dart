import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_use_geolocation/flutter_use_geolocation.dart';
import 'package:location/location.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class NearMeScreenMapViewContent extends HookWidget {
  const NearMeScreenMapViewContent({
    super.key,
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
  final List<EventCardContainerData> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: MultiSliver(
        children: [
          _MapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            items: items,
          ),
          const SliverGap(height: 12),
          _CarouselContent(
            listSectionHeight: listSectionHeight,
            items: items,
            mapController: mapController,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}

class _MapContent extends HookWidget {
  const _MapContent({
    required this.mapSectionHeight,
    required this.mapController,
    required this.items,
  });

  final double mapSectionHeight;
  final AnimatedMapController mapController;
  final List<EventCardContainerData> items;

  Marker _createMarker(LatLng point, Color color) => Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        rotateAlignment: AnchorAlign.top.rotationAlignment,
        height: 50,
        width: 50,
        point: point,
        rotate: true,
        builder: (ctx) => Iconify(
          Bx.bxs_map,
          color: color,
          size: 50,
        ),
      );

  @override
  Widget build(BuildContext context) {
    LatLng? ltlg;
    const defaultPosition = LatLng(51.509364, -0.128928);
    final geolocation = useUserLocation();
    final zoom = useState(15.0);
    final center = useState(
      items.isNotEmpty ? items.first.latLng : (ltlg ?? defaultPosition),
    );

    final markers = items
        .map(
          (data) => _createMarker(data.latLng, Colors.deepOrange),
        )
        .toList();

    useEffect(() {
      if (geolocation.fetched) {
        ltlg = LatLng(
          geolocation.position!.latitude!,
          geolocation.position!.longitude!,
        );
      }
      return;
    }, [geolocation.timestamp]);

    mapController.mapController.mapEventStream.listen(
      (MapEvent event) => center.value = event.center,
    );
    return MultiSliver(children: [
      SliverCardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        sliver: SliverToBoxAdapter(
          child: LayoutBuilder(builder: (context, box) {
            return Hero(
              tag: 'MapHeroTag',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                width: box.maxWidth,
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
                              tileProvider: FMTC
                                  .instance('FlutterMapTileStore')
                                  .getTileProvider(),
                            ),
                            if (geolocation.latLng != null)
                              UserMarker(geolocation: geolocation),
                            SuperclusterLayer.immutable(
                              initialMarkers: markers,
                              indexBuilder: IndexBuilders.rootIsolate,
                              clusterWidgetSize: const Size(40, 40),
                              anchor: AnchorPos.align(AnchorAlign.center),
                              calculateAggregatedClusterData: true,
                              builder: (context, position, markerCount,
                                  extraClusterData) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
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
        ),
      )
    ]);
  }
}

class _CarouselContent extends StatefulWidget {
  const _CarouselContent({
    required this.listSectionHeight,
    required this.items,
    required this.mapController,
  });

  final double listSectionHeight;
  final List<EventCardContainerData> items;
  final AnimatedMapController mapController;

  @override
  State<_CarouselContent> createState() => _CarouselContentState();
}

class _CarouselContentState extends State<_CarouselContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              // Warning: To prevent rebuild issue
              // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
              final list = widget.items
                  .mapIndexed((index, data) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: EventCardContainer(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 1.1,
                          ),
                          data: data,
                        ),
                      ))
                  .toList();
              return FlutterCarousel.builder(
                options: CarouselOptions(
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: .7,
                  height: widget.listSectionHeight,
                  indicatorMargin: 12.0,
                  enableInfiniteScroll: true,
                  showIndicator: false,
                  padEnds: true,
                  // slideIndicator: CircularWaveSlideIndicator(),
                  onPageChanged: (index, reason) {
                    // widget.center.value = widget.items[index];
                    widget.mapController.animateTo(
                      dest: widget.items[index].latLng,
                    );
                  },
                ),
                itemCount: widget.items.length,
                itemBuilder: (context, index, _) {
                  return list[index];
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

class EventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final LatLng latLng;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;

  EventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.latLng,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });
}

class EventCardContainer extends StatelessWidget {
  const EventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final EventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final color = context.randomColor;

    final child = LayoutBuilder(builder: (context, box) {
      print("---------------- 1 ${box.maxHeight}");
      final isSmall = box.maxHeight < 160;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            maxLines: 1,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Iconify(
                Bx.bxs_map,
                color: color.lighten(0.7),
                size: 24,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  data.location,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          if (!isSmall) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Iconify(
                  Bx.calendar_event,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Iconify(
                  Bx.briefcase,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    data.organizers.join(' '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      );
    });
    return InkWell(
      onTap: () => context.goNamed(
        NearMeScreen.name + DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.event.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.event.name + data.id,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildEventCard(imageProvider, color, child),
          placeholder: (context, url) => _buildEventLoading(color),
          errorWidget: (context, url, error) =>
              _buildEventCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildEventLoading(Color color) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.3),
            color.darken(0.3),
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
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
