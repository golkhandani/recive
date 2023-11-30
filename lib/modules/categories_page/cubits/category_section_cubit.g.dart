// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_section_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoriesStateImpl _$$CategoriesStateImplFromJson(
        Map<String, dynamic> json) =>
    _$CategoriesStateImpl(
      categoryLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['categoryLoadingState']),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoriesSpotlight: (json['categoriesSpotlight'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (json['items'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$CategoriesStateImplToJson(
        _$CategoriesStateImpl instance) =>
    <String, dynamic>{
      'categoryLoadingState':
          _$LoadingStateEnumMap[instance.categoryLoadingState]!,
      'category': instance.category,
      'categories': instance.categories,
      'categoriesSpotlight': instance.categoriesSpotlight,
      'items': instance.items,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
