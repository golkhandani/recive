// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recive.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recive _$$_ReciveFromJson(Map<String, dynamic> json) => _$_Recive(
      title: json['title'] as String,
      creatorSummary: CreatorSummary.fromJson(
          json['creatorSummary'] as Map<String, dynamic>),
      origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => InstructionStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficultyLevel:
          $enumDecode(_$DifficultyLevelEnumMap, json['difficultyLevel']),
      preparationTimeMinute: json['preparationTimeMinute'] as int,
      cookingTimeMinute: json['cookingTimeMinute'] as int,
      serving: json['serving'] as String,
      cuisineType: json['cuisineType'] as String,
      calories: json['calories'] as int,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      allergens: (json['allergens'] as List<dynamic>)
          .map((e) => Allergen.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: json['source'] as String,
      variations: (json['variations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ReciveToJson(_$_Recive instance) => <String, dynamic>{
      'title': instance.title,
      'creatorSummary': instance.creatorSummary,
      'origin': instance.origin,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel]!,
      'preparationTimeMinute': instance.preparationTimeMinute,
      'cookingTimeMinute': instance.cookingTimeMinute,
      'serving': instance.serving,
      'cuisineType': instance.cuisineType,
      'calories': instance.calories,
      'imageUrls': instance.imageUrls,
      'tags': instance.tags,
      'allergens': instance.allergens,
      'source': instance.source,
      'variations': instance.variations,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
};

_$_Allergen _$$_AllergenFromJson(Map<String, dynamic> json) => _$_Allergen(
      name: json['name'] as String,
      infoLink: json['infoLink'] as String,
    );

Map<String, dynamic> _$$_AllergenToJson(_$_Allergen instance) =>
    <String, dynamic>{
      'name': instance.name,
      'infoLink': instance.infoLink,
    };

_$_Ingredient _$$_IngredientFromJson(Map<String, dynamic> json) =>
    _$_Ingredient(
      amount: (json['amount'] as num).toDouble(),
      measurement: json['measurement'] as String,
      svgIcon: json['svgIcon'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_IngredientToJson(_$_Ingredient instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'measurement': instance.measurement,
      'svgIcon': instance.svgIcon,
      'name': instance.name,
    };

_$_InstructionStep _$$_InstructionStepFromJson(Map<String, dynamic> json) =>
    _$_InstructionStep(
      name: json['name'] as String,
      description: json['description'] as String,
      preparationTimeMinute: json['preparationTimeMinute'] as int,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_InstructionStepToJson(_$_InstructionStep instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'preparationTimeMinute': instance.preparationTimeMinute,
      'imageUrls': instance.imageUrls,
    };

_$_CreatorSummary _$$_CreatorSummaryFromJson(Map<String, dynamic> json) =>
    _$_CreatorSummary(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_CreatorSummaryToJson(_$_CreatorSummary instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
    };

_$_Origin _$$_OriginFromJson(Map<String, dynamic> json) => _$_Origin(
      code: json['code'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$_OriginToJson(_$_Origin instance) => <String, dynamic>{
      'code': instance.code,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'title': instance.title,
    };
