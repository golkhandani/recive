// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationStateImpl _$$PaginationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginationStateImpl(
      page: json['page'] as int,
      itemPerPage: json['itemPerPage'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$$PaginationStateImplToJson(
        _$PaginationStateImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'itemPerPage': instance.itemPerPage,
      'total': instance.total,
    };
