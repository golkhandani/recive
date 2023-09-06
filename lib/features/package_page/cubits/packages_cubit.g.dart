// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackagesState _$$_PackagesStateFromJson(Map<String, dynamic> json) =>
    _$_PackagesState(
      packageLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['packageLoadingState']),
      package: json['package'] == null
          ? null
          : Package.fromJson(json['package'] as Map<String, dynamic>),
      packages: (json['packages'] as List<dynamic>)
          .map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      packagesSpotlight: (json['packagesSpotlight'] as List<dynamic>)
          .map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
    );

Map<String, dynamic> _$$_PackagesStateToJson(_$_PackagesState instance) =>
    <String, dynamic>{
      'packageLoadingState':
          _$LoadingStateEnumMap[instance.packageLoadingState]!,
      'package': instance.package,
      'packages': instance.packages,
      'packagesSpotlight': instance.packagesSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
