import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_abstract_model.freezed.dart';
part 'user_abstract_model.g.dart';

@freezed
class UserAbstractModel with _$UserAbstractModel {
  const factory UserAbstractModel({
    required String id,
    required String email,
    required String name,
    required String lastLocation,
    required String imageUrl,
    required List<String> tags,
  }) = _UserAbstractModel;

  factory UserAbstractModel.fromJson(Map<String, Object?> json) =>
      _$UserAbstractModelFromJson(json);
}
