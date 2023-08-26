// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_events_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchEventsState _$$_SearchEventsStateFromJson(Map<String, dynamic> json) =>
    _$_SearchEventsState(
      preSelectedEventIndex: json['preSelectedEventIndex'] as int,
      searchedEvents: (json['searchedEvents'] as List<dynamic>)
          .map((e) => EventComplete.fromJson(e as Map<String, dynamic>))
          .toList(),
      searchedkeywords: (json['searchedkeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_SearchEventsStateToJson(
        _$_SearchEventsState instance) =>
    <String, dynamic>{
      'preSelectedEventIndex': instance.preSelectedEventIndex,
      'searchedEvents': instance.searchedEvents,
      'searchedkeywords': instance.searchedkeywords,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
