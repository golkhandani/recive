import 'dart:io';

import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_art.data.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_art.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_arts.data.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/layout/ui_constants.dart';

class GQLEventRepo extends IEventRepo {
  final RealmGqlClient client;

  GQLEventRepo({
    required this.client,
  });

  @override
  Future<ArtModel> completeEventById({required String id}) async {
    final featuredEventRequest = GGetArtByIdReq((b) => b..vars.id.value = id);

    final data = await client.request(featuredEventRequest);
    final e = data.data!.art_item;

    if (e == null) {
      throw const HttpException('Data is empty');
    }

    final v = e.location?.venue;
    final s = e.source;

    return gqlArtByIdToArtModel(id, e, v, s);
  }

  @override
  Future<List<ArtAbstractModel>> featuredEvents({
    required int limit,
    required ArtItemSortBy sortBy,
  }) async {
    final featuredEventRequest = GGetArtsReq((b) => b..vars.limit = limit);

    final data = await client.request(featuredEventRequest);
    final convertedData = data.data?.art_items
            .map(
              (e) => ArtAbstractModel(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                geoLocation: LatLng(
                  e.location?.geolocation?.coordinates?[1] ?? 0,
                  e.location?.geolocation?.coordinates?[0] ?? 0,
                ),
              ),
            )
            .whereType<ArtAbstractModel>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<ArtAbstractModel>> bookmarkEvents({
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
              (e) => ArtAbstractModel(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                geoLocation: LatLng(
                  e.location?.geolocation?.coordinates?[1] ?? 0,
                  e.location?.geolocation?.coordinates?[0] ?? 0,
                ),
              ),
            )
            .whereType<ArtAbstractModel>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<ArtAbstractModel>> categoryEvents({
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
              (e) => ArtAbstractModel(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                imageUrl: (e.images?.isEmpty ?? true)
                    ? kImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                geoLocation: LatLng(
                  e.location?.geolocation?.coordinates?[1] ?? 0,
                  e.location?.geolocation?.coordinates?[0] ?? 0,
                ),
              ),
            )
            .whereType<ArtAbstractModel>()
            .toList() ??
        [];

    return convertedData;
  }
}

ArtModel gqlArtByIdToArtModel(
    String id,
    GGetArtByIdData_art_item e,
    GGetArtByIdData_art_item_location_venue? v,
    GGetArtByIdData_art_item_source? s) {
  return ArtModel(
    id: id,
    artType: e.art_type ?? 'Other',
    artists: e.artists
            ?.map((artist) => ArtistModel(
                  typename: artist!.G__typename,
                  id: artist.G_id!.value,
                  biography: artist.biography ?? '',
                  country: artist.country ?? '',
                  images: artist.images
                          ?.map(
                            (image) => ImageModel(
                              typename: image!.G__typename,
                              id: image.G_id!.value,
                              imageCredit: image.image_credit ?? '',
                              imageData: image.image_data ?? '',
                              imageUrl: image.image_url ?? '',
                            ),
                          )
                          .toList() ??
                      [],
                  name: artist.biography ?? '',
                  originalId: artist.original_id ?? 0,
                  website: artist.website ?? '',
                ))
            .toList() ??
        [],
    description: e.description ?? '',
    images: e.images
            ?.map(
              (image) => ImageModel(
                typename: image!.G__typename,
                id: image.G_id!.value,
                imageCredit: image.image_credit ?? '',
                imageData: image.image_data ?? '',
                imageUrl: image.image_url ?? '',
              ),
            )
            .toList() ??
        [],
    location: LocationModel(
        latLng: LatLng(
          e.location?.geolocation?.coordinates?[1] ?? 0,
          e.location?.geolocation?.coordinates?[0] ?? 0,
        ),
        geolocation: GeolocationModel(
          typename: e.location!.geolocation!.G__typename,
          coordinates:
              e.location!.geolocation?.coordinates?.whereNotNull().toList() ??
                  [],
          type: e.location!.geolocation?.type ?? 'Point',
        ),
        venue: VenueModel(
          address: AddressModel(
            city: v?.address?.city ?? '',
            country: v?.address?.country ?? '',
            latitude: e.location?.geolocation?.coordinates?[1] ?? 0,
            longitude: e.location?.geolocation?.coordinates?[0] ?? 0,
            localizedAddressDisplay:
                v?.address?.localizedAddressDisplay ?? 'Not in place!',
            postalCode: v?.address?.postalCode ?? '',
            region: v?.address?.region ?? '',
            area: v?.address?.area ?? '',
          ),
          title: v?.title ?? '',
          typename: '',
          id: v!.G_id!.value,
          geolocation: GeolocationModel(
            typename: e.location!.geolocation!.G__typename,
            coordinates:
                e.location!.geolocation?.coordinates?.whereNotNull().toList() ??
                    [],
            type: e.location!.geolocation?.type ?? 'Point',
          ),
          osmId: v.osm_id?.toInt() ?? 0,
          osmLicence: v.osm_licence ?? '',
          osmVenueId: v.osm_venue_id?.toInt() ?? 0,
        )),
    source: SourceModel(
      id: s!.G_id!.value,
      name: s.name ?? 'No Source',
      copyRight: s.copy_right ?? 'No Copy Right',
      dataUrl: s.data_url ?? '',
    ),
    material: e.material?.whereNotNull().toList() ?? [],
    originalId: e.original_id ?? 0,
    originalUrl: e.original_url ?? '',
    ownership: e.ownership ?? '',
    statement: e.statement ?? '',
    tags: e.tags?.whereType<String>().toList() ?? [],
    title: e.title ?? '',
  );
}

ArtModel gqlArtsToArtModel(
    String id,
    GGetArtsData_art_items e,
    GGetArtsData_art_items_location_venue? v,
    GGetArtsData_art_items_source? s) {
  return ArtModel(
    id: id,
    artType: e.art_type ?? 'Other',
    artists: e.artists
            ?.map((artist) => ArtistModel(
                  typename: artist!.G__typename,
                  id: artist.G_id!.value,
                  biography: artist.biography ?? '',
                  country: artist.country ?? '',
                  images: artist.images
                          ?.map(
                            (image) => ImageModel(
                              typename: image!.G__typename,
                              id: image.G_id!.value,
                              imageCredit: image.image_credit ?? '',
                              imageData: image.image_data ?? '',
                              imageUrl: image.image_url ?? '',
                            ),
                          )
                          .toList() ??
                      [],
                  name: artist.biography ?? '',
                  originalId: artist.original_id ?? 0,
                  website: artist.website ?? '',
                ))
            .toList() ??
        [],
    description: e.description ?? '',
    images: e.images
            ?.map(
              (image) => ImageModel(
                typename: image!.G__typename,
                id: image.G_id!.value,
                imageCredit: image.image_credit ?? '',
                imageData: image.image_data ?? '',
                imageUrl: image.image_url ?? '',
              ),
            )
            .toList() ??
        [],
    location: LocationModel(
        latLng: LatLng(
          e.location?.geolocation?.coordinates?[1] ?? 0,
          e.location?.geolocation?.coordinates?[0] ?? 0,
        ),
        geolocation: GeolocationModel(
          typename: e.location!.geolocation!.G__typename,
          coordinates:
              e.location!.geolocation?.coordinates?.whereNotNull().toList() ??
                  [],
          type: e.location!.geolocation?.type ?? 'Point',
        ),
        venue: VenueModel(
          address: AddressModel(
            city: v?.address?.city ?? '',
            country: v?.address?.country ?? '',
            latitude: e.location?.geolocation?.coordinates?[1] ?? 0,
            longitude: e.location?.geolocation?.coordinates?[0] ?? 0,
            localizedAddressDisplay:
                v?.address?.localizedAddressDisplay ?? 'Not in place!',
            postalCode: v?.address?.postalCode ?? '',
            region: v?.address?.region ?? '',
            area: v?.address?.area ?? '',
          ),
          title: v?.title ?? '',
          typename: '',
          id: v!.G_id!.value,
          geolocation: GeolocationModel(
            typename: e.location!.geolocation!.G__typename,
            coordinates:
                e.location!.geolocation?.coordinates?.whereNotNull().toList() ??
                    [],
            type: e.location!.geolocation?.type ?? 'Point',
          ),
          osmId: v.osm_id?.toInt() ?? 0,
          osmLicence: v.osm_licence ?? '',
          osmVenueId: v.osm_venue_id?.toInt() ?? 0,
        )),
    source: SourceModel(
      id: s!.G_id!.value,
      name: s.name ?? 'No Source',
      copyRight: s.copy_right ?? 'No Copy Right',
      dataUrl: s.data_url ?? '',
    ),
    material: e.material?.whereNotNull().toList() ?? [],
    originalId: e.original_id ?? 0,
    originalUrl: e.original_url ?? '',
    ownership: e.ownership ?? '',
    statement: e.statement ?? '',
    tags: e.tags?.whereType<String>().toList() ?? [],
    title: e.title ?? '',
  );
}
