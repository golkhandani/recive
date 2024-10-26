import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_data.freezed.dart';
part 'extra_data.g.dart';

typedef JsonData = Map<String, dynamic>;

@Freezed(genericArgumentFactories: true)
class ExtraData<T> with _$ExtraData<T> {
  static const summaryKey = 'summary';
  static const heroTagKey = 'heroTag';

  const factory ExtraData({
    required T? summary,
    required String heroTag,
  }) = _ExtraData;

  factory ExtraData.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ExtraDataFromJson(json, fromJsonT);
}

@freezed
class SearchScreenFiltersData with _$SearchScreenFiltersData {
  const SearchScreenFiltersData._();

  const factory SearchScreenFiltersData({
    @Default(true) bool art,
    @Default(true) bool artists,
    @Default(true) bool communities,
    @Default(true) bool events,
    @Default(true) bool news,
    @Default(false) bool autoSearch,
  }) = _SearchScreenFiltersData;

  factory SearchScreenFiltersData.fromJson(Map<String, dynamic> json) =>
      _$SearchScreenFiltersDataFromJson(json);

  factory SearchScreenFiltersData.none() => const SearchScreenFiltersData(
        art: false,
        artists: false,
        communities: false,
        events: false,
        news: false,
        autoSearch: false,
      );
}
