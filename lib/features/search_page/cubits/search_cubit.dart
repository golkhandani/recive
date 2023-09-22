import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/package_page/models/art_route_model.dart';
import 'package:recive/features/search_page/repos/search_route_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'search_cubit.freezed.dart';
part 'search_cubit.g.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required int preSelectedIndex,
    required List<ArtRouteAbstractModel> searchedItems,
    required LoadingState loadingKeywordsState,
    required List<String> searchedkeywords,
    required LoadingState loadingState,
    required int? distanceFilter,
    required String? queryFilter,
  }) = _SearchState;

  factory SearchState.initialize() => const SearchState(
        preSelectedIndex: 0,
        searchedItems: [],
        searchedkeywords: [],
        loadingState: LoadingState.none,
        loadingKeywordsState: LoadingState.none,
        distanceFilter: null,
        queryFilter: null,
      );

  factory SearchState.fromJson(Map<String, Object?> json) =>
      _$SearchStateFromJson(json);
}

class SearchCubit extends MaybeEmitHydratedCubit<SearchState> {
  final ISearchRouteRepo repo;
  SearchCubit({
    required this.repo,
  }) : super(SearchState.initialize());

  Future<void> loadSearchedItems(String? q) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
      searchedItems: [],
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
      searchedItems: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> loadMoreSearchedItems() async {
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
      lastItem: state.searchedItems.last,
    );

    if (isClosed) return;
    maybeEmit(state.copyWith(
      searchedItems: [...state.searchedItems, ...data],
      loadingState: LoadingState.done,
    ));
  }

  Future<void> updateDistanceFilter(int? distanceFilter) async {
    maybeEmit(state.copyWith(
      distanceFilter: distanceFilter,
    ));
    loadSearchedItems(null);
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
      searchedItems: [],
    ));
  }

  Future<void> changeSelectedIndex(int index) async {
    maybeEmit(state.copyWith(
      preSelectedIndex: index,
    ));
  }

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    return SearchState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return state.toJson();
  }
}
