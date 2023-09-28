import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'art_abstract_model.freezed.dart';
part 'art_abstract_model.g.dart';

@freezed
class ArtAbstractModel with _$ArtAbstractModel {
  const factory ArtAbstractModel({
    required String id,
    required String title,
    required String description,
    required String location,
    required LatLng geoLocation,
    required String imageUrl,
    required List<String> tags,
  }) = _ArtAbstractModel;

  factory ArtAbstractModel.fromJson(Map<String, Object?> json) =>
      _$ArtAbstractModelFromJson(json);
}
