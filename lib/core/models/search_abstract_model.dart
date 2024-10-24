import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_abstract_model.freezed.dart';
part 'search_abstract_model.g.dart';

@freezed
class SearchAbstractModel with _$SearchAbstractModel {
  const factory SearchAbstractModel({
    required String id,
    required String title,
    required SearchType searchType,
    required String imageUrl,
    required List<String> tags,
  }) = _SearchAbstractModel;

  factory SearchAbstractModel.fromJson(Map<String, Object?> json) =>
      _$SearchAbstractModelFromJson(json);
}

enum SearchType { art, artist, event, news, community }

enum SortType { date, relevant }

enum SortOrderType { asc, desc }
