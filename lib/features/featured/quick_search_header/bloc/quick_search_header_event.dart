part of 'quick_search_header_bloc.dart';

@freezed
class QuickSearchHeaderEvent with _$QuickSearchHeaderEvent {
  const factory QuickSearchHeaderEvent.search({required String query}) =
      _QuickSearchHeaderEventSearch;

  const factory QuickSearchHeaderEvent.select({required String selected}) =
      _QuickSearchHeaderEventSelect;
}
