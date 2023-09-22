import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/features/featured_page/models/art_abstract_model.dart';

part 'art_route_model.freezed.dart';
part 'art_route_model.g.dart';

@freezed
class ArtRouteModel with _$ArtRouteModel {
  const factory ArtRouteModel({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required String imageUrl,
    required List<String> tags,
    required List<ArtAbstractModel> arts,
    required List<LatLng>? polyline,
    required List<List<String>>? roadInstructions,
    required double distance,
    required Duration duration,
  }) = _ArtRouteModel;

  factory ArtRouteModel.fromJson(Map<String, Object?> json) =>
      _$ArtRouteModelFromJson(json);
}

@freezed
class ArtRouteAbstractModel with _$ArtRouteAbstractModel {
  const factory ArtRouteAbstractModel({
    required String id,
    required String title,
    required String description,
    required String subtitle,
    required String imageUrl,
    required double distance,
    required Duration duration,
  }) = _ArtRouteAbstractModel;

  factory ArtRouteAbstractModel.fromJson(Map<String, Object?> json) =>
      _$ArtRouteAbstractModelFromJson(json);
}
