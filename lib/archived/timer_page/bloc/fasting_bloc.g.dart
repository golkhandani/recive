// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FastingState _$$_FastingStateFromJson(Map<String, dynamic> json) =>
    _$_FastingState(
      $cachedAt: json[r'$cachedAt'] == null
          ? null
          : DateTime.parse(json[r'$cachedAt'] as String),
      isLoading: json['isLoading'] as bool? ?? false,
      fastings: (json['fastings'] as List<dynamic>?)
              ?.map((e) => Fasting.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedFastings: json['selectedFastings'] == null
          ? null
          : Fasting.fromJson(json['selectedFastings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FastingStateToJson(_$_FastingState instance) =>
    <String, dynamic>{
      r'$cachedAt': instance.$cachedAt?.toIso8601String(),
      'isLoading': instance.isLoading,
      'fastings': instance.fastings,
      'selectedFastings': instance.selectedFastings,
    };
