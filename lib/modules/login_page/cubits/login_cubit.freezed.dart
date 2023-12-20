// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginState _$LoginStateFromJson(Map<String, dynamic> json) {
  return _LoginState.fromJson(json);
}

/// @nodoc
mixin _$LoginState {
  bool get isLoggedIn => throw _privateConstructorUsedError;
  LoadingState get googleLoginLoadingState =>
      throw _privateConstructorUsedError;
  LoadingState get appleLoginLoadingState => throw _privateConstructorUsedError;
  LoadingState get logoutLoadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isLoggedIn,
      LoadingState googleLoginLoadingState,
      LoadingState appleLoginLoadingState,
      LoadingState logoutLoadingState});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? googleLoginLoadingState = null,
    Object? appleLoginLoadingState = null,
    Object? logoutLoadingState = null,
  }) {
    return _then(_value.copyWith(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      googleLoginLoadingState: null == googleLoginLoadingState
          ? _value.googleLoginLoadingState
          : googleLoginLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      appleLoginLoadingState: null == appleLoginLoadingState
          ? _value.appleLoginLoadingState
          : appleLoginLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      logoutLoadingState: null == logoutLoadingState
          ? _value.logoutLoadingState
          : logoutLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoggedIn,
      LoadingState googleLoginLoadingState,
      LoadingState appleLoginLoadingState,
      LoadingState logoutLoadingState});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? googleLoginLoadingState = null,
    Object? appleLoginLoadingState = null,
    Object? logoutLoadingState = null,
  }) {
    return _then(_$LoginStateImpl(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      googleLoginLoadingState: null == googleLoginLoadingState
          ? _value.googleLoginLoadingState
          : googleLoginLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      appleLoginLoadingState: null == appleLoginLoadingState
          ? _value.appleLoginLoadingState
          : appleLoginLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      logoutLoadingState: null == logoutLoadingState
          ? _value.logoutLoadingState
          : logoutLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginStateImpl with DiagnosticableTreeMixin implements _LoginState {
  const _$LoginStateImpl(
      {required this.isLoggedIn,
      required this.googleLoginLoadingState,
      required this.appleLoginLoadingState,
      required this.logoutLoadingState});

  factory _$LoginStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginStateImplFromJson(json);

  @override
  final bool isLoggedIn;
  @override
  final LoadingState googleLoginLoadingState;
  @override
  final LoadingState appleLoginLoadingState;
  @override
  final LoadingState logoutLoadingState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginState(isLoggedIn: $isLoggedIn, googleLoginLoadingState: $googleLoginLoadingState, appleLoginLoadingState: $appleLoginLoadingState, logoutLoadingState: $logoutLoadingState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginState'))
      ..add(DiagnosticsProperty('isLoggedIn', isLoggedIn))
      ..add(DiagnosticsProperty(
          'googleLoginLoadingState', googleLoginLoadingState))
      ..add(
          DiagnosticsProperty('appleLoginLoadingState', appleLoginLoadingState))
      ..add(DiagnosticsProperty('logoutLoadingState', logoutLoadingState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(
                    other.googleLoginLoadingState, googleLoginLoadingState) ||
                other.googleLoginLoadingState == googleLoginLoadingState) &&
            (identical(other.appleLoginLoadingState, appleLoginLoadingState) ||
                other.appleLoginLoadingState == appleLoginLoadingState) &&
            (identical(other.logoutLoadingState, logoutLoadingState) ||
                other.logoutLoadingState == logoutLoadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoggedIn,
      googleLoginLoadingState, appleLoginLoadingState, logoutLoadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginStateImplToJson(
      this,
    );
  }
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {required final bool isLoggedIn,
      required final LoadingState googleLoginLoadingState,
      required final LoadingState appleLoginLoadingState,
      required final LoadingState logoutLoadingState}) = _$LoginStateImpl;

  factory _LoginState.fromJson(Map<String, dynamic> json) =
      _$LoginStateImpl.fromJson;

  @override
  bool get isLoggedIn;
  @override
  LoadingState get googleLoginLoadingState;
  @override
  LoadingState get appleLoginLoadingState;
  @override
  LoadingState get logoutLoadingState;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
