// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_custom_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCustomData _$$_UserCustomDataFromJson(Map<String, dynamic> json) =>
    _$_UserCustomData(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      imageUrl: json['image_url'] as String?,
      name: json['name'] as String?,
      favouriteEvent: (json['favourite_events'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_UserCustomDataToJson(_$_UserCustomData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'image_url': instance.imageUrl,
      'name': instance.name,
      'favourite_events': instance.favouriteEvent,
    };
