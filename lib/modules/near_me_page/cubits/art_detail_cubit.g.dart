// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_detail_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArtDetailState _$$_ArtDetailStateFromJson(Map<String, dynamic> json) =>
    _$_ArtDetailState(
      isBookmarked: json['isBookmarked'] as bool,
      preSelectedIndex: json['preSelectedIndex'] as int,
      nearbyItem: json['nearbyItem'] == null
          ? null
          : ArtModel.fromJson(json['nearbyItem'] as Map<String, dynamic>),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_ArtDetailStateToJson(_$_ArtDetailState instance) =>
    <String, dynamic>{
      'isBookmarked': instance.isBookmarked,
      'preSelectedIndex': instance.preSelectedIndex,
      'nearbyItem': instance.nearbyItem,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
