// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'near_by_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NearbyState _$NearbyStateFromJson(Map<String, dynamic> json) {
  return _NearbyState.fromJson(json);
}

/// @nodoc
mixin _$NearbyState {
  int get preSelectedIndex => throw _privateConstructorUsedError;
  List<ArtAbstractModel> get nearbyArts => throw _privateConstructorUsedError;
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
  $NearbyStateCopyWith<NearbyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyStateCopyWith<$Res> {
  factory $NearbyStateCopyWith(
          NearbyState value, $Res Function(NearbyState) then) =
      _$NearbyStateCopyWithImpl<$Res, NearbyState>;
  @useResult
  $Res call(
      {int preSelectedIndex,
      List<ArtAbstractModel> nearbyArts,
      LoadingState loadingState,
      bool isRefreshLoading,
      String? queryFilter,
      double latitude,
      double longitude,
      double minDistance,
      double maxDistance});
}

/// @nodoc
class _$NearbyStateCopyWithImpl<$Res, $Val extends NearbyState>
    implements $NearbyStateCopyWith<$Res> {
  _$NearbyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedIndex = null,
    Object? nearbyArts = null,
    Object? loadingState = null,
    Object? isRefreshLoading = null,
    Object? queryFilter = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? minDistance = null,
    Object? maxDistance = null,
  }) {
    return _then(_value.copyWith(
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyArts: null == nearbyArts
          ? _value.nearbyArts
          : nearbyArts // ignore: cast_nullable_to_non_nullable
              as List<ArtAbstractModel>,
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
abstract class _$$NearbyStateImplCopyWith<$Res>
    implements $NearbyStateCopyWith<$Res> {
  factory _$$NearbyStateImplCopyWith(
          _$NearbyStateImpl value, $Res Function(_$NearbyStateImpl) then) =
      __$$NearbyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int preSelectedIndex,
      List<ArtAbstractModel> nearbyArts,
      LoadingState loadingState,
      bool isRefreshLoading,
      String? queryFilter,
      double latitude,
      double longitude,
      double minDistance,
      double maxDistance});
}

/// @nodoc
class __$$NearbyStateImplCopyWithImpl<$Res>
    extends _$NearbyStateCopyWithImpl<$Res, _$NearbyStateImpl>
    implements _$$NearbyStateImplCopyWith<$Res> {
  __$$NearbyStateImplCopyWithImpl(
      _$NearbyStateImpl _value, $Res Function(_$NearbyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedIndex = null,
    Object? nearbyArts = null,
    Object? loadingState = null,
    Object? isRefreshLoading = null,
    Object? queryFilter = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? minDistance = null,
    Object? maxDistance = null,
  }) {
    return _then(_$NearbyStateImpl(
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyArts: null == nearbyArts
          ? _value._nearbyArts
          : nearbyArts // ignore: cast_nullable_to_non_nullable
              as List<ArtAbstractModel>,
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
class _$NearbyStateImpl extends _NearbyState {
  const _$NearbyStateImpl(
      {required this.preSelectedIndex,
      required final List<ArtAbstractModel> nearbyArts,
      required this.loadingState,
      required this.isRefreshLoading,
      required this.queryFilter,
      required this.latitude,
      required this.longitude,
      required this.minDistance,
      required this.maxDistance})
      : _nearbyArts = nearbyArts,
        super._();

  factory _$NearbyStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearbyStateImplFromJson(json);

  @override
  final int preSelectedIndex;
  final List<ArtAbstractModel> _nearbyArts;
  @override
  List<ArtAbstractModel> get nearbyArts {
    if (_nearbyArts is EqualUnmodifiableListView) return _nearbyArts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyArts);
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
    return 'NearbyState(preSelectedIndex: $preSelectedIndex, nearbyArts: $nearbyArts, loadingState: $loadingState, isRefreshLoading: $isRefreshLoading, queryFilter: $queryFilter, latitude: $latitude, longitude: $longitude, minDistance: $minDistance, maxDistance: $maxDistance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyStateImpl &&
            (identical(other.preSelectedIndex, preSelectedIndex) ||
                other.preSelectedIndex == preSelectedIndex) &&
            const DeepCollectionEquality()
                .equals(other._nearbyArts, _nearbyArts) &&
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
      preSelectedIndex,
      const DeepCollectionEquality().hash(_nearbyArts),
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
  _$$NearbyStateImplCopyWith<_$NearbyStateImpl> get copyWith =>
      __$$NearbyStateImplCopyWithImpl<_$NearbyStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NearbyStateImplToJson(
      this,
    );
  }
}

abstract class _NearbyState extends NearbyState {
  const factory _NearbyState(
      {required final int preSelectedIndex,
      required final List<ArtAbstractModel> nearbyArts,
      required final LoadingState loadingState,
      required final bool isRefreshLoading,
      required final String? queryFilter,
      required final double latitude,
      required final double longitude,
      required final double minDistance,
      required final double maxDistance}) = _$NearbyStateImpl;
  const _NearbyState._() : super._();

  factory _NearbyState.fromJson(Map<String, dynamic> json) =
      _$NearbyStateImpl.fromJson;

  @override
  int get preSelectedIndex;
  @override
  List<ArtAbstractModel> get nearbyArts;
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
  _$$NearbyStateImplCopyWith<_$NearbyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
