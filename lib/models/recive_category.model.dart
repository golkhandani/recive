// To parse this JSON data, do
//
//     final reciveCategory = reciveCategoryFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recive_category.model.freezed.dart';
part 'recive_category.model.g.dart';

@freezed
class ReciveCategory with _$ReciveCategory {
  const factory ReciveCategory({
    required int id,
    required String name,
    required String slug,
    required String image,
    required String description,
    required List<Subcategory> subcategories,
    required String difficultyLevel,
    required String cuisineType,
    required String mealType,
    required List<String> dietaryTags,
    required bool nutritionalInformation,
    required List<PopularRecipe> popularRecipes,
    required bool seasonalRecipes,
    required bool videoLinks,
  }) = _ReciveCategory;

  factory ReciveCategory.fromJson(Map<String, dynamic> json) =>
      _$ReciveCategoryFromJson(json);
}

@freezed
class PopularRecipe with _$PopularRecipe {
  const factory PopularRecipe({
    required int id,
    required String name,
    required String image,
  }) = _PopularRecipe;

  factory PopularRecipe.fromJson(Map<String, dynamic> json) =>
      _$PopularRecipeFromJson(json);
}

@freezed
class Subcategory with _$Subcategory {
  const factory Subcategory({
    required int id,
    required String name,
    required String image,
    required String description,
  }) = _Subcategory;

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);
}
