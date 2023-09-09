// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_control_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapControlState _$$_MapControlStateFromJson(Map<String, dynamic> json) =>
    _$_MapControlState(
      showRefresh: json['showRefresh'] as bool,
      center: LatLng.fromJson(json['center'] as Map<String, dynamic>),
      zoom: (json['zoom'] as num).toDouble(),
      mapInitialized: json['mapInitialized'] as bool,
      interations: json['interations'] as int,
    );

Map<String, dynamic> _$$_MapControlStateToJson(_$_MapControlState instance) =>
    <String, dynamic>{
      'showRefresh': instance.showRefresh,
      'center': instance.center,
      'zoom': instance.zoom,
      'mapInitialized': instance.mapInitialized,
      'interations': instance.interations,
    };
