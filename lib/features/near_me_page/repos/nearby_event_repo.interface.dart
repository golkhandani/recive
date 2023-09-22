import 'package:recive/features/featured_page/models/featured_event.dart';

abstract class INearbyEventRepo {
  Future<List<ArtAbstractModel>> nearbyEvents({
    int limit = 50,
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
    String? text,
  });
}
