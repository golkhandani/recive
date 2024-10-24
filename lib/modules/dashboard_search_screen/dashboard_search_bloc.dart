import 'dart:async';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_search_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'dashboard_search_bloc.freezed.dart';
part 'dashboard_search_bloc.g.dart';

@freezed
class DashboardSearchBlocState with _$DashboardSearchBlocState {
  const factory DashboardSearchBlocState({
    required LoadingState isLoading,
    required List<String> keywords,
    required List<SearchAbstractModel> result,
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

  Future<void> init() async {
    final result = await searchRepository.getCommonKeyboards();

    emit(state.copyWith(keywords: result));
  }

  Timer? _debounce;
  Future<void> search(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(kDebounceDuration, () async {
      emit(state.copyWith(isLoading: LoadingState.loading));
      final result = query.isEmpty
          ? <SearchAbstractModel>[]
          : await searchRepository.searchByQuery(
              query: query,
              sortType: state.sortType,
              sortOrderType: state.sortOrderType,
            );

      emit(state.copyWith(
        result: result,
        isLoading: LoadingState.done,
        query: query,
      ));
    });
  }
}
