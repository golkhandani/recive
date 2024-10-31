import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'search_abstract_model.freezed.dart';
part 'search_abstract_model.g.dart';

@freezed
class SearchableAbstractModel with _$SearchableAbstractModel {
  const factory SearchableAbstractModel({
    required String id,
    required String title,
    required SearchType searchType,
    required String imageUrl,
    required List<String> tags,
    required LatLng geoLocation,
  }) = _SearchableAbstractModel;

  factory SearchableAbstractModel.fromJson(Map<String, Object?> json) =>
      _$SearchableAbstractModelFromJson(json);
}

enum SearchType { art, artist, event, news, community }

extension SearchTypeConverter on SearchType {
  static SearchType fromString(String str) {
    final searchType = switch (str.toUpperCase()) {
      'ART' => SearchType.art,
      'ARTIST' => SearchType.artist,
      'EVENT' => SearchType.event,
      'NEWS' => SearchType.news,
      'COMMUNITY' => SearchType.community,
      String() => throw UnimplementedError(),
    };

    return searchType;
  }
}

enum SortType { date, relevant }

enum SortOrderType { asc, desc }
