// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PackagesState _$PackagesStateFromJson(Map<String, dynamic> json) {
  return _PackagesState.fromJson(json);
}

/// @nodoc
mixin _$PackagesState {
  LoadingState get packageLoadingState => throw _privateConstructorUsedError;
  Package? get package => throw _privateConstructorUsedError;
  List<PackageAbstract> get packages => throw _privateConstructorUsedError;
  List<PackageAbstract> get packagesSpotlight =>
      throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;
  LoadingState get loadingMoreState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackagesStateCopyWith<PackagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackagesStateCopyWith<$Res> {
  factory $PackagesStateCopyWith(
          PackagesState value, $Res Function(PackagesState) then) =
      _$PackagesStateCopyWithImpl<$Res, PackagesState>;
  @useResult
  $Res call(
      {LoadingState packageLoadingState,
      Package? package,
      List<PackageAbstract> packages,
      List<PackageAbstract> packagesSpotlight,
      LoadingState loadingState,
      LoadingState loadingMoreState});

  $PackageCopyWith<$Res>? get package;
}

/// @nodoc
class _$PackagesStateCopyWithImpl<$Res, $Val extends PackagesState>
    implements $PackagesStateCopyWith<$Res> {
  _$PackagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageLoadingState = null,
    Object? package = freezed,
    Object? packages = null,
    Object? packagesSpotlight = null,
    Object? loadingState = null,
    Object? loadingMoreState = null,
  }) {
    return _then(_value.copyWith(
      packageLoadingState: null == packageLoadingState
          ? _value.packageLoadingState
          : packageLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package?,
      packages: null == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
      packagesSpotlight: null == packagesSpotlight
          ? _value.packagesSpotlight
          : packagesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      loadingMoreState: null == loadingMoreState
          ? _value.loadingMoreState
          : loadingMoreState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get package {
    if (_value.package == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.package!, (value) {
      return _then(_value.copyWith(package: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PackagesStateCopyWith<$Res>
    implements $PackagesStateCopyWith<$Res> {
  factory _$$_PackagesStateCopyWith(
          _$_PackagesState value, $Res Function(_$_PackagesState) then) =
      __$$_PackagesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingState packageLoadingState,
      Package? package,
      List<PackageAbstract> packages,
      List<PackageAbstract> packagesSpotlight,
      LoadingState loadingState,
      LoadingState loadingMoreState});

  @override
  $PackageCopyWith<$Res>? get package;
}

/// @nodoc
class __$$_PackagesStateCopyWithImpl<$Res>
    extends _$PackagesStateCopyWithImpl<$Res, _$_PackagesState>
    implements _$$_PackagesStateCopyWith<$Res> {
  __$$_PackagesStateCopyWithImpl(
      _$_PackagesState _value, $Res Function(_$_PackagesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageLoadingState = null,
    Object? package = freezed,
    Object? packages = null,
    Object? packagesSpotlight = null,
    Object? loadingState = null,
    Object? loadingMoreState = null,
  }) {
    return _then(_$_PackagesState(
      packageLoadingState: null == packageLoadingState
          ? _value.packageLoadingState
          : packageLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package?,
      packages: null == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
      packagesSpotlight: null == packagesSpotlight
          ? _value._packagesSpotlight
          : packagesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      loadingMoreState: null == loadingMoreState
          ? _value.loadingMoreState
          : loadingMoreState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PackagesState implements _PackagesState {
  const _$_PackagesState(
      {required this.packageLoadingState,
      required this.package,
      required final List<PackageAbstract> packages,
      required final List<PackageAbstract> packagesSpotlight,
      required this.loadingState,
      required this.loadingMoreState})
      : _packages = packages,
        _packagesSpotlight = packagesSpotlight;

  factory _$_PackagesState.fromJson(Map<String, dynamic> json) =>
      _$$_PackagesStateFromJson(json);

  @override
  final LoadingState packageLoadingState;
  @override
  final Package? package;
  final List<PackageAbstract> _packages;
  @override
  List<PackageAbstract> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  final List<PackageAbstract> _packagesSpotlight;
  @override
  List<PackageAbstract> get packagesSpotlight {
    if (_packagesSpotlight is EqualUnmodifiableListView)
      return _packagesSpotlight;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packagesSpotlight);
  }

  @override
  final LoadingState loadingState;
  @override
  final LoadingState loadingMoreState;

  @override
  String toString() {
    return 'PackagesState(packageLoadingState: $packageLoadingState, package: $package, packages: $packages, packagesSpotlight: $packagesSpotlight, loadingState: $loadingState, loadingMoreState: $loadingMoreState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackagesState &&
            (identical(other.packageLoadingState, packageLoadingState) ||
                other.packageLoadingState == packageLoadingState) &&
            (identical(other.package, package) || other.package == package) &&
            const DeepCollectionEquality().equals(other._packages, _packages) &&
            const DeepCollectionEquality()
                .equals(other._packagesSpotlight, _packagesSpotlight) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState) &&
            (identical(other.loadingMoreState, loadingMoreState) ||
                other.loadingMoreState == loadingMoreState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      packageLoadingState,
      package,
      const DeepCollectionEquality().hash(_packages),
      const DeepCollectionEquality().hash(_packagesSpotlight),
      loadingState,
      loadingMoreState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackagesStateCopyWith<_$_PackagesState> get copyWith =>
      __$$_PackagesStateCopyWithImpl<_$_PackagesState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackagesStateToJson(
      this,
    );
  }
}

abstract class _PackagesState implements PackagesState {
  const factory _PackagesState(
      {required final LoadingState packageLoadingState,
      required final Package? package,
      required final List<PackageAbstract> packages,
      required final List<PackageAbstract> packagesSpotlight,
      required final LoadingState loadingState,
      required final LoadingState loadingMoreState}) = _$_PackagesState;

  factory _PackagesState.fromJson(Map<String, dynamic> json) =
      _$_PackagesState.fromJson;

  @override
  LoadingState get packageLoadingState;
  @override
  Package? get package;
  @override
  List<PackageAbstract> get packages;
  @override
  List<PackageAbstract> get packagesSpotlight;
  @override
  LoadingState get loadingState;
  @override
  LoadingState get loadingMoreState;
  @override
  @JsonKey(ignore: true)
  _$$_PackagesStateCopyWith<_$_PackagesState> get copyWith =>
      throw _privateConstructorUsedError;
}
