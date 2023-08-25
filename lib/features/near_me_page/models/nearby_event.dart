import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'nearby_event.freezed.dart';
part 'nearby_event.g.dart';

@freezed
class NearbyEvent with _$NearbyEvent {
  const factory NearbyEvent({
    required String id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String location,
    required List<String> organizers,
    required List<String> participants,
    required String imageUrl,
    required LatLng latLng,
  }) = _NearbyEvent;

  factory NearbyEvent.fromJson(Map<String, Object?> json) =>
      _$NearbyEventFromJson(json);
}
