import 'package:recive/features/near_me_page/models/nearby_event.dart';

abstract class INearbyEventRepo {
  Future<List<NearbyEvent>> nearbyEvents({
    int limit = 50,
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
  });
}
