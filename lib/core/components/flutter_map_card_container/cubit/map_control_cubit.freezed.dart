// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_control_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapControlState _$MapControlStateFromJson(Map<String, dynamic> json) {
  return _MapControlState.fromJson(json);
}

/// @nodoc
mixin _$MapControlState {
  LatLng get userLocation => throw _privateConstructorUsedError;
  bool get showRefresh => throw _privateConstructorUsedError;
  LatLng get center => throw _privateConstructorUsedError;
  double get zoom => throw _privateConstructorUsedError;
  bool get mapInitialized => throw _privateConstructorUsedError;
  int get interations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapControlStateCopyWith<MapControlState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapControlStateCopyWith<$Res> {
  factory $MapControlStateCopyWith(
          MapControlState value, $Res Function(MapControlState) then) =
      _$MapControlStateCopyWithImpl<$Res, MapControlState>;
  @useResult
  $Res call(
      {LatLng userLocation,
      bool showRefresh,
      LatLng center,
      double zoom,
      bool mapInitialized,
      int interations});
}

/// @nodoc
class _$MapControlStateCopyWithImpl<$Res, $Val extends MapControlState>
    implements $MapControlStateCopyWith<$Res> {
  _$MapControlStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userLocation = null,
    Object? showRefresh = null,
    Object? center = null,
    Object? zoom = null,
    Object? mapInitialized = null,
    Object? interations = null,
  }) {
    return _then(_value.copyWith(
      userLocation: null == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      showRefresh: null == showRefresh
          ? _value.showRefresh
          : showRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as LatLng,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      mapInitialized: null == mapInitialized
          ? _value.mapInitialized
          : mapInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      interations: null == interations
          ? _value.interations
          : interations // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapControlStateImplCopyWith<$Res>
    implements $MapControlStateCopyWith<$Res> {
  factory _$$MapControlStateImplCopyWith(_$MapControlStateImpl value,
          $Res Function(_$MapControlStateImpl) then) =
      __$$MapControlStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LatLng userLocation,
      bool showRefresh,
      LatLng center,
      double zoom,
      bool mapInitialized,
      int interations});
}

/// @nodoc
class __$$MapControlStateImplCopyWithImpl<$Res>
    extends _$MapControlStateCopyWithImpl<$Res, _$MapControlStateImpl>
    implements _$$MapControlStateImplCopyWith<$Res> {
  __$$MapControlStateImplCopyWithImpl(
      _$MapControlStateImpl _value, $Res Function(_$MapControlStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userLocation = null,
    Object? showRefresh = null,
    Object? center = null,
    Object? zoom = null,
    Object? mapInitialized = null,
    Object? interations = null,
  }) {
    return _then(_$MapControlStateImpl(
      userLocation: null == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      showRefresh: null == showRefresh
          ? _value.showRefresh
          : showRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as LatLng,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      mapInitialized: null == mapInitialized
          ? _value.mapInitialized
          : mapInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      interations: null == interations
          ? _value.interations
          : interations // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapControlStateImpl implements _MapControlState {
  const _$MapControlStateImpl(
      {required this.userLocation,
      required this.showRefresh,
      required this.center,
      required this.zoom,
      required this.mapInitialized,
      required this.interations});

  factory _$MapControlStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapControlStateImplFromJson(json);

  @override
  final LatLng userLocation;
  @override
  final bool showRefresh;
  @override
  final LatLng center;
  @override
  final double zoom;
  @override
  final bool mapInitialized;
  @override
  final int interations;

  @override
  String toString() {
    return 'MapControlState(userLocation: $userLocation, showRefresh: $showRefresh, center: $center, zoom: $zoom, mapInitialized: $mapInitialized, interations: $interations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapControlStateImpl &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation) &&
            (identical(other.showRefresh, showRefresh) ||
                other.showRefresh == showRefresh) &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.mapInitialized, mapInitialized) ||
                other.mapInitialized == mapInitialized) &&
            (identical(other.interations, interations) ||
                other.interations == interations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userLocation, showRefresh,
      center, zoom, mapInitialized, interations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapControlStateImplCopyWith<_$MapControlStateImpl> get copyWith =>
      __$$MapControlStateImplCopyWithImpl<_$MapControlStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapControlStateImplToJson(
      this,
    );
  }
}

abstract class _MapControlState implements MapControlState {
  const factory _MapControlState(
      {required final LatLng userLocation,
      required final bool showRefresh,
      required final LatLng center,
      required final double zoom,
      required final bool mapInitialized,
      required final int interations}) = _$MapControlStateImpl;

  factory _MapControlState.fromJson(Map<String, dynamic> json) =
      _$MapControlStateImpl.fromJson;

  @override
  LatLng get userLocation;
  @override
  bool get showRefresh;
  @override
  LatLng get center;
  @override
  double get zoom;
  @override
  bool get mapInitialized;
  @override
  int get interations;
  @override
  @JsonKey(ignore: true)
  _$$MapControlStateImplCopyWith<_$MapControlStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
