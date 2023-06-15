// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recive_category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReciveCategory _$$_ReciveCategoryFromJson(Map<String, dynamic> json) =>
    _$_ReciveCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      subcategories: (json['subcategories'] as List<dynamic>)
          .map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficultyLevel: json['difficultyLevel'] as String,
      cuisineType: json['cuisineType'] as String,
      mealType: json['mealType'] as String,
      dietaryTags: (json['dietaryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nutritionalInformation: json['nutritionalInformation'] as bool,
      popularRecipes: (json['popularRecipes'] as List<dynamic>)
          .map((e) => PopularRecipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasonalRecipes: json['seasonalRecipes'] as bool,
      videoLinks: json['videoLinks'] as bool,
    );

Map<String, dynamic> _$$_ReciveCategoryToJson(_$_ReciveCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'description': instance.description,
      'subcategories': instance.subcategories,
      'difficultyLevel': instance.difficultyLevel,
      'cuisineType': instance.cuisineType,
      'mealType': instance.mealType,
      'dietaryTags': instance.dietaryTags,
      'nutritionalInformation': instance.nutritionalInformation,
      'popularRecipes': instance.popularRecipes,
      'seasonalRecipes': instance.seasonalRecipes,
      'videoLinks': instance.videoLinks,
    };

_$_PopularRecipe _$$_PopularRecipeFromJson(Map<String, dynamic> json) =>
    _$_PopularRecipe(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$_PopularRecipeToJson(_$_PopularRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

_$_Subcategory _$$_SubcategoryFromJson(Map<String, dynamic> json) =>
    _$_Subcategory(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_SubcategoryToJson(_$_Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
    };
