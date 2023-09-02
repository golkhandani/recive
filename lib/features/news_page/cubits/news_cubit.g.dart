// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewsState _$$_NewsStateFromJson(Map<String, dynamic> json) => _$_NewsState(
      selectedLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['selectedLoadingState']),
      selected: json['selected'] == null
          ? null
          : NewsModel.fromJson(json['selected'] as Map<String, dynamic>),
      news: (json['news'] as List<dynamic>)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newsSpotlight: (json['newsSpotlight'] as List<dynamic>)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_NewsStateToJson(_$_NewsState instance) =>
    <String, dynamic>{
      'selectedLoadingState':
          _$LoadingStateEnumMap[instance.selectedLoadingState]!,
      'selected': instance.selected,
      'news': instance.news,
      'newsSpotlight': instance.newsSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
