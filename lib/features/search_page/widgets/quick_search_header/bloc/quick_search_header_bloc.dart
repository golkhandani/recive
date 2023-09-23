import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/features/search_page/repos/search_route_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'quick_search_header_bloc.freezed.dart';

@freezed
class QuickSearchHeaderState with _$QuickSearchHeaderState {
  const factory QuickSearchHeaderState({
    @Default('') String query,
    @Default(false) bool isLoading,
    @Default(false) bool isSelected,
    @Default([]) List<String> suggestions,
  }) = _QuickSearchHeaderState;
}

class QuickSearchHeaderBloc extends MaybeEmitCubit<QuickSearchHeaderState> {
  final ISearchRouteRepo _searchRepository;
  QuickSearchHeaderBloc({
    required ISearchRouteRepo searchRepository,
  })  : _searchRepository = searchRepository,
        super(const QuickSearchHeaderState());

  Future<void> search({
    required String query,
  }) async {
    emit(state.copyWith(isLoading: true, query: query, isSelected: false));
    final suggestions = await _searchRepository.quickSearch(query: query);
    emit(state.copyWith(isLoading: false, suggestions: suggestions));
  }

  Future<void> select({
    required String selected,
  }) async {
    emit(state.copyWith(isLoading: false, query: selected, isSelected: true));
  }
}
