// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_custom_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCustomDataImpl _$$UserCustomDataImplFromJson(Map<String, dynamic> json) =>
    _$UserCustomDataImpl(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      imageUrl: json['image_url'] as String?,
      name: json['name'] as String?,
      bookmarkArts: (json['bookmark_arts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$$UserCustomDataImplToJson(
        _$UserCustomDataImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'image_url': instance.imageUrl,
      'name': instance.name,
      'bookmark_arts': instance.bookmarkArts,
    };
