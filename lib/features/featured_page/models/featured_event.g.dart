// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeaturedEvent _$$_FeaturedEventFromJson(Map<String, dynamic> json) =>
    _$_FeaturedEvent(
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
    );

Map<String, dynamic> _$$_FeaturedEventToJson(_$_FeaturedEvent instance) =>
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
    };
