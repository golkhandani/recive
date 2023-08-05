// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Fasting _$$_FastingFromJson(Map<String, dynamic> json) => _$_Fasting(
      title: json['title'] as String,
      description: json['description'] as String,
      fastingWindowDuration: json['fastingWindowDuration'] as int,
      fastingWindowStart: json['fastingWindowStart'] as int,
      eatingWindowDuration: json['eatingWindowDuration'] as int,
      fastingHours: (json['fastingHours'] as List<dynamic>)
          .map((e) => FastingHour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FastingToJson(_$_Fasting instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'fastingWindowDuration': instance.fastingWindowDuration,
      'fastingWindowStart': instance.fastingWindowStart,
      'eatingWindowDuration': instance.eatingWindowDuration,
      'fastingHours': instance.fastingHours,
    };

_$_FastingHour _$$_FastingHourFromJson(Map<String, dynamic> json) =>
    _$_FastingHour(
      start: json['start'] as int,
      end: json['end'] as int,
      description: json['description'] as String,
      colorHex: json['colorHex'] as String,
    );

Map<String, dynamic> _$$_FastingHourToJson(_$_FastingHour instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'description': instance.description,
      'colorHex': instance.colorHex,
    };

_$_FastingTimer _$$_FastingTimerFromJson(Map<String, dynamic> json) =>
    _$_FastingTimer(
      hours: json['hours'] as int,
      minutes: json['minutes'] as int,
      seconds: json['seconds'] as int,
    );

Map<String, dynamic> _$$_FastingTimerToJson(_$_FastingTimer instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'minutes': instance.minutes,
      'seconds': instance.seconds,
    };
