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
      location: json['location'] as String,
      organizers: (json['organizers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_FeaturedEventToJson(_$_FeaturedEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'organizers': instance.organizers,
      'participants': instance.participants,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
    };
