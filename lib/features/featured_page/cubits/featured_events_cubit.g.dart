// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_events_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeatureEventsState _$$_FeatureEventsStateFromJson(
        Map<String, dynamic> json) =>
    _$_FeatureEventsState(
      artAbstractItem: json['artAbstractItem'] == null
          ? null
          : ArtAbstractModel.fromJson(
              json['artAbstractItem'] as Map<String, dynamic>),
      artItem: json['artItem'] == null
          ? null
          : ArtModel.fromJson(json['artItem'] as Map<String, dynamic>),
      artAbstractItems: (json['artAbstractItems'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      artAbstractItemsSpotlight:
          (json['artAbstractItemsSpotlight'] as List<dynamic>)
              .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_FeatureEventsStateToJson(
        _$_FeatureEventsState instance) =>
    <String, dynamic>{
      'artAbstractItem': instance.artAbstractItem,
      'artItem': instance.artItem,
      'artAbstractItems': instance.artAbstractItems,
      'artAbstractItemsSpotlight': instance.artAbstractItemsSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
