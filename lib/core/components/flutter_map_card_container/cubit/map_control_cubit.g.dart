// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_control_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapControlStateImpl _$$MapControlStateImplFromJson(
        Map<String, dynamic> json) =>
    _$MapControlStateImpl(
      userLocation:
          LatLng.fromJson(json['userLocation'] as Map<String, dynamic>),
      showRefresh: json['showRefresh'] as bool,
      center: LatLng.fromJson(json['center'] as Map<String, dynamic>),
      zoom: (json['zoom'] as num).toDouble(),
      mapInitialized: json['mapInitialized'] as bool,
      interations: json['interations'] as int,
    );

Map<String, dynamic> _$$MapControlStateImplToJson(
        _$MapControlStateImpl instance) =>
    <String, dynamic>{
      'userLocation': instance.userLocation,
      'showRefresh': instance.showRefresh,
      'center': instance.center,
      'zoom': instance.zoom,
      'mapInitialized': instance.mapInitialized,
      'interations': instance.interations,
    };
