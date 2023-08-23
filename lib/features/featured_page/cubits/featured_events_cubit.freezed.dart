// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeatureEventsState _$FeatureEventsStateFromJson(Map<String, dynamic> json) {
  return _FeatureEventsState.fromJson(json);
}

/// @nodoc
mixin _$FeatureEventsState {
  FeaturedEvent? get featuredEventSummary => throw _privateConstructorUsedError;
  FeaturedEvent? get featuredEvent => throw _privateConstructorUsedError;
  List<FeaturedEvent> get featuredEvents => throw _privateConstructorUsedError;
  List<FeaturedEvent> get featuredEventsSpotlight =>
      throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeatureEventsStateCopyWith<FeatureEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureEventsStateCopyWith<$Res> {
  factory $FeatureEventsStateCopyWith(
          FeatureEventsState value, $Res Function(FeatureEventsState) then) =
      _$FeatureEventsStateCopyWithImpl<$Res, FeatureEventsState>;
  @useResult
  $Res call(
      {FeaturedEvent? featuredEventSummary,
      FeaturedEvent? featuredEvent,
      List<FeaturedEvent> featuredEvents,
      List<FeaturedEvent> featuredEventsSpotlight,
      LoadingState loadingState});

  $FeaturedEventCopyWith<$Res>? get featuredEventSummary;
  $FeaturedEventCopyWith<$Res>? get featuredEvent;
}

/// @nodoc
class _$FeatureEventsStateCopyWithImpl<$Res, $Val extends FeatureEventsState>
    implements $FeatureEventsStateCopyWith<$Res> {
  _$FeatureEventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featuredEventSummary = freezed,
    Object? featuredEvent = freezed,
    Object? featuredEvents = null,
    Object? featuredEventsSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      featuredEventSummary: freezed == featuredEventSummary
          ? _value.featuredEventSummary
          : featuredEventSummary // ignore: cast_nullable_to_non_nullable
              as FeaturedEvent?,
      featuredEvent: freezed == featuredEvent
          ? _value.featuredEvent
          : featuredEvent // ignore: cast_nullable_to_non_nullable
              as FeaturedEvent?,
      featuredEvents: null == featuredEvents
          ? _value.featuredEvents
          : featuredEvents // ignore: cast_nullable_to_non_nullable
              as List<FeaturedEvent>,
      featuredEventsSpotlight: null == featuredEventsSpotlight
          ? _value.featuredEventsSpotlight
          : featuredEventsSpotlight // ignore: cast_nullable_to_non_nullable
              as List<FeaturedEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FeaturedEventCopyWith<$Res>? get featuredEventSummary {
    if (_value.featuredEventSummary == null) {
      return null;
    }

    return $FeaturedEventCopyWith<$Res>(_value.featuredEventSummary!, (value) {
      return _then(_value.copyWith(featuredEventSummary: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FeaturedEventCopyWith<$Res>? get featuredEvent {
    if (_value.featuredEvent == null) {
      return null;
    }

    return $FeaturedEventCopyWith<$Res>(_value.featuredEvent!, (value) {
      return _then(_value.copyWith(featuredEvent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FeatureEventsStateCopyWith<$Res>
    implements $FeatureEventsStateCopyWith<$Res> {
  factory _$$_FeatureEventsStateCopyWith(_$_FeatureEventsState value,
          $Res Function(_$_FeatureEventsState) then) =
      __$$_FeatureEventsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FeaturedEvent? featuredEventSummary,
      FeaturedEvent? featuredEvent,
      List<FeaturedEvent> featuredEvents,
      List<FeaturedEvent> featuredEventsSpotlight,
      LoadingState loadingState});

  @override
  $FeaturedEventCopyWith<$Res>? get featuredEventSummary;
  @override
  $FeaturedEventCopyWith<$Res>? get featuredEvent;
}

/// @nodoc
class __$$_FeatureEventsStateCopyWithImpl<$Res>
    extends _$FeatureEventsStateCopyWithImpl<$Res, _$_FeatureEventsState>
    implements _$$_FeatureEventsStateCopyWith<$Res> {
  __$$_FeatureEventsStateCopyWithImpl(
      _$_FeatureEventsState _value, $Res Function(_$_FeatureEventsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featuredEventSummary = freezed,
    Object? featuredEvent = freezed,
    Object? featuredEvents = null,
    Object? featuredEventsSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_$_FeatureEventsState(
      featuredEventSummary: freezed == featuredEventSummary
          ? _value.featuredEventSummary
          : featuredEventSummary // ignore: cast_nullable_to_non_nullable
              as FeaturedEvent?,
      featuredEvent: freezed == featuredEvent
          ? _value.featuredEvent
          : featuredEvent // ignore: cast_nullable_to_non_nullable
              as FeaturedEvent?,
      featuredEvents: null == featuredEvents
          ? _value._featuredEvents
          : featuredEvents // ignore: cast_nullable_to_non_nullable
              as List<FeaturedEvent>,
      featuredEventsSpotlight: null == featuredEventsSpotlight
          ? _value._featuredEventsSpotlight
          : featuredEventsSpotlight // ignore: cast_nullable_to_non_nullable
              as List<FeaturedEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeatureEventsState implements _FeatureEventsState {
  const _$_FeatureEventsState(
      {required this.featuredEventSummary,
      required this.featuredEvent,
      required final List<FeaturedEvent> featuredEvents,
      required final List<FeaturedEvent> featuredEventsSpotlight,
      required this.loadingState})
      : _featuredEvents = featuredEvents,
        _featuredEventsSpotlight = featuredEventsSpotlight;

  factory _$_FeatureEventsState.fromJson(Map<String, dynamic> json) =>
      _$$_FeatureEventsStateFromJson(json);

  @override
  final FeaturedEvent? featuredEventSummary;
  @override
  final FeaturedEvent? featuredEvent;
  final List<FeaturedEvent> _featuredEvents;
  @override
  List<FeaturedEvent> get featuredEvents {
    if (_featuredEvents is EqualUnmodifiableListView) return _featuredEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredEvents);
  }

  final List<FeaturedEvent> _featuredEventsSpotlight;
  @override
  List<FeaturedEvent> get featuredEventsSpotlight {
    if (_featuredEventsSpotlight is EqualUnmodifiableListView)
      return _featuredEventsSpotlight;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredEventsSpotlight);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'FeatureEventsState(featuredEventSummary: $featuredEventSummary, featuredEvent: $featuredEvent, featuredEvents: $featuredEvents, featuredEventsSpotlight: $featuredEventsSpotlight, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeatureEventsState &&
            (identical(other.featuredEventSummary, featuredEventSummary) ||
                other.featuredEventSummary == featuredEventSummary) &&
            (identical(other.featuredEvent, featuredEvent) ||
                other.featuredEvent == featuredEvent) &&
            const DeepCollectionEquality()
                .equals(other._featuredEvents, _featuredEvents) &&
            const DeepCollectionEquality().equals(
                other._featuredEventsSpotlight, _featuredEventsSpotlight) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      featuredEventSummary,
      featuredEvent,
      const DeepCollectionEquality().hash(_featuredEvents),
      const DeepCollectionEquality().hash(_featuredEventsSpotlight),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeatureEventsStateCopyWith<_$_FeatureEventsState> get copyWith =>
      __$$_FeatureEventsStateCopyWithImpl<_$_FeatureEventsState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeatureEventsStateToJson(
      this,
    );
  }
}

abstract class _FeatureEventsState implements FeatureEventsState {
  const factory _FeatureEventsState(
      {required final FeaturedEvent? featuredEventSummary,
      required final FeaturedEvent? featuredEvent,
      required final List<FeaturedEvent> featuredEvents,
      required final List<FeaturedEvent> featuredEventsSpotlight,
      required final LoadingState loadingState}) = _$_FeatureEventsState;

  factory _FeatureEventsState.fromJson(Map<String, dynamic> json) =
      _$_FeatureEventsState.fromJson;

  @override
  FeaturedEvent? get featuredEventSummary;
  @override
  FeaturedEvent? get featuredEvent;
  @override
  List<FeaturedEvent> get featuredEvents;
  @override
  List<FeaturedEvent> get featuredEventsSpotlight;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_FeatureEventsStateCopyWith<_$_FeatureEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}
