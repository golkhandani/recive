// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeting_header_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GreetingHeaderState _$$_GreetingHeaderStateFromJson(
        Map<String, dynamic> json) =>
    _$_GreetingHeaderState(
      isCached: json['isCached'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? true,
      notificationCount: json['notificationCount'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GreetingHeaderStateToJson(
        _$_GreetingHeaderState instance) =>
    <String, dynamic>{
      'isCached': instance.isCached,
      'isLoading': instance.isLoading,
      'notificationCount': instance.notificationCount,
      'user': instance.user,
    };
