import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'search_events_cubit.freezed.dart';
part 'search_events_cubit.g.dart';

@freezed
class SearchEventsState with _$SearchEventsState {
  const factory SearchEventsState({
    required int preSelectedEventIndex,
    required List<PackageAbstract> searchedEvents,
    required List<String> searchedkeywords,
    required LoadingState loadingState,
  }) = _SearchEventsState;

  factory SearchEventsState.initialize() => const SearchEventsState(
        preSelectedEventIndex: 0,
        searchedEvents: [],
        searchedkeywords: [],
        loadingState: LoadingState.none,
      );

  factory SearchEventsState.fromJson(Map<String, Object?> json) =>
      _$SearchEventsStateFromJson(json);
}

class SearchEventsCubit extends MaybeEmitHydratedCubit<SearchEventsState> {
  final ISearchEventRepo repo;
  SearchEventsCubit({
    required this.repo,
  }) : super(SearchEventsState.initialize());

  Future<void> searchedEvents(String q, VoidCallback cb) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
      searchedEvents: [],
    ));

    final data = await repo.search(limit: 5, query: q);

    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedEvents: data,
      loadingState: LoadingState.done,
    ));
    cb.call();
  }

  Future<void> loadSearchedKeywords() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.keywords(limit: 10);

    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedkeywords: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> changeSelectedIndex(int index) async {
    maybeEmit(state.copyWith(
      preSelectedEventIndex: index,
    ));
  }

  @override
  SearchEventsState? fromJson(Map<String, dynamic> json) {
    return SearchEventsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SearchEventsState state) {
    return state.toJson();
  }
}
