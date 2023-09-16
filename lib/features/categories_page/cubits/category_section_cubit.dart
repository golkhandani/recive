import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/categories_page/repos/categories_repo.interface.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
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
    required List<FeaturedEvent> items,
    required LoadingState loadingState,
  }) = _CategoriesState;

  factory CategoriesState.initialize() => const CategoriesState(
        categoryLoadingState: LoadingState.none,
        category: null,
        items: [],
        //
        categories: [],
        categoriesSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory CategoriesState.fromJson(Map<String, Object?> json) =>
      _$CategoriesStateFromJson(json);
}

class CategoriesCubit extends MaybeEmitHydratedCubit<CategoriesState> {
  final ICategoryRepo categoryRepo;
  final IEventRepo eventRepo;
  CategoriesCubit({
    required this.categoryRepo,
    required this.eventRepo,
  }) : super(CategoriesState.initialize());

  Future<void> loadCategory(String id) async {
    maybeEmit(state.copyWith(
      category: null,
      categoryLoadingState: LoadingState.loading,
    ));

    maybeEmit(state.copyWith(
      category: state.categories.firstWhere((element) => element.id == id),
      categoryLoadingState: LoadingState.done,
    ));

    final items =
        await eventRepo.categoryEvents(limit: 10, category: state.category!);

    maybeEmit(state.copyWith(
      items: items,
      categoryLoadingState: LoadingState.done,
    ));
  }

  Future<void> emptyCategory() async {
    maybeEmit(state.copyWith(
      items: [],
      category: null,
      categoryLoadingState: LoadingState.none,
    ));
  }

  Future<void> loadCategories() async {
    maybeEmit(state.copyWith(
      categories: mockCategoriesData,
      loadingState: LoadingState.loading,
    ));

    final data = await categoryRepo.getCategories();
    data.shuffle();

    maybeEmit(state.copyWith(
      categories: data,
      categoriesSpotlight: data.take(3).toList(),
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
