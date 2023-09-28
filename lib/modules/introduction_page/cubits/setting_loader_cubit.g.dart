// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_loader_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingLoaderState _$$_SettingLoaderStateFromJson(
        Map<String, dynamic> json) =>
    _$_SettingLoaderState(
      isLoggedIn: json['isLoggedIn'] as bool,
      isIntroViewed: json['isIntroViewed'] as bool,
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_SettingLoaderStateToJson(
        _$_SettingLoaderState instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'isIntroViewed': instance.isIntroViewed,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
