// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fasting_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FastingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FastingEventLoad value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FastingEventLoad value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FastingEventLoad value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingEventCopyWith<$Res> {
  factory $FastingEventCopyWith(
          FastingEvent value, $Res Function(FastingEvent) then) =
      _$FastingEventCopyWithImpl<$Res, FastingEvent>;
}

/// @nodoc
class _$FastingEventCopyWithImpl<$Res, $Val extends FastingEvent>
    implements $FastingEventCopyWith<$Res> {
  _$FastingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_FastingEventLoadCopyWith<$Res> {
  factory _$$_FastingEventLoadCopyWith(
          _$_FastingEventLoad value, $Res Function(_$_FastingEventLoad) then) =
      __$$_FastingEventLoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FastingEventLoadCopyWithImpl<$Res>
    extends _$FastingEventCopyWithImpl<$Res, _$_FastingEventLoad>
    implements _$$_FastingEventLoadCopyWith<$Res> {
  __$$_FastingEventLoadCopyWithImpl(
      _$_FastingEventLoad _value, $Res Function(_$_FastingEventLoad) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_FastingEventLoad implements _FastingEventLoad {
  const _$_FastingEventLoad();

  @override
  String toString() {
    return 'FastingEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FastingEventLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FastingEventLoad value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FastingEventLoad value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FastingEventLoad value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _FastingEventLoad implements FastingEvent {
  const factory _FastingEventLoad() = _$_FastingEventLoad;
}

FastingState _$FastingStateFromJson(Map<String, dynamic> json) {
  return _FastingState.fromJson(json);
}

/// @nodoc
mixin _$FastingState {
  DateTime? get $cachedAt => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<Fasting> get fastings => throw _privateConstructorUsedError;
  Fasting? get selectedFastings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FastingStateCopyWith<FastingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingStateCopyWith<$Res> {
  factory $FastingStateCopyWith(
          FastingState value, $Res Function(FastingState) then) =
      _$FastingStateCopyWithImpl<$Res, FastingState>;
  @useResult
  $Res call(
      {DateTime? $cachedAt,
      bool isLoading,
      List<Fasting> fastings,
      Fasting? selectedFastings});

  $FastingCopyWith<$Res>? get selectedFastings;
}

/// @nodoc
class _$FastingStateCopyWithImpl<$Res, $Val extends FastingState>
    implements $FastingStateCopyWith<$Res> {
  _$FastingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? $cachedAt = freezed,
    Object? isLoading = null,
    Object? fastings = null,
    Object? selectedFastings = freezed,
  }) {
    return _then(_value.copyWith(
      $cachedAt: freezed == $cachedAt
          ? _value.$cachedAt
          : $cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fastings: null == fastings
          ? _value.fastings
          : fastings // ignore: cast_nullable_to_non_nullable
              as List<Fasting>,
      selectedFastings: freezed == selectedFastings
          ? _value.selectedFastings
          : selectedFastings // ignore: cast_nullable_to_non_nullable
              as Fasting?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FastingCopyWith<$Res>? get selectedFastings {
    if (_value.selectedFastings == null) {
      return null;
    }

    return $FastingCopyWith<$Res>(_value.selectedFastings!, (value) {
      return _then(_value.copyWith(selectedFastings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FastingStateCopyWith<$Res>
    implements $FastingStateCopyWith<$Res> {
  factory _$$_FastingStateCopyWith(
          _$_FastingState value, $Res Function(_$_FastingState) then) =
      __$$_FastingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? $cachedAt,
      bool isLoading,
      List<Fasting> fastings,
      Fasting? selectedFastings});

  @override
  $FastingCopyWith<$Res>? get selectedFastings;
}

/// @nodoc
class __$$_FastingStateCopyWithImpl<$Res>
    extends _$FastingStateCopyWithImpl<$Res, _$_FastingState>
    implements _$$_FastingStateCopyWith<$Res> {
  __$$_FastingStateCopyWithImpl(
      _$_FastingState _value, $Res Function(_$_FastingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? $cachedAt = freezed,
    Object? isLoading = null,
    Object? fastings = null,
    Object? selectedFastings = freezed,
  }) {
    return _then(_$_FastingState(
      $cachedAt: freezed == $cachedAt
          ? _value.$cachedAt
          : $cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fastings: null == fastings
          ? _value._fastings
          : fastings // ignore: cast_nullable_to_non_nullable
              as List<Fasting>,
      selectedFastings: freezed == selectedFastings
          ? _value.selectedFastings
          : selectedFastings // ignore: cast_nullable_to_non_nullable
              as Fasting?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FastingState extends _FastingState {
  const _$_FastingState(
      {this.$cachedAt = null,
      this.isLoading = false,
      final List<Fasting> fastings = const [],
      this.selectedFastings = null})
      : _fastings = fastings,
        super._();

  factory _$_FastingState.fromJson(Map<String, dynamic> json) =>
      _$$_FastingStateFromJson(json);

  @override
  @JsonKey()
  final DateTime? $cachedAt;
  @override
  @JsonKey()
  final bool isLoading;
  final List<Fasting> _fastings;
  @override
  @JsonKey()
  List<Fasting> get fastings {
    if (_fastings is EqualUnmodifiableListView) return _fastings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fastings);
  }

  @override
  @JsonKey()
  final Fasting? selectedFastings;

  @override
  String toString() {
    return 'FastingState(\$cachedAt: ${$cachedAt}, isLoading: $isLoading, fastings: $fastings, selectedFastings: $selectedFastings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FastingState &&
            (identical(other.$cachedAt, $cachedAt) ||
                other.$cachedAt == $cachedAt) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._fastings, _fastings) &&
            (identical(other.selectedFastings, selectedFastings) ||
                other.selectedFastings == selectedFastings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, $cachedAt, isLoading,
      const DeepCollectionEquality().hash(_fastings), selectedFastings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FastingStateCopyWith<_$_FastingState> get copyWith =>
      __$$_FastingStateCopyWithImpl<_$_FastingState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FastingStateToJson(
      this,
    );
  }
}

abstract class _FastingState extends FastingState {
  const factory _FastingState(
      {final DateTime? $cachedAt,
      final bool isLoading,
      final List<Fasting> fastings,
      final Fasting? selectedFastings}) = _$_FastingState;
  const _FastingState._() : super._();

  factory _FastingState.fromJson(Map<String, dynamic> json) =
      _$_FastingState.fromJson;

  @override
  DateTime? get $cachedAt;
  @override
  bool get isLoading;
  @override
  List<Fasting> get fastings;
  @override
  Fasting? get selectedFastings;
  @override
  @JsonKey(ignore: true)
  _$$_FastingStateCopyWith<_$_FastingState> get copyWith =>
      throw _privateConstructorUsedError;
}
