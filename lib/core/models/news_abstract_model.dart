import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_abstract_model.freezed.dart';
part 'news_abstract_model.g.dart';

@freezed
class NewsAbstractModel with _$NewsAbstractModel {
  const factory NewsAbstractModel({
    required String id,
    required String title,
    required String description,
    required String location,
    required String link,
    required String imageUrl,
    required List<String> tags,
  }) = _NewsAbstractModel;

  factory NewsAbstractModel.fromJson(Map<String, Object?> json) =>
      _$NewsAbstractModelFromJson(json);
}
