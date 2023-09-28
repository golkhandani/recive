// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate_state.dart';

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
