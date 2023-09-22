// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeaturedState _$$_FeaturedStateFromJson(Map<String, dynamic> json) =>
    _$_FeaturedState(
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

Map<String, dynamic> _$$_FeaturedStateToJson(_$_FeaturedState instance) =>
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
