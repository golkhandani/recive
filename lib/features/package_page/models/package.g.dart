// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Package _$$_PackageFromJson(Map<String, dynamic> json) => _$_Package(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      events: (json['events'] as List<dynamic>)
          .map((e) => NearbyEvent.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$$_PackageToJson(_$_Package instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'events': instance.events,
      'polyline': instance.polyline,
      'roadInstructions': instance.roadInstructions,
      'distance': instance.distance,
      'duration': instance.duration.inMicroseconds,
    };
