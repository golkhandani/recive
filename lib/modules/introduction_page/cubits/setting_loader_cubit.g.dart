// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_loader_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingLoaderStateImpl _$$SettingLoaderStateImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingLoaderStateImpl(
      isLoggedIn: json['isLoggedIn'] as bool,
      isIntroViewed: json['isIntroViewed'] as bool,
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$SettingLoaderStateImplToJson(
        _$SettingLoaderStateImpl instance) =>
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
