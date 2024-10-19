import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_abstract_model.freezed.dart';
part 'event_abstract_model.g.dart';

@freezed
class EventAbstractModel with _$EventAbstractModel {
  const factory EventAbstractModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required List<String> tags,
  }) = _EventAbstractModel;

  factory EventAbstractModel.fromJson(Map<String, Object?> json) =>
      _$EventAbstractModelFromJson(json);
}
