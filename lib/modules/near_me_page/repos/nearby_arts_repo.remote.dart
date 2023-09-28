import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/core/domain/client/realm_gql_client.dart';
import 'package:recive/core/domain/fake_data.dart';
import 'package:recive/core/domain/graphql/__generated__/get_arts_near.req.gql.dart';
import 'package:recive/modules/featured_page/models/art_abstract_model.dart';
import 'package:recive/modules/near_me_page/repos/nearby_arts_repo.interface.dart';

class GQLNearbyArtRepo extends INearbyArtRepo {
  final RealmGqlClient client;

  GQLNearbyArtRepo({
    required this.client,
  });

  @override
  Future<List<ArtAbstractModel>> getNearbyArts({
    int limit = 50,
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
    String? text,
  }) async {
    final nearbyEventRequest = GGetArtsNearReq((b) {
      if (text?.isNotEmpty ?? false) {
        b.vars.query.text = text;
      }
      b
        ..vars.limit = limit
        ..vars.query.minDistance = minDistance
        ..vars.query.maxDistance = maxDistance
        ..vars.query.lat = latitude
        ..vars.query.long = longitude;

      return b;
    });

    final data = await client.request(nearbyEventRequest);
    final convertedData = data.data?.art_items_near
            ?.map(
              (e) => ArtAbstractModel(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                location: e.location?.venue?.address?.localizedAddressDisplay ??
                    'Not In Place',
                imageUrl: (e.images?.isEmpty ?? true)
                    ? fakeImagePlaceholder
                    : e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                geoLocation: LatLng(
                  e.location?.venue!.address!.latitude! ?? 0,
                  e.location?.venue!.address!.longitude! ?? 0,
                ),
              ),
            )
            .whereType<ArtAbstractModel>()
            .toList() ??
        [];

    return convertedData;
  }
}
