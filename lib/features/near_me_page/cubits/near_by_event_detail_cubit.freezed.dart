// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'near_by_event_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NearbyEventDetailState _$NearbyEventDetailStateFromJson(
    Map<String, dynamic> json) {
  return _NearbyEventDetailState.fromJson(json);
}

/// @nodoc
mixin _$NearbyEventDetailState {
  bool get isFavourite => throw _privateConstructorUsedError;
  int get preSelectedEventIndex => throw _privateConstructorUsedError;
  EventComplete? get nearbyEvent => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbyEventDetailStateCopyWith<NearbyEventDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyEventDetailStateCopyWith<$Res> {
  factory $NearbyEventDetailStateCopyWith(NearbyEventDetailState value,
          $Res Function(NearbyEventDetailState) then) =
      _$NearbyEventDetailStateCopyWithImpl<$Res, NearbyEventDetailState>;
  @useResult
  $Res call(
      {bool isFavourite,
      int preSelectedEventIndex,
      EventComplete? nearbyEvent,
      LoadingState loadingState});

  $EventCompleteCopyWith<$Res>? get nearbyEvent;
}

/// @nodoc
class _$NearbyEventDetailStateCopyWithImpl<$Res,
        $Val extends NearbyEventDetailState>
    implements $NearbyEventDetailStateCopyWith<$Res> {
  _$NearbyEventDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavourite = null,
    Object? preSelectedEventIndex = null,
    Object? nearbyEvent = freezed,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyEvent: freezed == nearbyEvent
          ? _value.nearbyEvent
          : nearbyEvent // ignore: cast_nullable_to_non_nullable
              as EventComplete?,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventCompleteCopyWith<$Res>? get nearbyEvent {
    if (_value.nearbyEvent == null) {
      return null;
    }

    return $EventCompleteCopyWith<$Res>(_value.nearbyEvent!, (value) {
      return _then(_value.copyWith(nearbyEvent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NearbyEventDetailStateCopyWith<$Res>
    implements $NearbyEventDetailStateCopyWith<$Res> {
  factory _$$_NearbyEventDetailStateCopyWith(_$_NearbyEventDetailState value,
          $Res Function(_$_NearbyEventDetailState) then) =
      __$$_NearbyEventDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isFavourite,
      int preSelectedEventIndex,
      EventComplete? nearbyEvent,
      LoadingState loadingState});

  @override
  $EventCompleteCopyWith<$Res>? get nearbyEvent;
}

/// @nodoc
class __$$_NearbyEventDetailStateCopyWithImpl<$Res>
    extends _$NearbyEventDetailStateCopyWithImpl<$Res,
        _$_NearbyEventDetailState>
    implements _$$_NearbyEventDetailStateCopyWith<$Res> {
  __$$_NearbyEventDetailStateCopyWithImpl(_$_NearbyEventDetailState _value,
      $Res Function(_$_NearbyEventDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavourite = null,
    Object? preSelectedEventIndex = null,
    Object? nearbyEvent = freezed,
    Object? loadingState = null,
  }) {
    return _then(_$_NearbyEventDetailState(
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyEvent: freezed == nearbyEvent
          ? _value.nearbyEvent
          : nearbyEvent // ignore: cast_nullable_to_non_nullable
              as EventComplete?,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NearbyEventDetailState implements _NearbyEventDetailState {
  const _$_NearbyEventDetailState(
      {required this.isFavourite,
      required this.preSelectedEventIndex,
      required this.nearbyEvent,
      required this.loadingState});

  factory _$_NearbyEventDetailState.fromJson(Map<String, dynamic> json) =>
      _$$_NearbyEventDetailStateFromJson(json);

  @override
  final bool isFavourite;
  @override
  final int preSelectedEventIndex;
  @override
  final EventComplete? nearbyEvent;
  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'NearbyEventDetailState(isFavourite: $isFavourite, preSelectedEventIndex: $preSelectedEventIndex, nearbyEvent: $nearbyEvent, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearbyEventDetailState &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            (identical(other.preSelectedEventIndex, preSelectedEventIndex) ||
                other.preSelectedEventIndex == preSelectedEventIndex) &&
            (identical(other.nearbyEvent, nearbyEvent) ||
                other.nearbyEvent == nearbyEvent) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isFavourite,
      preSelectedEventIndex, nearbyEvent, loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearbyEventDetailStateCopyWith<_$_NearbyEventDetailState> get copyWith =>
      __$$_NearbyEventDetailStateCopyWithImpl<_$_NearbyEventDetailState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NearbyEventDetailStateToJson(
      this,
    );
  }
}

abstract class _NearbyEventDetailState implements NearbyEventDetailState {
  const factory _NearbyEventDetailState(
      {required final bool isFavourite,
      required final int preSelectedEventIndex,
      required final EventComplete? nearbyEvent,
      required final LoadingState loadingState}) = _$_NearbyEventDetailState;

  factory _NearbyEventDetailState.fromJson(Map<String, dynamic> json) =
      _$_NearbyEventDetailState.fromJson;

  @override
  bool get isFavourite;
  @override
  int get preSelectedEventIndex;
  @override
  EventComplete? get nearbyEvent;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_NearbyEventDetailStateCopyWith<_$_NearbyEventDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
