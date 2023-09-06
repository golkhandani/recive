// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExtraData<T> _$$_ExtraDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_ExtraData<T>(
      summary: _$nullableGenericFromJson(json['summary'], fromJsonT),
      heroTag: json['heroTag'] as String,
    );

Map<String, dynamic> _$$_ExtraDataToJson<T>(
  _$_ExtraData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'summary': _$nullableGenericToJson(instance.summary, toJsonT),
      'heroTag': instance.heroTag,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

_$_FeaturedEventDetailSummaryData _$$_FeaturedEventDetailSummaryDataFromJson(
        Map<String, dynamic> json) =>
    _$_FeaturedEventDetailSummaryData(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_FeaturedEventDetailSummaryDataToJson(
        _$_FeaturedEventDetailSummaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$_NearbyDetailSummaryData _$$_NearbyDetailSummaryDataFromJson(
        Map<String, dynamic> json) =>
    _$_NearbyDetailSummaryData(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_NearbyDetailSummaryDataToJson(
        _$_NearbyDetailSummaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$_CategorySummaryData _$$_CategorySummaryDataFromJson(
        Map<String, dynamic> json) =>
    _$_CategorySummaryData(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_CategorySummaryDataToJson(
        _$_CategorySummaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$_PackageSummaryData _$$_PackageSummaryDataFromJson(
        Map<String, dynamic> json) =>
    _$_PackageSummaryData(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_PackageSummaryDataToJson(
        _$_PackageSummaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$_NewsSummaryData _$$_NewsSummaryDataFromJson(Map<String, dynamic> json) =>
    _$_NewsSummaryData(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$_NewsSummaryDataToJson(_$_NewsSummaryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
