import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_data.freezed.dart';
part 'extra_data.g.dart';

@Freezed(genericArgumentFactories: true)
class ExtraData<T> with _$ExtraData<T> {
  static const summaryKey = 'summary';
  static const heroTagKey = 'heroTag';
  // final T? summary;
  // final String heroTag;

  const factory ExtraData({
    required T? summary,
    required String heroTag,
  }) = _ExtraData;

  factory ExtraData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ExtraDataFromJson(json, fromJsonT);
}

@freezed
class FeaturedEventDetailSummaryData with _$FeaturedEventDetailSummaryData {
  const factory FeaturedEventDetailSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _FeaturedEventDetailSummaryData;

  factory FeaturedEventDetailSummaryData.fromJson(Map<String, dynamic> json) =>
      _$FeaturedEventDetailSummaryDataFromJson(json);
}

@freezed
class NearbyDetailSummaryData with _$NearbyDetailSummaryData {
  const factory NearbyDetailSummaryData({
    required String id,
    required String title,
    required String imageUrl,
  }) = _NearbyDetailSummaryData;

  factory NearbyDetailSummaryData.fromJson(Map<String, dynamic> json) =>
      _$NearbyDetailSummaryDataFromJson(json);
}
