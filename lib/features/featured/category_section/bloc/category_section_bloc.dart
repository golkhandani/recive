import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/models/recive_category.model.dart';
import 'package:recive/utils/valid_bloc_cache.dart';

part 'category_section_event.dart';
part 'category_section_state.dart';
part 'category_section_bloc.freezed.dart';
part 'category_section_bloc.g.dart';

class CategorySectionBloc
    extends HydratedBloc<CategorySectionEvent, CategorySectionState> {
  @override
  CategorySectionState? fromJson(Map<String, dynamic> json) =>
      CategorySectionState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategorySectionState state) => state.toJson();
  CategorySectionBloc() : super(const CategorySectionState()) {
    on<CategorySectionEvent>((event, emit) async {
      await event.when(
        load: () => _load(emit),
      );
    });
  }

  Future<void> _load(Emitter<CategorySectionState> emit) async {
    print(state is StateWithIsLoading);
    if (isCached) {
      return;
    }
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
