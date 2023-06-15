// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'greeting_header_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GreetingHeaderEvent {
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
    required TResult Function(_GreetingHeaderEventLoad value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GreetingHeaderEventLoad value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GreetingHeaderEventLoad value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GreetingHeaderEventCopyWith<$Res> {
  factory $GreetingHeaderEventCopyWith(
          GreetingHeaderEvent value, $Res Function(GreetingHeaderEvent) then) =
      _$GreetingHeaderEventCopyWithImpl<$Res, GreetingHeaderEvent>;
}

/// @nodoc
class _$GreetingHeaderEventCopyWithImpl<$Res, $Val extends GreetingHeaderEvent>
    implements $GreetingHeaderEventCopyWith<$Res> {
  _$GreetingHeaderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_GreetingHeaderEventLoadCopyWith<$Res> {
  factory _$$_GreetingHeaderEventLoadCopyWith(_$_GreetingHeaderEventLoad value,
          $Res Function(_$_GreetingHeaderEventLoad) then) =
      __$$_GreetingHeaderEventLoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GreetingHeaderEventLoadCopyWithImpl<$Res>
    extends _$GreetingHeaderEventCopyWithImpl<$Res, _$_GreetingHeaderEventLoad>
    implements _$$_GreetingHeaderEventLoadCopyWith<$Res> {
  __$$_GreetingHeaderEventLoadCopyWithImpl(_$_GreetingHeaderEventLoad _value,
      $Res Function(_$_GreetingHeaderEventLoad) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_GreetingHeaderEventLoad
    with DiagnosticableTreeMixin
    implements _GreetingHeaderEventLoad {
  const _$_GreetingHeaderEventLoad();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GreetingHeaderEvent.load()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'GreetingHeaderEvent.load'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GreetingHeaderEventLoad);
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
    required TResult Function(_GreetingHeaderEventLoad value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GreetingHeaderEventLoad value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GreetingHeaderEventLoad value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _GreetingHeaderEventLoad implements GreetingHeaderEvent {
  const factory _GreetingHeaderEventLoad() = _$_GreetingHeaderEventLoad;
}

GreetingHeaderState _$GreetingHeaderStateFromJson(Map<String, dynamic> json) {
  return _GreetingHeaderState.fromJson(json);
}

/// @nodoc
mixin _$GreetingHeaderState {
  bool get isCached => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int get notificationCount => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GreetingHeaderStateCopyWith<GreetingHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GreetingHeaderStateCopyWith<$Res> {
  factory $GreetingHeaderStateCopyWith(
          GreetingHeaderState value, $Res Function(GreetingHeaderState) then) =
      _$GreetingHeaderStateCopyWithImpl<$Res, GreetingHeaderState>;
  @useResult
  $Res call({bool isCached, bool isLoading, int notificationCount, User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$GreetingHeaderStateCopyWithImpl<$Res, $Val extends GreetingHeaderState>
    implements $GreetingHeaderStateCopyWith<$Res> {
  _$GreetingHeaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCached = null,
    Object? isLoading = null,
    Object? notificationCount = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationCount: null == notificationCount
          ? _value.notificationCount
          : notificationCount // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GreetingHeaderStateCopyWith<$Res>
    implements $GreetingHeaderStateCopyWith<$Res> {
  factory _$$_GreetingHeaderStateCopyWith(_$_GreetingHeaderState value,
          $Res Function(_$_GreetingHeaderState) then) =
      __$$_GreetingHeaderStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCached, bool isLoading, int notificationCount, User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_GreetingHeaderStateCopyWithImpl<$Res>
    extends _$GreetingHeaderStateCopyWithImpl<$Res, _$_GreetingHeaderState>
    implements _$$_GreetingHeaderStateCopyWith<$Res> {
  __$$_GreetingHeaderStateCopyWithImpl(_$_GreetingHeaderState _value,
      $Res Function(_$_GreetingHeaderState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCached = null,
    Object? isLoading = null,
    Object? notificationCount = null,
    Object? user = freezed,
  }) {
    return _then(_$_GreetingHeaderState(
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationCount: null == notificationCount
          ? _value.notificationCount
          : notificationCount // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GreetingHeaderState extends _GreetingHeaderState
    with DiagnosticableTreeMixin {
  const _$_GreetingHeaderState(
      {this.isCached = false,
      this.isLoading = true,
      this.notificationCount = 0,
      this.user = null})
      : super._();

  factory _$_GreetingHeaderState.fromJson(Map<String, dynamic> json) =>
      _$$_GreetingHeaderStateFromJson(json);

  @override
  @JsonKey()
  final bool isCached;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int notificationCount;
  @override
  @JsonKey()
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GreetingHeaderState(isCached: $isCached, isLoading: $isLoading, notificationCount: $notificationCount, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GreetingHeaderState'))
      ..add(DiagnosticsProperty('isCached', isCached))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('notificationCount', notificationCount))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GreetingHeaderState &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.notificationCount, notificationCount) ||
                other.notificationCount == notificationCount) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isCached, isLoading, notificationCount, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GreetingHeaderStateCopyWith<_$_GreetingHeaderState> get copyWith =>
      __$$_GreetingHeaderStateCopyWithImpl<_$_GreetingHeaderState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GreetingHeaderStateToJson(
      this,
    );
  }
}

abstract class _GreetingHeaderState extends GreetingHeaderState {
  const factory _GreetingHeaderState(
      {final bool isCached,
      final bool isLoading,
      final int notificationCount,
      final User? user}) = _$_GreetingHeaderState;
  const _GreetingHeaderState._() : super._();

  factory _GreetingHeaderState.fromJson(Map<String, dynamic> json) =
      _$_GreetingHeaderState.fromJson;

  @override
  bool get isCached;
  @override
  bool get isLoading;
  @override
  int get notificationCount;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$_GreetingHeaderStateCopyWith<_$_GreetingHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}
