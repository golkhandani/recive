// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NearbyEvent _$$_NearbyEventFromJson(Map<String, dynamic> json) =>
    _$_NearbyEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      location: json['location'] as String,
      organizers: (json['organizers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String,
      latLng: LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NearbyEventToJson(_$_NearbyEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'location': instance.location,
      'organizers': instance.organizers,
      'participants': instance.participants,
      'imageUrl': instance.imageUrl,
      'latLng': instance.latLng,
    };
