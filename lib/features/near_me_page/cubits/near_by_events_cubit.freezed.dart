// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'near_by_events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NearbyEventsState _$NearbyEventsStateFromJson(Map<String, dynamic> json) {
  return _NearbyEventsState.fromJson(json);
}

/// @nodoc
mixin _$NearbyEventsState {
  int get preSelectedEventIndex => throw _privateConstructorUsedError;
  List<NearbyEvent> get nearbyEvents => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;
  bool get isRefreshLoading => throw _privateConstructorUsedError;
  String? get queryFilter => throw _privateConstructorUsedError;

  ///
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get minDistance => throw _privateConstructorUsedError;
  double get maxDistance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbyEventsStateCopyWith<NearbyEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyEventsStateCopyWith<$Res> {
  factory $NearbyEventsStateCopyWith(
          NearbyEventsState value, $Res Function(NearbyEventsState) then) =
      _$NearbyEventsStateCopyWithImpl<$Res, NearbyEventsState>;
  @useResult
  $Res call(
      {int preSelectedEventIndex,
      List<NearbyEvent> nearbyEvents,
      LoadingState loadingState,
      bool isRefreshLoading,
      String? queryFilter,
      double latitude,
      double longitude,
      double minDistance,
      double maxDistance});
}

/// @nodoc
class _$NearbyEventsStateCopyWithImpl<$Res, $Val extends NearbyEventsState>
    implements $NearbyEventsStateCopyWith<$Res> {
  _$NearbyEventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedEventIndex = null,
    Object? nearbyEvents = null,
    Object? loadingState = null,
    Object? isRefreshLoading = null,
    Object? queryFilter = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? minDistance = null,
    Object? maxDistance = null,
  }) {
    return _then(_value.copyWith(
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyEvents: null == nearbyEvents
          ? _value.nearbyEvents
          : nearbyEvents // ignore: cast_nullable_to_non_nullable
              as List<NearbyEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      isRefreshLoading: null == isRefreshLoading
          ? _value.isRefreshLoading
          : isRefreshLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      queryFilter: freezed == queryFilter
          ? _value.queryFilter
          : queryFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      minDistance: null == minDistance
          ? _value.minDistance
          : minDistance // ignore: cast_nullable_to_non_nullable
              as double,
      maxDistance: null == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NearbyEventsStateCopyWith<$Res>
    implements $NearbyEventsStateCopyWith<$Res> {
  factory _$$_NearbyEventsStateCopyWith(_$_NearbyEventsState value,
          $Res Function(_$_NearbyEventsState) then) =
      __$$_NearbyEventsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int preSelectedEventIndex,
      List<NearbyEvent> nearbyEvents,
      LoadingState loadingState,
      bool isRefreshLoading,
      String? queryFilter,
      double latitude,
      double longitude,
      double minDistance,
      double maxDistance});
}

/// @nodoc
class __$$_NearbyEventsStateCopyWithImpl<$Res>
    extends _$NearbyEventsStateCopyWithImpl<$Res, _$_NearbyEventsState>
    implements _$$_NearbyEventsStateCopyWith<$Res> {
  __$$_NearbyEventsStateCopyWithImpl(
      _$_NearbyEventsState _value, $Res Function(_$_NearbyEventsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedEventIndex = null,
    Object? nearbyEvents = null,
    Object? loadingState = null,
    Object? isRefreshLoading = null,
    Object? queryFilter = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? minDistance = null,
    Object? maxDistance = null,
  }) {
    return _then(_$_NearbyEventsState(
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyEvents: null == nearbyEvents
          ? _value._nearbyEvents
          : nearbyEvents // ignore: cast_nullable_to_non_nullable
              as List<NearbyEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      isRefreshLoading: null == isRefreshLoading
          ? _value.isRefreshLoading
          : isRefreshLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      queryFilter: freezed == queryFilter
          ? _value.queryFilter
          : queryFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      minDistance: null == minDistance
          ? _value.minDistance
          : minDistance // ignore: cast_nullable_to_non_nullable
              as double,
      maxDistance: null == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NearbyEventsState implements _NearbyEventsState {
  const _$_NearbyEventsState(
      {required this.preSelectedEventIndex,
      required final List<NearbyEvent> nearbyEvents,
      required this.loadingState,
      required this.isRefreshLoading,
      required this.queryFilter,
      required this.latitude,
      required this.longitude,
      required this.minDistance,
      required this.maxDistance})
      : _nearbyEvents = nearbyEvents;

  factory _$_NearbyEventsState.fromJson(Map<String, dynamic> json) =>
      _$$_NearbyEventsStateFromJson(json);

  @override
  final int preSelectedEventIndex;
  final List<NearbyEvent> _nearbyEvents;
  @override
  List<NearbyEvent> get nearbyEvents {
    if (_nearbyEvents is EqualUnmodifiableListView) return _nearbyEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyEvents);
  }

  @override
  final LoadingState loadingState;
  @override
  final bool isRefreshLoading;
  @override
  final String? queryFilter;

  ///
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double minDistance;
  @override
  final double maxDistance;

  @override
  String toString() {
    return 'NearbyEventsState(preSelectedEventIndex: $preSelectedEventIndex, nearbyEvents: $nearbyEvents, loadingState: $loadingState, isRefreshLoading: $isRefreshLoading, queryFilter: $queryFilter, latitude: $latitude, longitude: $longitude, minDistance: $minDistance, maxDistance: $maxDistance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearbyEventsState &&
            (identical(other.preSelectedEventIndex, preSelectedEventIndex) ||
                other.preSelectedEventIndex == preSelectedEventIndex) &&
            const DeepCollectionEquality()
                .equals(other._nearbyEvents, _nearbyEvents) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState) &&
            (identical(other.isRefreshLoading, isRefreshLoading) ||
                other.isRefreshLoading == isRefreshLoading) &&
            (identical(other.queryFilter, queryFilter) ||
                other.queryFilter == queryFilter) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.minDistance, minDistance) ||
                other.minDistance == minDistance) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      preSelectedEventIndex,
      const DeepCollectionEquality().hash(_nearbyEvents),
      loadingState,
      isRefreshLoading,
      queryFilter,
      latitude,
      longitude,
      minDistance,
      maxDistance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearbyEventsStateCopyWith<_$_NearbyEventsState> get copyWith =>
      __$$_NearbyEventsStateCopyWithImpl<_$_NearbyEventsState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NearbyEventsStateToJson(
      this,
    );
  }
}

abstract class _NearbyEventsState implements NearbyEventsState {
  const factory _NearbyEventsState(
      {required final int preSelectedEventIndex,
      required final List<NearbyEvent> nearbyEvents,
      required final LoadingState loadingState,
      required final bool isRefreshLoading,
      required final String? queryFilter,
      required final double latitude,
      required final double longitude,
      required final double minDistance,
      required final double maxDistance}) = _$_NearbyEventsState;

  factory _NearbyEventsState.fromJson(Map<String, dynamic> json) =
      _$_NearbyEventsState.fromJson;

  @override
  int get preSelectedEventIndex;
  @override
  List<NearbyEvent> get nearbyEvents;
  @override
  LoadingState get loadingState;
  @override
  bool get isRefreshLoading;
  @override
  String? get queryFilter;
  @override

  ///
  double get latitude;
  @override
  double get longitude;
  @override
  double get minDistance;
  @override
  double get maxDistance;
  @override
  @JsonKey(ignore: true)
  _$$_NearbyEventsStateCopyWith<_$_NearbyEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}
