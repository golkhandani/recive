part of 'quick_search_header_bloc.dart';

@freezed
class QuickSearchHeaderState with _$QuickSearchHeaderState {
  const factory QuickSearchHeaderState({
    @Default('') String query,
    @Default(false) bool isLoading,
    @Default(false) bool isSelected,
    @Default([]) List<String> suggestions,
  }) = _QuickSearchHeaderState;
}
