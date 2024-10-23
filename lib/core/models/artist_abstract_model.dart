import 'package:art_for_all/core/models/event_abstract_model.dart';
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

@freezed
class ArtistModel with _$ArtistModel {
  const factory ArtistModel({
    required String id,
    required String name,
    required String description,
    required List<MediaModel> media,
    required List<LinkModel> links,
    required List<String> tags,
  }) = _ArtistModel;

  factory ArtistModel.fromJson(Map<String, dynamic> json) => _$ArtistModelFromJson(json);
}
