// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_custom_data.freezed.dart';
part 'user_custom_data.g.dart';

@freezed
class UserCustomData with _$UserCustomData {
  const factory UserCustomData({
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'bookmark_arts') List<String>? bookmarkArts,
  }) = _UserCustomData;

  factory UserCustomData.fromJson(Map<String, dynamic> json) =>
      _$UserCustomDataFromJson(json);
}
