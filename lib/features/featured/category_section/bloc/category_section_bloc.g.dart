// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_section_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategorySectionState _$$_CategorySectionStateFromJson(
        Map<String, dynamic> json) =>
    _$_CategorySectionState(
      isCached: json['isCached'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? true,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => ReciveCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CategorySectionStateToJson(
        _$_CategorySectionState instance) =>
    <String, dynamic>{
      'isCached': instance.isCached,
      'isLoading': instance.isLoading,
      'categories': instance.categories,
    };
