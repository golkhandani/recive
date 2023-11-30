// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchStateImpl _$$SearchStateImplFromJson(Map<String, dynamic> json) =>
    _$SearchStateImpl(
      preSelectedIndex: json['preSelectedIndex'] as int,
      searchedItems: (json['searchedItems'] as List<dynamic>)
          .map((e) => ArtRouteAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingKeywordsState:
          $enumDecode(_$LoadingStateEnumMap, json['loadingKeywordsState']),
      searchedkeywords: (json['searchedkeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
      distanceFilter: json['distanceFilter'] as int?,
      queryFilter: json['queryFilter'] as String?,
    );

Map<String, dynamic> _$$SearchStateImplToJson(_$SearchStateImpl instance) =>
    <String, dynamic>{
      'preSelectedIndex': instance.preSelectedIndex,
      'searchedItems': instance.searchedItems,
      'loadingKeywordsState':
          _$LoadingStateEnumMap[instance.loadingKeywordsState]!,
      'searchedkeywords': instance.searchedkeywords,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
      'distanceFilter': instance.distanceFilter,
      'queryFilter': instance.queryFilter,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
