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
      bool isRefreshLoading});
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
      bool isRefreshLoading});
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
      required this.isRefreshLoading})
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
  String toString() {
    return 'NearbyEventsState(preSelectedEventIndex: $preSelectedEventIndex, nearbyEvents: $nearbyEvents, loadingState: $loadingState, isRefreshLoading: $isRefreshLoading)';
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
                other.isRefreshLoading == isRefreshLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      preSelectedEventIndex,
      const DeepCollectionEquality().hash(_nearbyEvents),
      loadingState,
      isRefreshLoading);

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
      required final bool isRefreshLoading}) = _$_NearbyEventsState;

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
  @JsonKey(ignore: true)
  _$$_NearbyEventsStateCopyWith<_$_NearbyEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}
