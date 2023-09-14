import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_arts_near.req.gql.dart';
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
    int limit = 50,
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
  }) async {
    final nearbyEventRequest = GGetArtsNearReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.minDistance = minDistance
        ..vars.query.maxDistance = maxDistance
        ..vars.query.lat = latitude
        ..vars.query.long = longitude,
    );

    final data = await client.request(nearbyEventRequest);
    final convertedData = data.data?.art_items_near
            ?.map(
              (e) => NearbyEvent(
                id: e!.G_id!.value,
                title: e.title ?? '',
                description: e.description ?? '',
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                location:
                    e.location?.venue?.address?.localizedAddressDisplay ?? '',
                organizers:
                    [''].whereNot((element) => element.isEmpty).toList(),
                participants:
                    [''].whereNot((element) => element.isEmpty).toList(),
                imageUrl: e.images?[0]?.image_url ?? '',
                tags: e.tags?.whereNotNull().toList() ?? [],
                latLng: LatLng(
                  e.location?.venue!.address!.latitude! ?? 0,
                  e.location?.venue!.address!.longitude! ?? 0,
                ),
              ),
            )
            .whereType<NearbyEvent>()
            .toList() ??
        [];

    return convertedData;
  }
}
