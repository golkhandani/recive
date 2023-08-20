import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/archived/repositories/search.repository.interface.dart';

part 'quick_search_header_event.dart';
part 'quick_search_header_state.dart';
part 'quick_search_header_bloc.freezed.dart';

class QuickSearchHeaderBloc
    extends Bloc<QuickSearchHeaderEvent, QuickSearchHeaderState> {
  final ISearchRepository _searchRepository;
  QuickSearchHeaderBloc({
    required ISearchRepository searchRepository,
  })  : _searchRepository = searchRepository,
        super(const QuickSearchHeaderState()) {
    on<QuickSearchHeaderEvent>((event, emit) async {
      await event.when(
        search: (query) => _search(emit, query: query),
        select: (selected) => _select(emit, selected: selected),
      );
    });
  }

  Future<void> _search(
    Emitter<QuickSearchHeaderState> emit, {
    required String query,
  }) async {
    emit(state.copyWith(isLoading: true, query: query, isSelected: false));
    final suggestions = await _searchRepository.quickSearch(query: query);
    emit(state.copyWith(isLoading: false, suggestions: suggestions));
  }

  Future<void> _select(
    Emitter<QuickSearchHeaderState> emit, {
    required String selected,
  }) async {
    emit(state.copyWith(isLoading: false, query: selected, isSelected: true));
  }
}
