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
  ArtRouteModel? get package => throw _privateConstructorUsedError;
  List<ArtRouteAbstractModel> get packages =>
      throw _privateConstructorUsedError;
  List<ArtRouteAbstractModel> get packagesSpotlight =>
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
      ArtRouteModel? package,
      List<ArtRouteAbstractModel> packages,
      List<ArtRouteAbstractModel> packagesSpotlight,
      LoadingState loadingState,
      LoadingState loadingMoreState});

  $ArtRouteModelCopyWith<$Res>? get package;
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
              as ArtRouteModel?,
      packages: null == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
      packagesSpotlight: null == packagesSpotlight
          ? _value.packagesSpotlight
          : packagesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
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
  $ArtRouteModelCopyWith<$Res>? get package {
    if (_value.package == null) {
      return null;
    }

    return $ArtRouteModelCopyWith<$Res>(_value.package!, (value) {
      return _then(_value.copyWith(package: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PackagesStateImplCopyWith<$Res>
    implements $PackagesStateCopyWith<$Res> {
  factory _$$PackagesStateImplCopyWith(
          _$PackagesStateImpl value, $Res Function(_$PackagesStateImpl) then) =
      __$$PackagesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingState packageLoadingState,
      ArtRouteModel? package,
      List<ArtRouteAbstractModel> packages,
      List<ArtRouteAbstractModel> packagesSpotlight,
      LoadingState loadingState,
      LoadingState loadingMoreState});

  @override
  $ArtRouteModelCopyWith<$Res>? get package;
}

/// @nodoc
class __$$PackagesStateImplCopyWithImpl<$Res>
    extends _$PackagesStateCopyWithImpl<$Res, _$PackagesStateImpl>
    implements _$$PackagesStateImplCopyWith<$Res> {
  __$$PackagesStateImplCopyWithImpl(
      _$PackagesStateImpl _value, $Res Function(_$PackagesStateImpl) _then)
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
    return _then(_$PackagesStateImpl(
      packageLoadingState: null == packageLoadingState
          ? _value.packageLoadingState
          : packageLoadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as ArtRouteModel?,
      packages: null == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
      packagesSpotlight: null == packagesSpotlight
          ? _value._packagesSpotlight
          : packagesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
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
class _$PackagesStateImpl implements _PackagesState {
  const _$PackagesStateImpl(
      {required this.packageLoadingState,
      required this.package,
      required final List<ArtRouteAbstractModel> packages,
      required final List<ArtRouteAbstractModel> packagesSpotlight,
      required this.loadingState,
      required this.loadingMoreState})
      : _packages = packages,
        _packagesSpotlight = packagesSpotlight;

  factory _$PackagesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackagesStateImplFromJson(json);

  @override
  final LoadingState packageLoadingState;
  @override
  final ArtRouteModel? package;
  final List<ArtRouteAbstractModel> _packages;
  @override
  List<ArtRouteAbstractModel> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  final List<ArtRouteAbstractModel> _packagesSpotlight;
  @override
  List<ArtRouteAbstractModel> get packagesSpotlight {
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
            other is _$PackagesStateImpl &&
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
  _$$PackagesStateImplCopyWith<_$PackagesStateImpl> get copyWith =>
      __$$PackagesStateImplCopyWithImpl<_$PackagesStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackagesStateImplToJson(
      this,
    );
  }
}

abstract class _PackagesState implements PackagesState {
  const factory _PackagesState(
      {required final LoadingState packageLoadingState,
      required final ArtRouteModel? package,
      required final List<ArtRouteAbstractModel> packages,
      required final List<ArtRouteAbstractModel> packagesSpotlight,
      required final LoadingState loadingState,
      required final LoadingState loadingMoreState}) = _$PackagesStateImpl;

  factory _PackagesState.fromJson(Map<String, dynamic> json) =
      _$PackagesStateImpl.fromJson;

  @override
  LoadingState get packageLoadingState;
  @override
  ArtRouteModel? get package;
  @override
  List<ArtRouteAbstractModel> get packages;
  @override
  List<ArtRouteAbstractModel> get packagesSpotlight;
  @override
  LoadingState get loadingState;
  @override
  LoadingState get loadingMoreState;
  @override
  @JsonKey(ignore: true)
  _$$PackagesStateImplCopyWith<_$PackagesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
