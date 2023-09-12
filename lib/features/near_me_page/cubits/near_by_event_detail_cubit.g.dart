// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_by_event_detail_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NearbyEventDetailState _$$_NearbyEventDetailStateFromJson(
        Map<String, dynamic> json) =>
    _$_NearbyEventDetailState(
      isFavourite: json['isFavourite'] as bool,
      preSelectedEventIndex: json['preSelectedEventIndex'] as int,
      nearbyEvent: json['nearbyEvent'] == null
          ? null
          : EventComplete.fromJson(json['nearbyEvent'] as Map<String, dynamic>),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_NearbyEventDetailStateToJson(
        _$_NearbyEventDetailState instance) =>
    <String, dynamic>{
      'isFavourite': instance.isFavourite,
      'preSelectedEventIndex': instance.preSelectedEventIndex,
      'nearbyEvent': instance.nearbyEvent,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
