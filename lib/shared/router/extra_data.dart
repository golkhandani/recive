import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_data.freezed.dart';
part 'extra_data.g.dart';

@Freezed(genericArgumentFactories: true)
class ExtraData<T> with _$ExtraData<T> {
  static const summaryKey = 'summary';
  static const heroTagKey = 'heroTag';

  const factory ExtraData({
    required T? summary,
    required String heroTag,
  }) = _ExtraData;

  factory ExtraData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ExtraDataFromJson(json, fromJsonT);
}

@freezed
class ArtDetailSummaryData with _$ArtDetailSummaryData {
  const factory ArtDetailSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _ArtDetailSummaryData;

  factory ArtDetailSummaryData.fromJson(Map<String, dynamic> json) =>
      _$ArtDetailSummaryDataFromJson(json);
}

@freezed
class CategorySummaryData with _$CategorySummaryData {
  const factory CategorySummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _CategorySummaryData;

  factory CategorySummaryData.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryDataFromJson(json);
}

@freezed
class PackageSummaryData with _$PackageSummaryData {
  const factory PackageSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _PackageSummaryData;

  factory PackageSummaryData.fromJson(Map<String, dynamic> json) =>
      _$PackageSummaryDataFromJson(json);
}

@freezed
class NewsSummaryData with _$NewsSummaryData {
  const factory NewsSummaryData({
    required String id,
    required String title,
  }) = _NewsSummaryData;

  factory NewsSummaryData.fromJson(Map<String, dynamic> json) =>
      _$NewsSummaryDataFromJson(json);
}
