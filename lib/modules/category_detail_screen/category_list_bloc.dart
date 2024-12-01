import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_category_repository.dart';
import 'package:art_for_all/core/ioc/i_search_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'category_list_bloc.freezed.dart';
part 'category_list_bloc.g.dart';

@freezed
class CategoryListBlocState with _$CategoryListBlocState {
  const factory CategoryListBlocState({
    required LoadingState isLoading,
    CategoryAbstractModel? category,
    List<CategoryAbstractModel>? categories,
    required List<SearchableAbstractModel> result,
  }) = _CategoryListBlocState;

  factory CategoryListBlocState.initialize() => const CategoryListBlocState(
        isLoading: LoadingState.none,
        result: [],
      );

  factory CategoryListBlocState.fromJson(Map<String, Object?> json) =>
      _$CategoryListBlocStateFromJson(json);
}

class CategoryListBloc extends HydratedCubit<CategoryListBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  final ICategoryRepository categoryRepository;
  final ISearchRepository searchRepository;

  CategoryListBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.categoryRepository,
    required this.searchRepository,
  }) : super(CategoryListBlocState.initialize());

  Future<void> loadAllCategories() async {
    emit(state.copyWith(isLoading: LoadingState.loading));

    final categories = await categoryRepository.getCategories(null);

    emit(state.copyWith(
      isLoading: LoadingState.done,
      categories: categories,
    ));
  }

  @override
  CategoryListBlocState? fromJson(Map<String, dynamic> json) {
    return CategoryListBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryListBlocState state) {
    return state.toJson();
  }
}
