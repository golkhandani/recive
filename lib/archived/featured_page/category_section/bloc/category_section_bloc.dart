import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/models/recive_category.model.dart';
import 'package:recive/utils/valid_bloc_cache.dart';

part 'category_section_bloc.freezed.dart';
part 'category_section_bloc.g.dart';

@freezed
class CategorySectionEvent with _$CategorySectionEvent {
  const factory CategorySectionEvent.load() = _CategorySectionEventLoad;
}

@freezed
class CategorySectionState extends HydratedState with _$CategorySectionState {
  const factory CategorySectionState({
    @Default(false) bool isLoada,
    @Default(true) bool isLoading,
    @Default([]) List<ReciveCategory> categories,
    @Default(null) DateTime? $cachedAt,
  }) = _CategorySectionState;

  const CategorySectionState._();

  factory CategorySectionState.fromJson(Map<String, dynamic> json) =>
      _$CategorySectionStateFromJson(json);

  @override
  bool get isValidState => !isLoading && categories.isNotEmpty;
}

class CategorySectionBloc
    extends HydratedBloc<CategorySectionEvent, CategorySectionState> {
  @override
  CategorySectionState? fromJson(Map<String, dynamic> json) =>
      CategorySectionState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategorySectionState state) =>
      state.$updated.toJson();

  CategorySectionBloc() : super(const CategorySectionState()) {
    on<CategorySectionEvent>((event, emit) async {
      await event.when(
        load: () => $onInvalidCache(() => _load(emit)),
      );
    });
  }

  Future<void> _load(Emitter<CategorySectionState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    final fakeItem = ReciveCategory.fromJson({
      "id": 1,
      "name": "Breakfast",
      "slug": "breakfast",
      "image":
          "https://unsplash.com/photos/hrlvr2ZlUNk/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8YnJlYWtmYXN0fGVufDB8fHx8MTY4NjQzOTk3Mnww&force=true&w=1920",
      "description": "Delicious recipes to start your day off right.",
      "subcategories": [
        {
          "id": 101,
          "name": "Eggs",
          "image":
              "https://unsplash.com/photos/hrlvr2ZlUNk/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8YnJlYWtmYXN0fGVufDB8fHx8MTY4NjQzOTk3Mnww&force=true&w=1920",
          "description": "Egg-based recipes for breakfast."
        },
        {
          "id": 102,
          "name": "Pancakes",
          "image":
              "https://unsplash.com/photos/hrlvr2ZlUNk/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8YnJlYWtmYXN0fGVufDB8fHx8MTY4NjQzOTk3Mnww&force=true&w=1920",
          "description": "Fluffy and flavorful pancake recipes."
        }
      ],
      "difficultyLevel": "Beginner",
      "cuisineType": "Various",
      "mealType": "Breakfast",
      "dietaryTags": ["Vegetarian", "Gluten-free"],
      "nutritionalInformation": true,
      "popularRecipes": [
        {
          "id": 1001,
          "name": "Classic Omelette",
          "image":
              "https://unsplash.com/photos/hrlvr2ZlUNk/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8YnJlYWtmYXN0fGVufDB8fHx8MTY4NjQzOTk3Mnww&force=true&w=1920"
        },
        {
          "id": 1002,
          "name": "Blueberry Pancakes",
          "image":
              "https://unsplash.com/photos/hrlvr2ZlUNk/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mnx8YnJlYWtmYXN0fGVufDB8fHx8MTY4NjQzOTk3Mnww&force=true&w=1920"
        }
      ],
      "seasonalRecipes": false,
      "videoLinks": true
    });
    emit(state.copyWith(
      isLoading: false,
      categories: [
        fakeItem,
        fakeItem,
        fakeItem,
      ],
    ));
  }
}
