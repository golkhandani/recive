import 'package:recive/modules/featured_page/models/art_abstract_model.dart';

abstract class INearbyArtRepo {
  Future<List<ArtAbstractModel>> getNearbyArts({
    int limit = 50,
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
    String? text,
  });
}
