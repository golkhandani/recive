import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/event_query.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/near_by_query.req.gql.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLNearbyEventRepo extends INearbyEventRepo {
  final RealmGqlClient client;

  GQLNearbyEventRepo({
    required this.client,
  });

  @override
  Future<List<NearbyEvent>> nearbyEvents({
    required double latitude,
    required double longitude,
    required int minDistance,
    required int maxDistance,
  }) async {
    final nearbyEventRequest = GGetNearByEventsReq(
      (b) => b
        ..vars.minDistance = minDistance
        ..vars.maxDistance = maxDistance
        ..vars.latitude = latitude
        ..vars.longitude = longitude,
    );

    final data = await client.request(nearbyEventRequest);
    final convertedData = data.data?.GetEventsByDistance
            ?.map(
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
  Future<NearbyEvent> nearbyEvent({
    required String id,
  }) async {
    final nearByEventRequest =
        GGetFeaturedEventReq((b) => b..vars.eventId.value = id);

    final data = await client.request(nearByEventRequest);
    final e = data.data!.event!;

    return NearbyEvent(
      id: e.G_id!.value,
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
    );
  }
}
