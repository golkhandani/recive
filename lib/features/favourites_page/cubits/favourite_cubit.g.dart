// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavouritesState _$$_FavouritesStateFromJson(Map<String, dynamic> json) =>
    _$_FavouritesState(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
      count: json['count'] as int,
      favouriteEvents: (json['favouriteEvents'] as List<dynamic>)
          .map((e) => FeaturedEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_FavouritesStateToJson(_$_FavouritesState instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'count': instance.count,
      'favouriteEvents': instance.favouriteEvents,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
