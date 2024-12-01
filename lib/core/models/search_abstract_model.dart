import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'search_abstract_model.freezed.dart';
part 'search_abstract_model.g.dart';

@freezed
class SearchableAbstractModel with _$SearchableAbstractModel {
  const factory SearchableAbstractModel({
    required String id,
    required String title,
    required double rank,
    required EntityType entityType,
    required String imageUrl,
    required List<String> tags,
    required LatLng geoLocation,
  }) = _SearchableAbstractModel;

  factory SearchableAbstractModel.fromJson(Map<String, Object?> json) =>
      _$SearchableAbstractModelFromJson(json);
}

@freezed
class InteratedEntityAbstractModel with _$InteratedEntityAbstractModel {
  const factory InteratedEntityAbstractModel({
    required String id,
    required String title,
    required EntityType entityType,
    required String imageUrl,
    required List<String> tags,
  }) = _InteratedEntityAbstractModel;

  factory InteratedEntityAbstractModel.fromJson(Map<String, Object?> json) =>
      _$InteratedEntityAbstractModelFromJson(json);
}

@freezed
class PaginationData with _$PaginationData {
  const factory PaginationData({
    String? cursorId,
    double? cursorRank,
    @Default(20) int limit,
    @Default(false) bool isDone,
  }) = _PaginationData;

  factory PaginationData.fromJson(Map<String, Object?> json) =>
      _$PaginationDataFromJson(json);
}

@freezed
class PaginationOffset with _$PaginationOffset {
  const factory PaginationOffset({
    @Default(1) int page,
    @Default(20) int limit,
    @Default(false) bool isDone,
  }) = _PaginationOffset;

  factory PaginationOffset.fromJson(Map<String, Object?> json) =>
      _$PaginationOffsetFromJson(json);
}

enum EntityType { art, artist, event, news, community, unknown }

extension EntityTypeConverter on EntityType {
  static EntityType fromString(String str) {
    final searchType = switch (str.toUpperCase()) {
      'ART' => EntityType.art,
      'ARTIST' => EntityType.artist,
      'EVENT' => EntityType.event,
      'NEWS' => EntityType.news,
      'COMMUNITY' => EntityType.community,
      String() => throw UnimplementedError(),
    };

    return searchType;
  }
}

enum SortType { date, relevant }

enum SortOrderType { asc, desc }
