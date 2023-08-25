import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';

import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';

import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/features/home_page/sections/map_section.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NearMeScreenMapViewContent extends HookWidget {
  const NearMeScreenMapViewContent({
    super.key,
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: MultiSliver(
        children: [
          _MapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            bloc: bloc,
          ),
          const SliverGap(height: 12),
          _CarouselContent(
            switchIndex: switchIndex,
            listSectionHeight: listSectionHeight,
            mapController: mapController,
            bloc: bloc,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}

class _MapContent extends StatefulHookWidget {
  static const double maxZoom = 18;
  static const double minZoom = 10;
  const _MapContent({
    required this.mapSectionHeight,
    required this.mapController,
    required this.bloc,
  });

  final double mapSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  State<_MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<_MapContent> {
  Marker _createMarker(
    LatLng point,
    Color color,
    int index,
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
            widget.bloc.changeSelectedIndex(index);
          },
          child: Iconify(
            Bx.bxs_map,
            color: color,
            size: 50,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final state = useBlocBuilder(widget.bloc);
    final items = state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();

    if (kDebugMode) {
      print('_________________| build _MapContent');
    }
    LatLng? ltlg;
    const defaultPosition = LatLng(51.509364, -0.128928);
    final geolocation = useUserLocation();
    final zoom = useState(15.0);

    final center = useState(
      items.isNotEmpty ? items.first.latLng : (ltlg ?? defaultPosition),
    );

    final markers = items
        .mapIndexed(
          (index, data) => _createMarker(
            data.latLng,
            Colors.deepOrange,
            index,
          ),
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
                height: widget.mapSectionHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FlutterMap(
                          mapController: widget.mapController.mapController,
                          options: MapOptions(
                            center: center.value,
                            zoom: zoom.value,
                            adaptiveBoundaries: false,
                            keepAlive: true,
                            maxZoom: _MapContent.maxZoom,
                            minZoom: _MapContent.minZoom,
                          ),
                          nonRotatedChildren: const [
                            FlutterMapAttribution(),
                          ],
                          children: [
                            const FlutterMapTileLayer(),
                            if (geolocation.latLng != null)
                              UserMarker(geolocation: geolocation),
                            SuperclusterLayer.mutable(
                              initialMarkers: markers,
                              indexBuilder: IndexBuilders.rootIsolate,
                              clusterWidgetSize: const Size(40, 40),
                              maxClusterRadius: 40,
                              minimumClusterSize: 4,
                              anchor: AnchorPos.align(AnchorAlign.center),
                              calculateAggregatedClusterData: true,
                              builder: (
                                context,
                                position,
                                markerCount,
                                extraClusterData,
                              ) {
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
                            SelectedMarker(
                              latLng: items[state.preSelectedEventIndex].latLng,
                            )
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
                                  widget.mapController.animateTo(
                                    dest: geolocation.latLng,
                                  );
                                }),
                            MapButton(
                              icon: Icons.zoom_in,
                              onClicked: () {
                                if (zoom.value > _MapContent.maxZoom) {
                                  return;
                                }
                                zoom.value = zoom.value + 1;
                                widget.mapController.animatedZoomTo(zoom.value);
                              },
                            ),
                            MapButton(
                              icon: Icons.zoom_out,
                              onClicked: () {
                                if (zoom.value < _MapContent.minZoom) {
                                  return;
                                }
                                zoom.value = zoom.value - 1;
                                widget.mapController.animatedZoomTo(zoom.value);
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

class SelectedMarker extends StatelessWidget {
  const SelectedMarker({
    super.key,
    required this.latLng,
  });

  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          height: 50,
          width: 50,
          point: latLng,
          rotate: true,
          builder: (ctx) => const Iconify(
            Bx.bxs_map,
            color: Colors.blueAccent,
            size: 50,
          ),
        )
      ],
    );
  }
}

class _CarouselContent extends StatefulHookWidget {
  const _CarouselContent({
    required this.switchIndex,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
  });

  final ValueNotifier<int> switchIndex;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;

  @override
  State<_CarouselContent> createState() => _CarouselContentState();
}

class _CarouselContentState extends State<_CarouselContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isUpdating = useState(false);
    final state = useBlocBuilder(widget.bloc);
    final items = state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();

    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      widget.bloc,
      (_, state, context) {
        if (!isUpdating.value && widget.switchIndex.value != 0) {
          isUpdating.value = true;
          controller.animateToPage(state.preSelectedEventIndex);
        }
        widget.mapController
            .animateTo(
              dest: items[state.preSelectedEventIndex].latLng,
            )
            .then((value) => isUpdating.value = false);
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedEventIndex !=
          currentState.preSelectedEventIndex,
    );

    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              // Warning: To prevent rebuild issue
              // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
              final list = items
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
                  controller: controller,
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: .7,
                  height: widget.listSectionHeight,
                  indicatorMargin: 12.0,
                  enableInfiniteScroll: true,
                  showIndicator: false,
                  padEnds: true,
                  onPageChanged: (index, reason) {
                    if (!isUpdating.value) {
                      widget.bloc.changeSelectedIndex(index);
                      // widget.mapController.animateTo(
                      //   dest: items[state.preSelectedEventIndex].latLng,
                      // );
                    }
                  },
                ),
                itemCount: items.length,
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

  static EventCardContainerData fromFeaturedEvent(NearbyEvent e) {
    return EventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      startDate: e.startDate,
      endDate: e.endDate,
      location: e.location,
      organizers: e.organizers,
      participants: e.participants,
      imageUrl: e.imageUrl,
      latLng: e.latLng,
    );
  }
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
    const color = Colors.black54;

    final child = LayoutBuilder(builder: (context, box) {
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

    final heroTag = data.id + DateTime.now().toString();
    return InkWell(
      onTap: () => context.goNamed(
        NearMeScreen.name + FeaturedEventDetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
        },
        extra: {
          FeaturedEventDetailScreen.summaryKey: FeaturedEventCardContainerData(
            id: data.id,
            title: data.title,
            description: data.description,
            startDate: data.startDate,
            endDate: data.endDate,
            location: data.location,
            organizers: data.organizers,
            participants: data.participants,
            imageUrl: data.imageUrl,
          ),
          FeaturedEventDetailScreen.heroTagKey: heroTag
        },
      ),
      child: Hero(
        tag: heroTag,
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
      constraints: constraints,
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
