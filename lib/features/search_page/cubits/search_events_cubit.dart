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
    required LoadingState loadingKeywordsState,
    required List<String> searchedkeywords,
    required LoadingState loadingState,
    required int? distanceFilter,
    required String? queryFilter,
  }) = _SearchEventsState;

  factory SearchEventsState.initialize() => const SearchEventsState(
        preSelectedEventIndex: 0,
        searchedEvents: [],
        searchedkeywords: [],
        loadingState: LoadingState.none,
        loadingKeywordsState: LoadingState.none,
        distanceFilter: null,
        queryFilter: null,
      );

  factory SearchEventsState.fromJson(Map<String, Object?> json) =>
      _$SearchEventsStateFromJson(json);
}

class SearchEventsCubit extends MaybeEmitHydratedCubit<SearchEventsState> {
  final ISearchEventRepo repo;
  SearchEventsCubit({
    required this.repo,
  }) : super(SearchEventsState.initialize());

  Future<void> searchedEvents(String? q) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
      searchedEvents: [],
      queryFilter: q ?? state.queryFilter,
    ));

    final data = await repo.search(
      limit: 10,
      query: state.queryFilter ?? '',
      distanceFilter: state.distanceFilter?.toDouble(),
      lastItem: null,
    );

    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedEvents: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> loadMoreSearchedEvents() async {
    if (state.loadingState == LoadingState.updating ||
        state.loadingState == LoadingState.loading) {
      return;
    }
    maybeEmit(state.copyWith(
      loadingState: LoadingState.updating,
    ));

    final data = await repo.search(
      limit: 10,
      query: state.queryFilter ?? '',
      distanceFilter: state.distanceFilter?.toDouble(),
      lastItem: state.searchedEvents.last,
    );

    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedEvents: [...state.searchedEvents, ...data],
      loadingState: LoadingState.done,
    ));
  }

  Future<void> updateDistanceFilter(int? distanceFilter) async {
    maybeEmit(state.copyWith(
      distanceFilter: distanceFilter,
    ));
    searchedEvents(null);
  }

  Future<void> loadSearchedKeywords() async {
    maybeEmit(state.copyWith(
      loadingKeywordsState: LoadingState.loading,
    ));

    final data = await repo.keywords(limit: 10);
    data.shuffle();
    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedkeywords: data.take(9).toList(),
      loadingKeywordsState: LoadingState.done,
    ));
  }

  Future<void> resetSearchResult() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.none,
      searchedEvents: [],
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
