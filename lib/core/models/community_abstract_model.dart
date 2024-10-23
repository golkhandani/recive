import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_abstract_model.freezed.dart';
part 'community_abstract_model.g.dart';

@freezed
class CommunityAbstractModel with _$CommunityAbstractModel {
  const factory CommunityAbstractModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required List<String> tags,
  }) = _CommunityAbstractModel;

  factory CommunityAbstractModel.fromJson(Map<String, Object?> json) =>
      _$CommunityAbstractModelFromJson(json);
}

@freezed
class CommunityModel with _$CommunityModel {
  const factory CommunityModel({
    required String id,
    required String title,
    required String description,
    required String communityType,
    required DateTime dateTime,
    required List<LinkModel> links,
    required List<String> highlights,
    required List<MediaModel> media,
    required List<String> tags,
  }) = _CommunityModel;

  factory CommunityModel.fromJson(Map<String, Object?> json) =>
      _$CommunityModelFromJson(json);
}
