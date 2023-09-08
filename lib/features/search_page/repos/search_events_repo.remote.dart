import 'dart:io';

import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/search_event_query.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/search_keywords_query.req.gql.dart';
import 'package:recive/extensions/date_extensions.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLSearchEventRepo extends ISearchEventRepo implements ISearchRepository {
  final RealmGqlClient client;

  GQLSearchEventRepo({
    required this.client,
  });

  @override
  Future<List<EventComplete>> search({
    required int limit,
    required String query,
  }) async {
    final featuredEventRequest = GGetSearchEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.q = query
        ..vars.cq = query.toCapitalized(),
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.events;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = events
        .map((e) {
          if (e == null) {
            return null;
          }
          final o = e.organizer;
          final v = e.venue;

          return EventComplete(
            id: e.G_id?.value,
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
        })
        .whereType<EventComplete>()
        .toList();

    return convertedData;
  }

  @override
  Future<List<String>> quickSearch({required String query}) async {
    var filteredList = await keywords(limit: 10);

    filteredList = filteredList
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList;
  }

  @override
  Future<List<String>> keywords({required int limit}) async {
    final featuredEventRequest = GGetSearchKeywordsReq(
      (b) => b..vars.limit = limit,
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.events;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = events
        .map((e) {
          if (e == null) {
            return null;
          }
          return e.tags?.toList() ?? [];
        })
        .expand((t) => t!)
        .whereType<String>()
        .toList();

    return convertedData;
  }
}
