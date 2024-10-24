// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtRouteModelImpl _$$ArtRouteModelImplFromJson(Map<String, dynamic> json) =>
    _$ArtRouteModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      arts: (json['arts'] as List<dynamic>)
          .map((e) => ArtAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      polyline: (json['polyline'] as List<dynamic>?)
          ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      roadInstructions: (json['roadInstructions'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      distance: (json['distance'] as num).toDouble(),
      duration: Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$$ArtRouteModelImplToJson(_$ArtRouteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'arts': instance.arts,
      'polyline': instance.polyline,
      'roadInstructions': instance.roadInstructions,
      'distance': instance.distance,
      'duration': instance.duration.inMicroseconds,
    };

_$ArtRouteAbstractModelImpl _$$ArtRouteAbstractModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ArtRouteAbstractModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$$ArtRouteAbstractModelImplToJson(
        _$ArtRouteAbstractModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'distance': instance.distance,
      'duration': instance.duration.inMicroseconds,
    };
