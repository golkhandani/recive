// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_events_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeatureEventsState _$$_FeatureEventsStateFromJson(
        Map<String, dynamic> json) =>
    _$_FeatureEventsState(
      featuredEventSummary: json['featuredEventSummary'] == null
          ? null
          : FeaturedEvent.fromJson(
              json['featuredEventSummary'] as Map<String, dynamic>),
      featuredEvent: json['featuredEvent'] == null
          ? null
          : FeaturedEvent.fromJson(
              json['featuredEvent'] as Map<String, dynamic>),
      featuredEvents: (json['featuredEvents'] as List<dynamic>)
          .map((e) => FeaturedEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredEventsSpotlight:
          (json['featuredEventsSpotlight'] as List<dynamic>)
              .map((e) => FeaturedEvent.fromJson(e as Map<String, dynamic>))
              .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_FeatureEventsStateToJson(
        _$_FeatureEventsState instance) =>
    <String, dynamic>{
      'featuredEventSummary': instance.featuredEventSummary,
      'featuredEvent': instance.featuredEvent,
      'featuredEvents': instance.featuredEvents,
      'featuredEventsSpotlight': instance.featuredEventsSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
