import 'dart:async';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_search_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'dashboard_search_bloc.freezed.dart';
part 'dashboard_search_bloc.g.dart';

@freezed
class DashboardSearchBlocState with _$DashboardSearchBlocState {
  const factory DashboardSearchBlocState({
    required LoadingState isLoading,
    required SearchScreenFiltersData filtersData,
    required List<String> keywords,
    required PaginationData paginationData,
    required List<SearchableAbstractModel> result,
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
  }) = _DashboardSearchBlocState;

  factory DashboardSearchBlocState.initialize() => const DashboardSearchBlocState(
        isLoading: LoadingState.none,
        keywords: [],
        result: [],
        sortType: SortType.date,
        sortOrderType: SortOrderType.asc,
        query: '',
        paginationData: PaginationData(limit: 8),
        filtersData: SearchScreenFiltersData(),
      );

  factory DashboardSearchBlocState.fromJson(Map<String, Object?> json) =>
      _$DashboardSearchBlocStateFromJson(json);
}

class DashboardSearchBloc extends Cubit<DashboardSearchBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final ISearchRepository searchRepository;

  DashboardSearchBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.searchRepository,
  }) : super(DashboardSearchBlocState.initialize());

  Future<void> init(SearchScreenFiltersData filtersData, bool isViewAll) async {
    emit(state.copyWith(filtersData: filtersData));
    final result = await searchRepository.getCommonKeyboards();

    emit(state.copyWith(
      keywords: result,
    ));

    if (filtersData.autoSearch && isViewAll) {
      search('');
    }
  }

  Future<void> restore(DashboardSearchBlocState state) async {
    emit(state);
  }

  Timer? _debounce;
  Future<void> search(String query, {bool nextPage = false}) async {
    if (nextPage) {
      emit(state.copyWith(
        isLoading: LoadingState.updating,
      ));
    }

    if (query == state.query && state.paginationData.isDone) {
      emit(state.copyWith(
        isLoading: LoadingState.done,
      ));
      return;
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(nextPage ? Duration.zero : kDebounceDuration, () async {
      if (query != state.query) {
        emit(state.copyWith(
          paginationData: state.paginationData.copyWith(
            cursorId: null,
            cursorRank: null,
            isDone: false,
          ),
          result: [],
        ));
      }

      emit(state.copyWith(
        isLoading: !nextPage ? LoadingState.loading : LoadingState.updating,
      ));

      final result = query.isEmpty && !state.filtersData.autoSearch
          ? <SearchableAbstractModel>[]
          : await searchRepository.searchByQuery(
              query: query,
              cursorId: nextPage ? state.paginationData.cursorId : null,
              cursorRank: nextPage ? state.paginationData.cursorRank : null,
              limit: state.paginationData.limit,
              sortType: state.sortType,
              sortOrderType: state.sortOrderType,
              filtersData: state.filtersData,
            );

      emit(state.copyWith(
        result: List.from(state.result)..addAll(result),
        paginationData: state.paginationData.copyWith(
          cursorId: nextPage || result.isNotEmpty ? result.last.id : null,
          cursorRank: nextPage || result.isNotEmpty ? result.last.rank : null,
          isDone: result.length < state.paginationData.limit ? true : false,
        ),
        isLoading: LoadingState.done,
        query: query,
      ));
    });
  }
}
