import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/domain/graphql/__generated__/get_trip_by_id.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_trips.data.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_trips.req.gql.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/ioc/routing_machine_service.dart';
import 'package:recive/layout/ui_constants.dart';

class GQLPackageEventRepo extends IPackageEventRepo {
  final RealmGqlClient client;
  final RoutingMachineService rms;

  GQLPackageEventRepo({
    required this.client,
    required this.rms,
  });

  @override
  Future<Package> packageById({required String id}) async {
    final tripsRequest = GGetTripByIdReq((b) => b..vars.id.value = id);

    final data = await client.request(tripsRequest);

    final item = data.data?.trip_item;
    final convertedData = Package(
      id: item!.G_id!.value,
      title: item.title ?? '',
      description: item.description ?? '',
      imageUrl: item.images?.first?.image_url ?? kImagePlaceholder,
      distance: item.trip?.distance ?? 0,
      duration: Duration(seconds: item.trip?.duration?.toInt() ?? 0),
      subtitle: (item.description ?? '').dynamicSub(20),
      tags: item.tags?.whereNotNull().toList() ?? [],
      roadInstructions: item.trip?.instructions
              ?.map(
                (instruction) =>
                    instruction?.steps?.whereNotNull().toList() ?? [],
              )
              .whereNotNull()
              .toList() ??
          [],
      events: item.arts
              ?.map(
                (e) => ArtAbstractModel(
                  id: e!.G_id!.value,
                  title: e.title ?? '',
                  description: e.description ?? '',
                  location:
                      e.location?.venue?.address?.localizedAddressDisplay ??
                          'Not In Place',
                  imageUrl: (e.images?.isEmpty ?? true)
                      ? kImagePlaceholder
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
          [],
      polyline: item.trip?.polyline
              ?.map(
                (pl) => LatLng(
                  pl!.coordinates![1]!,
                  pl.coordinates![0]!,
                ),
              )
              .whereType<LatLng>()
              .toList() ??
          [],
    );

    return convertedData;
  }

  @override
  Future<List<PackageAbstract>> packages({
    required int limit,
    PackageAbstract? lastItem,
  }) async {
    final tripsRequest = GGetTripsReq(
      (b) {
        b.vars.limit = limit;
        if (lastItem != null) {
          b.vars.query.G_id_gt.value = lastItem.id;
        }
        return b;
      },
    );

    final data = await client.request(tripsRequest);

    final convertedData = data.data?.trip_items.map((item) {
          return gqlTripsToPackageAbstract(item);
        }).toList() ??
        [];

    return convertedData;
  }
}

PackageAbstract gqlTripsToPackageAbstract(GGetTripsData_trip_items? item) {
  return PackageAbstract(
    id: item!.G_id!.value,
    title: item.title ?? '',
    description: item.description ?? '',
    subtitle: (item.description ?? '').dynamicSub(20),
    imageUrl: item.images?.first?.image_url ?? kImagePlaceholder,
    distance: item.trip?.distance ?? 0,
    duration: Duration(seconds: item.trip?.duration?.toInt() ?? 0),
  );
}
