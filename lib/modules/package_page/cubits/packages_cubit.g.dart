// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackagesStateImpl _$$PackagesStateImplFromJson(Map<String, dynamic> json) =>
    _$PackagesStateImpl(
      packageLoadingState:
          $enumDecode(_$LoadingStateEnumMap, json['packageLoadingState']),
      package: json['package'] == null
          ? null
          : ArtRouteModel.fromJson(json['package'] as Map<String, dynamic>),
      packages: (json['packages'] as List<dynamic>)
          .map((e) => ArtRouteAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      packagesSpotlight: (json['packagesSpotlight'] as List<dynamic>)
          .map((e) => ArtRouteAbstractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadingState: $enumDecode(_$LoadingStateEnumMap, json['loadingState']),
      loadingMoreState:
          $enumDecode(_$LoadingStateEnumMap, json['loadingMoreState']),
    );

Map<String, dynamic> _$$PackagesStateImplToJson(_$PackagesStateImpl instance) =>
    <String, dynamic>{
      'packageLoadingState':
          _$LoadingStateEnumMap[instance.packageLoadingState]!,
      'package': instance.package,
      'packages': instance.packages,
      'packagesSpotlight': instance.packagesSpotlight,
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
      'loadingMoreState': _$LoadingStateEnumMap[instance.loadingMoreState]!,
    };

const _$LoadingStateEnumMap = {
  LoadingState.none: 'none',
  LoadingState.loading: 'loading',
  LoadingState.updating: 'updating',
  LoadingState.done: 'done',
  LoadingState.error: 'error',
};
