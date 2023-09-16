// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookmarksState _$$_BookmarksStateFromJson(Map<String, dynamic> json) =>
    _$_BookmarksState(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
      count: json['count'] as int,
      bookmarkEvents: (json['bookmarkEvents'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_BookmarksStateToJson(_$_BookmarksState instance) =>
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
