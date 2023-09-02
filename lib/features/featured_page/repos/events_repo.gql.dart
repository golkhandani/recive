import 'package:collection/collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/domain/graphql/__generated__/event_query.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/events_query.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/near_by_query.req.gql.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLEventRepo extends IEventRepo {
  final RealmGqlClient client;

  GQLEventRepo({
    required this.client,
  });

  @override
  Future<FeaturedEvent> event({required String id}) async {
    final featuredEventRequest = GGetFeaturedEventReq(
      (b) => b..vars.eventId.value = id,
    );

    final data = await client.request(featuredEventRequest);
    final e = data.data!.event!;

    return FeaturedEvent(
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
    );
  }

  @override
  Future<List<FeaturedEvent>> events({
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
              (e) => FeaturedEvent(
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
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }

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
                  latLng: LatLng(
                    double.tryParse(e.venue!.address!.latitude!) ?? 0,
                    double.tryParse(e.venue!.address!.longitude!) ?? 0,
                  )),
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
      latLng: LatLng(
        double.tryParse(e.venue!.address!.latitude!) ?? 0,
        double.tryParse(e.venue!.address!.longitude!) ?? 0,
      ),
    );
  }
}
