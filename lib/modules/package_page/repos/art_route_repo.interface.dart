import 'package:recive/modules/package_page/models/art_route_model.dart';

abstract class IArtRouteRepo {
  Future<List<ArtRouteAbstractModel>> getArtRoutes({
    required int limit,
    ArtRouteAbstractModel? lastItem,
  });

  Future<ArtRouteModel> getArtRouteById({
    required String id,
  });
}
