import 'package:recive/features/near_me_page/models/nearby_event.dart';

abstract class INearbyEventRepo {
  Future<List<NearbyEvent>> nearbyEvents({
    required double latitude,
    required double longitude,
    required int minDistance,
    required int maxDistance,
  });

  Future<NearbyEvent> nearbyEvent({
    required String id,
  });
}
