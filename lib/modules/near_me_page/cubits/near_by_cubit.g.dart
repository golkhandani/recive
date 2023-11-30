// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_by_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearbyStateImpl _$$NearbyStateImplFromJson(Map<String, dynamic> json) =>
    _$NearbyStateImpl(
      preSelectedIndex: json['preSelectedIndex'] as int,
      nearbyArts: (json['nearbyArts'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
      isRefreshLoading: json['isRefreshLoading'] as bool,
      queryFilter: json['queryFilter'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      minDistance: (json['minDistance'] as num).toDouble(),
      maxDistance: (json['maxDistance'] as num).toDouble(),
    );

Map<String, dynamic> _$$NearbyStateImplToJson(_$NearbyStateImpl instance) =>
    <String, dynamic>{
      'preSelectedIndex': instance.preSelectedIndex,
      'nearbyArts': instance.nearbyArts,
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
