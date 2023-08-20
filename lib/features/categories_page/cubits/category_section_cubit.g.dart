// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_section_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoriesState _$$_CategoriesStateFromJson(Map<String, dynamic> json) =>
    _$_CategoriesState(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoriesSpotlight: (json['categoriesSpotlight'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_CategoriesStateToJson(_$_CategoriesState instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'categoriesSpotlight': instance.categoriesSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
