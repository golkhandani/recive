// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_by_events_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NearbyEventsState _$$_NearbyEventsStateFromJson(Map<String, dynamic> json) =>
    _$_NearbyEventsState(
      preSelectedEventIndex: json['preSelectedEventIndex'] as int,
      nearbyEvents: (json['nearbyEvents'] as List<dynamic>)
          .map((e) => NearbyEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_NearbyEventsStateToJson(
        _$_NearbyEventsState instance) =>
    <String, dynamic>{
      'preSelectedEventIndex': instance.preSelectedEventIndex,
      'nearbyEvents': instance.nearbyEvents,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
