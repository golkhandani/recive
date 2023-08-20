import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    required String id,
    required String title,
    required String description,
    required DateTime publishDate,
    required String source,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, Object?> json) =>
      _$NewsModelFromJson(json);
}
