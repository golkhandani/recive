import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist_abstract_model.freezed.dart';
part 'artist_abstract_model.g.dart';

@freezed
class ArtistAbstractModel with _$ArtistAbstractModel {
  const factory ArtistAbstractModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required List<String> tags,
  }) = _ArtistAbstractModel;

  factory ArtistAbstractModel.fromJson(Map<String, Object?> json) =>
      _$ArtistAbstractModelFromJson(json);
}
