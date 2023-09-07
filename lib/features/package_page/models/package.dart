import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';

part 'package.freezed.dart';
part 'package.g.dart';

@freezed
class Package with _$Package {
  const factory Package({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required String imageUrl,
    required List<String> tags,
    required List<NearbyEvent> events,
    required List<LatLng>? polyline,
    required List<String>? roadInstructions,
    required double distance,
    required Duration duration,
  }) = _Package;

  factory Package.fromJson(Map<String, Object?> json) =>
      _$PackageFromJson(json);
}
