part of 'category_section_bloc.dart';

@freezed
class CategorySectionState with _$CategorySectionState {
  const factory CategorySectionState({
    @Default(false) bool isCached,
    @Default(true) bool isLoading,
    @Default([]) List<ReciveCategory> categories,
  }) = _CategorySectionState;

  factory CategorySectionState.fromJson(Map<String, dynamic> json) =>
      _$CategorySectionStateFromJson(json);
}
