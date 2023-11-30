// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExtraDataImpl<T> _$$ExtraDataImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ExtraDataImpl<T>(
      summary: _$nullableGenericFromJson(json['summary'], fromJsonT),
      heroTag: json['heroTag'] as String,
    );

Map<String, dynamic> _$$ExtraDataImplToJson<T>(
  _$ExtraDataImpl<T> instance,
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

_$ArtDetailSummaryDataImpl _$$ArtDetailSummaryDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ArtDetailSummaryDataImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$ArtDetailSummaryDataImplToJson(
        _$ArtDetailSummaryDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$CategorySummaryDataImpl _$$CategorySummaryDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CategorySummaryDataImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$CategorySummaryDataImplToJson(
        _$CategorySummaryDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$PackageSummaryDataImpl _$$PackageSummaryDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PackageSummaryDataImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$PackageSummaryDataImplToJson(
        _$PackageSummaryDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_$NewsSummaryDataImpl _$$NewsSummaryDataImplFromJson(
        Map<String, dynamic> json) =>
    _$NewsSummaryDataImpl(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$NewsSummaryDataImplToJson(
        _$NewsSummaryDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
