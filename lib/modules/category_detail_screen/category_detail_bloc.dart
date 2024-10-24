import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_category_repository.dart';
import 'package:art_for_all/core/ioc/i_search_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'category_detail_bloc.freezed.dart';
part 'category_detail_bloc.g.dart';

@freezed
class CategoryDetailBlocState with _$CategoryDetailBlocState {
  const factory CategoryDetailBlocState({
    required LoadingState isLoading,
    CategoryAbstractModel? category,
    required List<SearchAbstractModel> result,
  }) = _CategoryDetailBlocState;

  factory CategoryDetailBlocState.initialize() => const CategoryDetailBlocState(
        isLoading: LoadingState.none,
        result: [],
      );

  factory CategoryDetailBlocState.fromJson(Map<String, Object?> json) =>
      _$CategoryDetailBlocStateFromJson(json);
}

class CategoryDetailBloc extends HydratedCubit<CategoryDetailBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  final ICategoryRepository categoryRepository;
  final ISearchRepository searchRepository;

  CategoryDetailBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.categoryRepository,
    required this.searchRepository,
  }) : super(CategoryDetailBlocState.initialize());

  Future<void> init(String id) async {
    emit(state.copyWith(
      isLoading: LoadingState.loading,
    ));

    final category = await categoryRepository.getCategoryById(id);
    final result = await searchRepository.searchByQuery(
      query: category.title,
      sortType: SortType.relevant,
      sortOrderType: SortOrderType.desc,
      filtersData: SearchScreenFiltersData.none().copyWith(
        art: true,
        artists: true,
      ),
    );

    emit(state.copyWith(
      isLoading: LoadingState.done,
      category: category,
      result: result,
    ));
  }

  @override
  CategoryDetailBlocState? fromJson(Map<String, dynamic> json) {
    return CategoryDetailBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryDetailBlocState state) {
    return state.toJson();
  }
}
