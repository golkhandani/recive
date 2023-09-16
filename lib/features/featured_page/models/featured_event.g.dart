// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArtAbstractModel _$$_ArtAbstractModelFromJson(Map<String, dynamic> json) =>
    _$_ArtAbstractModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      geoLocation: LatLng.fromJson(json['geoLocation'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ArtAbstractModelToJson(_$_ArtAbstractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'geoLocation': instance.geoLocation,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
    };
