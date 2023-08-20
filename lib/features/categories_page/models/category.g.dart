// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaginationState _$$_PaginationStateFromJson(Map<String, dynamic> json) =>
    _$_PaginationState(
      page: json['page'] as int,
      itemPerPage: json['itemPerPage'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$$_PaginationStateToJson(_$_PaginationState instance) =>
    <String, dynamic>{
      'page': instance.page,
      'itemPerPage': instance.itemPerPage,
      'total': instance.total,
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
