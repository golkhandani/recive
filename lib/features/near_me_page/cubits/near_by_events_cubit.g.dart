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
      isRefreshLoading: json['isRefreshLoading'] as bool,
      queryFilter: json['queryFilter'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      minDistance: (json['minDistance'] as num).toDouble(),
      maxDistance: (json['maxDistance'] as num).toDouble(),
    );

Map<String, dynamic> _$$_NearbyEventsStateToJson(
        _$_NearbyEventsState instance) =>
    <String, dynamic>{
      'preSelectedEventIndex': instance.preSelectedEventIndex,
      'nearbyEvents': instance.nearbyEvents,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
      'isRefreshLoading': instance.isRefreshLoading,
      'queryFilter': instance.queryFilter,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'minDistance': instance.minDistance,
      'maxDistance': instance.maxDistance,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
