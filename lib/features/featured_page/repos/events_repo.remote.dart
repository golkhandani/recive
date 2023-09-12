import 'dart:io';

import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_bookmark_events.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_featured_event_by_id.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_featured_events.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/enums/event_sort.dart';
import 'package:recive/extensions/date_extensions.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLEventRepo extends IEventRepo {
  final RealmGqlClient client;

  GQLEventRepo({
    required this.client,
  });

  @override
  Future<EventComplete> completeEventById({required String id}) async {
    final featuredEventRequest =
        GGetFeaturedEventReq((b) => b..vars.eventId.value = id);

    final data = await client.request(featuredEventRequest);
    final e = data.data!.event;

    if (e == null) {
      throw const HttpException('Data is empty');
    }

    final o = e.organizer;
    final v = e.venue;

    return EventComplete(
      id: id,
      endDate: DateTimeGQL.forceConvert(e.end_date?.value),
      hasAvailableTickets: e.has_available_tickets,
      imageUrl: e.image_url,
      imageUrls: images,
      isFree: e.is_free,
      isOnlineEvent: e.is_online_event,
      isSoldOut: e.is_sold_out,
      maxPrice: e.max_price,
      minPrice: e.min_price,
      title: e.name,
      organizer: o != null
          ? Organizer(
              title: o.name ?? '',
              organizerId: o.eventbrite_id,
              numFollowers: o.num_followers,
              description: o.summary,
              websiteUrl: o.website_url,
            )
          : null,
      publishedDate: DateTimeGQL.forceConvert(e.published_date?.value),
      startDate: DateTimeGQL.forceConvert(e.start_date?.value),
      description: e.summary,
      tags: e.tags?.whereType<String>().toList() ?? [],
      venue: v != null
          ? Venue(
              address: v.address != null
                  ? Address(
                      city: v.address?.city,
                      country: v.address?.country,
                      latitude: v.address?.latitude == null
                          ? 0
                          : double.tryParse(v.address!.latitude!),
                      localizedAddressDisplay:
                          v.address?.localized_address_display,
                      longitude: v.address?.longitude == null
                          ? 0
                          : double.tryParse(v.address!.longitude!),
                      postalCode: v.address?.postal_code,
                      region: v.address?.region,
                    )
                  : null,
              title: v.name,
              venueId: v.eventbrite_id,
              latLng: LatLng(
                v.address?.latitude == null
                    ? 0
                    : double.tryParse(v.address!.latitude!) ?? 0,
                v.address?.longitude == null
                    ? 0
                    : double.tryParse(v.address!.longitude!) ?? 0,
              ),
            )
          : null,
      source: Source(
        id: e.eventbrite_id,
        url: e.eventbrite_url,
        venueId: v?.eventbrite_id,
        organizerId: e.eventbrite_organization_id,
        name: 'Event Brite',
      ),
    );
  }

  @override
  Future<FeaturedEvent> featuredEventById({required String id}) async {
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
      tags: e.tags?.whereNotNull().toList() ?? [],
    );
  }

  @override
  Future<List<FeaturedEvent>> featuredEvents({
    required int limit,
    required EventSortBy sortBy,
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
                tags: e.tags?.whereNotNull().toList() ?? [],
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<FeaturedEvent>> bookmarkEvents({
    required int limit,
    required List<String> ids,
  }) async {
    final favouriteEventRequest = GGetBookmarksEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.eventIds.addAll(ids.map((e) => GObjectId(e))),
    );

    final data = await client.request(favouriteEventRequest);
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
                tags: e.tags?.whereNotNull().toList() ?? [],
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }
}
