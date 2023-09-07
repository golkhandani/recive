import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'category_section_cubit.freezed.dart';
part 'category_section_cubit.g.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required LoadingState categoryLoadingState,
    required Category? category,
    required List<Category> categories,
    required List<Category> categoriesSpotlight,
    required LoadingState loadingState,
  }) = _CategoriesState;

  factory CategoriesState.initialize() => const CategoriesState(
        categoryLoadingState: LoadingState.none,
        category: null,
        //
        categories: [],
        categoriesSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory CategoriesState.fromJson(Map<String, Object?> json) =>
      _$CategoriesStateFromJson(json);
}

class CategoriesCubit extends MaybeEmitHydratedCubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesState.initialize());

  Future<void> loadCategory(String id) async {
    maybeEmit(state.copyWith(
      category: null,
      categoryLoadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));

    maybeEmit(state.copyWith(
      category: mockCategoriesData.firstWhere((element) => element.id == id),
      categoryLoadingState: LoadingState.done,
    ));
  }

  Future<void> emptyCategory() async {
    maybeEmit(state.copyWith(
      category: null,
      categoryLoadingState: LoadingState.none,
    ));
  }

  Future<void> loadCategories() async {
    maybeEmit(state.copyWith(
      categories: mockCategoriesData,
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    maybeEmit(state.copyWith(
      categories: mockCategoriesData,
      categoriesSpotlight: mockCategoriesData.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }
}
