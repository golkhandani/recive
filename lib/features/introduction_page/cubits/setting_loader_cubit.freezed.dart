// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_loader_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingLoaderState _$SettingLoaderStateFromJson(Map<String, dynamic> json) {
  return _SettingLoaderState.fromJson(json);
}

/// @nodoc
mixin _$SettingLoaderState {
  bool get isLoggedIn => throw _privateConstructorUsedError;
  bool get isIntroViewed => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingLoaderStateCopyWith<SettingLoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingLoaderStateCopyWith<$Res> {
  factory $SettingLoaderStateCopyWith(
          SettingLoaderState value, $Res Function(SettingLoaderState) then) =
      _$SettingLoaderStateCopyWithImpl<$Res, SettingLoaderState>;
  @useResult
  $Res call({bool isLoggedIn, bool isIntroViewed, LoadingState loadingState});
}

/// @nodoc
class _$SettingLoaderStateCopyWithImpl<$Res, $Val extends SettingLoaderState>
    implements $SettingLoaderStateCopyWith<$Res> {
  _$SettingLoaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? isIntroViewed = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isIntroViewed: null == isIntroViewed
          ? _value.isIntroViewed
          : isIntroViewed // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingLoaderStateCopyWith<$Res>
    implements $SettingLoaderStateCopyWith<$Res> {
  factory _$$_SettingLoaderStateCopyWith(_$_SettingLoaderState value,
          $Res Function(_$_SettingLoaderState) then) =
      __$$_SettingLoaderStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoggedIn, bool isIntroViewed, LoadingState loadingState});
}

/// @nodoc
class __$$_SettingLoaderStateCopyWithImpl<$Res>
    extends _$SettingLoaderStateCopyWithImpl<$Res, _$_SettingLoaderState>
    implements _$$_SettingLoaderStateCopyWith<$Res> {
  __$$_SettingLoaderStateCopyWithImpl(
      _$_SettingLoaderState _value, $Res Function(_$_SettingLoaderState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? isIntroViewed = null,
    Object? loadingState = null,
  }) {
    return _then(_$_SettingLoaderState(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isIntroViewed: null == isIntroViewed
          ? _value.isIntroViewed
          : isIntroViewed // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SettingLoaderState
    with DiagnosticableTreeMixin
    implements _SettingLoaderState {
  const _$_SettingLoaderState(
      {required this.isLoggedIn,
      required this.isIntroViewed,
      required this.loadingState});

  factory _$_SettingLoaderState.fromJson(Map<String, dynamic> json) =>
      _$$_SettingLoaderStateFromJson(json);

  @override
  final bool isLoggedIn;
  @override
  final bool isIntroViewed;
  @override
  final LoadingState loadingState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SettingLoaderState(isLoggedIn: $isLoggedIn, isIntroViewed: $isIntroViewed, loadingState: $loadingState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SettingLoaderState'))
      ..add(DiagnosticsProperty('isLoggedIn', isLoggedIn))
      ..add(DiagnosticsProperty('isIntroViewed', isIntroViewed))
      ..add(DiagnosticsProperty('loadingState', loadingState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingLoaderState &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.isIntroViewed, isIntroViewed) ||
                other.isIntroViewed == isIntroViewed) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoggedIn, isIntroViewed, loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingLoaderStateCopyWith<_$_SettingLoaderState> get copyWith =>
      __$$_SettingLoaderStateCopyWithImpl<_$_SettingLoaderState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingLoaderStateToJson(
      this,
    );
  }
}

abstract class _SettingLoaderState implements SettingLoaderState {
  const factory _SettingLoaderState(
      {required final bool isLoggedIn,
      required final bool isIntroViewed,
      required final LoadingState loadingState}) = _$_SettingLoaderState;

  factory _SettingLoaderState.fromJson(Map<String, dynamic> json) =
      _$_SettingLoaderState.fromJson;

  @override
  bool get isLoggedIn;
  @override
  bool get isIntroViewed;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_SettingLoaderStateCopyWith<_$_SettingLoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}
