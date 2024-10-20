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
