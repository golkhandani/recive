// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_section_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategorySectionState _$$_CategorySectionStateFromJson(
        Map<String, dynamic> json) =>
    _$_CategorySectionState(
      isLoada: json['isLoada'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? true,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => ReciveCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $cachedAt: json[r'$cachedAt'] == null
          ? null
          : DateTime.parse(json[r'$cachedAt'] as String),
    );

Map<String, dynamic> _$$_CategorySectionStateToJson(
        _$_CategorySectionState instance) =>
    <String, dynamic>{
      'isLoada': instance.isLoada,
      'isLoading': instance.isLoading,
      'categories': instance.categories,
      r'$cachedAt': instance.$cachedAt?.toIso8601String(),
    };
