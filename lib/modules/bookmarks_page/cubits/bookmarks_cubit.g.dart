// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarksStateImpl _$$BookmarksStateImplFromJson(Map<String, dynamic> json) =>
    _$BookmarksStateImpl(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
      count: json['count'] as int,
      bookmarkArts: (json['bookmarkArts'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$BookmarksStateImplToJson(
        _$BookmarksStateImpl instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'count': instance.count,
      'bookmarkArts': instance.bookmarkArts,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
