import 'dart:io';

import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
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
    final featuredEventRequest = GGetArtsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.tags_in.add(query),
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.art_items;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = events
        .map((e) {
          if (e == null) {
            return null;
          }
          final o = e.artists?.first;
          final v = e.location?.venue;
          final s = e.source;
          final imageUrls = e.images?.map((p0) => p0?.image_url).whereNotNull();

          return EventComplete(
            id: e.G_id?.value,
            endDate: DateTime.now(),
            hasAvailableTickets: false,
            imageUrl: imageUrls?.first,
            imageUrls: [...?imageUrls, ...images],
            isFree: true,
            isOnlineEvent: false,
            isSoldOut: false,
            maxPrice: 0,
            minPrice: 0,
            title: e.title,
            organizer: o != null
                ? Organizer(
                    title: o.name ?? '',
                    organizerId: o.G_id?.value,
                    numFollowers: 0,
                    description: o.biography,
                    websiteUrl: o.name,
                  )
                : null,
            publishedDate: DateTime.now(),
            startDate: DateTime.now(),
            description: e.description,
            tags: e.tags?.whereType<String>().toList() ?? [],
            venue: v != null
                ? Venue(
                    address: v.address != null
                        ? Address(
                            city: v.address?.city,
                            country: v.address?.country,
                            latitude: v.address?.latitude == null
                                ? 0
                                : v.address!.latitude,
                            localizedAddressDisplay:
                                v.address?.localizedAddressDisplay,
                            longitude: v.address?.longitude == null
                                ? 0
                                : v.address!.longitude,
                            postalCode: v.address?.postalCode,
                            region: v.address?.region,
                          )
                        : null,
                    title: v.title,
                    venueId: v.osm_venue_id.toString(),
                    latLng: LatLng(
                      v.address?.latitude == null
                          ? 0
                          : v.address!.latitude ?? 0,
                      v.address?.longitude == null
                          ? 0
                          : v.address!.longitude ?? 0,
                    ),
                  )
                : null,
            source: Source(
              id: s?.G_id?.value,
              url: s?.data_url,
              name: s?.name,
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
    final featuredEventRequest = GGetArtsReq(
      (b) => b..vars.limit = limit,
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.art_items;

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
