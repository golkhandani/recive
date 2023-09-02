import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/domain/graphql/__generated__/event_query.req.gql.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/layout/context_ui_extension.dart';

class GQLNearbyEventRepo extends INearbyEventRepo {
  final RealmGqlClient client;

  GQLNearbyEventRepo({
    required this.client,
  });

  @override
  Future<EventComplete> event({required String id}) async {
    final featuredEventRequest =
        GGetFeaturedEventReq((b) => b..vars.eventId.value = id);

    final data = await client.request(featuredEventRequest);
    final e = data.data!.event;

    if (e == null) {
      throw HttpException('Data is empty');
    }

    final o = e.organizer;
    final v = e.venue;

    return EventComplete(
      id: id,
      endDate: DateTimeGQL.forceConvert(e.end_date?.value),
      hasAvailableTickets: e.has_available_tickets,
      imageUrl: e.image_url,
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
}
