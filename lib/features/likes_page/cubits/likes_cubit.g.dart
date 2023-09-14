// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LikesState _$$_LikesStateFromJson(Map<String, dynamic> json) =>
    _$_LikesState(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
      count: json['count'] as int,
      bookmarkEvents: (json['bookmarkEvents'] as List<dynamic>)
          .map((e) => FeaturedEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_LikesStateToJson(_$_LikesState instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'count': instance.count,
      'bookmarkEvents': instance.bookmarkEvents,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
