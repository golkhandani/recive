import 'dart:io';

import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_art.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/layout/ui_constants.dart';

class GQLEventRepo extends IEventRepo {
  final RealmGqlClient client;

  GQLEventRepo({
    required this.client,
  });

  @override
  Future<EventComplete> completeEventById({required String id}) async {
    final featuredEventRequest = GGetArtByIdReq((b) => b..vars.id.value = id);

    final data = await client.request(featuredEventRequest);
    final e = data.data!.art_item;

    if (e == null) {
      throw const HttpException('Data is empty');
    }

    final o = e.artists?.first;
    final v = e.location?.venue;
    final s = e.source;
    final imageUrls = e.images?.map((p0) => p0?.image_url).whereNotNull();

    return EventComplete(
      id: id,
      endDate: DateTime.now(),
      hasAvailableTickets: false,
      imageUrl:
          (imageUrls?.isEmpty ?? true) ? kImagePlaceholder : imageUrls?.first,
      imageUrls: [
        if (!(imageUrls?.isEmpty ?? true)) ...imageUrls!,
        ...images,
      ],
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
                      latitude:
                          v.address?.latitude == null ? 0 : v.address!.latitude,
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
                v.address?.latitude == null ? 0 : v.address!.latitude ?? 0,
                v.address?.longitude == null ? 0 : v.address!.longitude ?? 0,
              ),
            )
          : null,
      source: Source(
        id: s?.G_id?.value,
        url: s?.data_url,
        name: s?.name,
      ),
    );
  }

  @override
  Future<List<FeaturedEvent>> featuredEvents({
    required int limit,
    required ArtItemSortBy sortBy,
  }) async {
    final featuredEventRequest = GGetArtsReq((b) => b..vars.limit = limit);

    final data = await client.request(featuredEventRequest);
    final convertedData = data.data?.art_items
            .map(
              (e) => FeaturedEvent(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                organizers:
                    [''].whereNot((element) => element.isEmpty).toList(),
                participants:
                    [''].whereNot((element) => element.isEmpty).toList(),
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
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
    final favouriteEventRequest = GGetArtsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.G_id_in.addAll(ids.map((e) => GObjectId(e))),
    );

    final data = await client.request(favouriteEventRequest);
    final convertedData = data.data?.art_items
            .map(
              (e) => FeaturedEvent(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                organizers:
                    [''].whereNot((element) => element.isEmpty).toList(),
                participants:
                    [''].whereNot((element) => element.isEmpty).toList(),
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<FeaturedEvent>> categoryEvents({
    required int limit,
    required Category category,
  }) async {
    final featuredEventRequest = GGetArtsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.art_type = category.title,
    );

    final data = await client.request(featuredEventRequest);
    final convertedData = data.data?.art_items
            .map(
              (e) => FeaturedEvent(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                organizers:
                    [''].whereNot((element) => element.isEmpty).toList(),
                participants:
                    [''].whereNot((element) => element.isEmpty).toList(),
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }
}
