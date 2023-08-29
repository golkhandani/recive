// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginState _$$_LoginStateFromJson(Map<String, dynamic> json) =>
    _$_LoginState(
      isLoggedIn: json['isLoggedIn'] as bool,
      googleLoginLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['googleLoginLoadingState']),
      appleLoginLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['appleLoginLoadingState']),
      logoutLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['logoutLoadingState']),
    );

Map<String, dynamic> _$$_LoginStateToJson(_$_LoginState instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'googleLoginLoadingState':
          _$LoadingStateEnumMap[instance.googleLoginLoadingState]!,
      'appleLoginLoadingState':
          _$LoadingStateEnumMap[instance.appleLoginLoadingState]!,
      'logoutLoadingState': _$LoadingStateEnumMap[instance.logoutLoadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
