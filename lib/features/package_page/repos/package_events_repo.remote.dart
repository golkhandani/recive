import 'dart:math';

import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/domain/graphql/__generated__/events_query.req.gql.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:routing_client_dart/routing_client_dart.dart';
import 'package:starsview/utils/RandomUtils.dart';

class RoutingMachineService {
  final OSRMManager osrmManager;
  RoutingMachineService({
    required this.osrmManager,
  });

  List<LngLat> convertPointsToWay(List<LatLng> points) {
    List<LngLat> waypoints =
        points.map((e) => LngLat(lng: e.longitude, lat: e.latitude)).toList();
    return waypoints;
  }

  Future<Road> getRoad(List<LngLat> waypoints) async {
    final road = await osrmManager.getRoad(
      waypoints: waypoints,
      roadType: RoadType.foot,
      geometries: Geometries.geojson,
      steps: true,
      language: Languages.en,
    );
    return road;
  }

  Future<List<RoadInstruction>> getInstructions(Road road) async {
    final instructions = await osrmManager.buildInstructions(road);
    return instructions;
  }

  // get string instruction grouped for each destination
  Future<List<List<String>>> getInstructionsByDestinations(Road road) async {
    final instructions = await osrmManager.buildInstructions(road);
    final splittedInstructions = instructions
        .map((e) => e.instruction)
        .splitAfter((e) => e.contains('destination'))
        .toList();
    return splittedInstructions;
  }

  Future<List<String>> getDestinations(Road road) async {
    final destinations = road.roadLegs
        .expand((e) => e)
        .map((e) => e.destinations)
        .whereNotNull()
        .toList();
    return destinations;
  }

// get polyline that can be used in flutter_map
  List<LatLng>? getPolyline(Road road) {
    final polyline = road.polyline?.map((e) => LatLng(e.lat, e.lng)).toList();
    return polyline;
  }
}

class GQLPackageEventRepo extends IPackageEventRepo {
  final RealmGqlClient client;
  final RoutingMachineService rms;

  GQLPackageEventRepo({
    required this.client,
    required this.rms,
  });

  @override
  Future<Package> packageById({required String id}) {
    throw UnimplementedError();
  }

  Future<List<NearbyEvent>> _events({
    required int limit,
    required EventSortByInput sortBy,
  }) async {
    final featuredEventRequest = GGetFeaturedEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.sortBy = sortBy.toGQL(),
    );

    final data = await client.request(featuredEventRequest);
    final convertedData = data.data?.events
            .map(
              (e) => NearbyEvent(
                id: e!.G_id!.value,
                title: e.name ?? '',
                description: e.summary ?? '',
                startDate: e.start_date?.value != null
                    ? DateTime.parse(e.start_date!.value)
                    : DateTime.now(),
                endDate: e.end_date?.value != null
                    ? DateTime.parse(e.start_date!.value)
                    : DateTime.now(),
                location: e.venue?.address?.localized_address_display ?? '',
                organizers: [e.organizer?.website_url ?? '']
                    .whereNot((element) => element.isEmpty)
                    .toList(),
                participants: [e.eventbrite_url ?? '']
                    .whereNot((element) => element.isEmpty)
                    .toList(),
                imageUrl: e.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                latLng: LatLng(
                  double.tryParse(e.venue!.address!.latitude!) ?? 0,
                  double.tryParse(e.venue!.address!.longitude!) ?? 0,
                ),
              ),
            )
            .whereType<NearbyEvent>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<Package>> packages({required int limit}) async {
    final events = await _events(
      limit: limit * 3,
      sortBy: EventSortByInput.startDateDesc,
    );

    final counter = List.generate(limit, (i) => i);
    final list = <Package>[];
    for (var count in counter) {
      events.shuffle();
      final packageEvents = events.take(10);
      final way = rms.convertPointsToWay(
        packageEvents.map((e) => e.latLng).toList(),
      );
      final road = await rms.getRoad(way);
      final destinations = await rms.getDestinations(road);
      final polyline = rms.getPolyline(road);
      final stepByStepInstruction =
          await rms.getInstructionsByDestinations(road);
      final duration = Duration(seconds: road.duration.toInt());
      final tags = packageEvents.expand((e) => e.tags).toList();

      list.add(Package(
        id: '$count',
        title:
            '${duration.toHoursMinutes()} of ${tags.randomElement(Random())}',
        subtitle: destinations.isNotEmpty
            ? 'From ${destinations.first} to ${destinations.last}'
            : '',
        description: 'You going to visit ${destinations.join(' ')}',
        imageUrl: packageEvents.last.imageUrl,
        tags: tags,
        events: packageEvents.toList(),
        roadInstructions: stepByStepInstruction,
        distance: road.distance,
        duration: duration,
        polyline: polyline ?? [],
      ));
    }

    return list;
  }
}
