// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtDetailState _$ArtDetailStateFromJson(Map<String, dynamic> json) {
  return _ArtDetailState.fromJson(json);
}

/// @nodoc
mixin _$ArtDetailState {
  bool get isBookmarked => throw _privateConstructorUsedError;
  int get preSelectedIndex => throw _privateConstructorUsedError;
  ArtModel? get nearbyItem => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtDetailStateCopyWith<ArtDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDetailStateCopyWith<$Res> {
  factory $ArtDetailStateCopyWith(
          ArtDetailState value, $Res Function(ArtDetailState) then) =
      _$ArtDetailStateCopyWithImpl<$Res, ArtDetailState>;
  @useResult
  $Res call(
      {bool isBookmarked,
      int preSelectedIndex,
      ArtModel? nearbyItem,
      LoadingState loadingState});

  $ArtModelCopyWith<$Res>? get nearbyItem;
}

/// @nodoc
class _$ArtDetailStateCopyWithImpl<$Res, $Val extends ArtDetailState>
    implements $ArtDetailStateCopyWith<$Res> {
  _$ArtDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBookmarked = null,
    Object? preSelectedIndex = null,
    Object? nearbyItem = freezed,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyItem: freezed == nearbyItem
          ? _value.nearbyItem
          : nearbyItem // ignore: cast_nullable_to_non_nullable
              as ArtModel?,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ArtModelCopyWith<$Res>? get nearbyItem {
    if (_value.nearbyItem == null) {
      return null;
    }

    return $ArtModelCopyWith<$Res>(_value.nearbyItem!, (value) {
      return _then(_value.copyWith(nearbyItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ArtDetailStateCopyWith<$Res>
    implements $ArtDetailStateCopyWith<$Res> {
  factory _$$_ArtDetailStateCopyWith(
          _$_ArtDetailState value, $Res Function(_$_ArtDetailState) then) =
      __$$_ArtDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isBookmarked,
      int preSelectedIndex,
      ArtModel? nearbyItem,
      LoadingState loadingState});

  @override
  $ArtModelCopyWith<$Res>? get nearbyItem;
}

/// @nodoc
class __$$_ArtDetailStateCopyWithImpl<$Res>
    extends _$ArtDetailStateCopyWithImpl<$Res, _$_ArtDetailState>
    implements _$$_ArtDetailStateCopyWith<$Res> {
  __$$_ArtDetailStateCopyWithImpl(
      _$_ArtDetailState _value, $Res Function(_$_ArtDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBookmarked = null,
    Object? preSelectedIndex = null,
    Object? nearbyItem = freezed,
    Object? loadingState = null,
  }) {
    return _then(_$_ArtDetailState(
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      nearbyItem: freezed == nearbyItem
          ? _value.nearbyItem
          : nearbyItem // ignore: cast_nullable_to_non_nullable
              as ArtModel?,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtDetailState implements _ArtDetailState {
  const _$_ArtDetailState(
      {required this.isBookmarked,
      required this.preSelectedIndex,
      required this.nearbyItem,
      required this.loadingState});

  factory _$_ArtDetailState.fromJson(Map<String, dynamic> json) =>
      _$$_ArtDetailStateFromJson(json);

  @override
  final bool isBookmarked;
  @override
  final int preSelectedIndex;
  @override
  final ArtModel? nearbyItem;
  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'ArtDetailState(isBookmarked: $isBookmarked, preSelectedIndex: $preSelectedIndex, nearbyItem: $nearbyItem, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArtDetailState &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.preSelectedIndex, preSelectedIndex) ||
                other.preSelectedIndex == preSelectedIndex) &&
            (identical(other.nearbyItem, nearbyItem) ||
                other.nearbyItem == nearbyItem) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isBookmarked, preSelectedIndex, nearbyItem, loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArtDetailStateCopyWith<_$_ArtDetailState> get copyWith =>
      __$$_ArtDetailStateCopyWithImpl<_$_ArtDetailState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtDetailStateToJson(
      this,
    );
  }
}

abstract class _ArtDetailState implements ArtDetailState {
  const factory _ArtDetailState(
      {required final bool isBookmarked,
      required final int preSelectedIndex,
      required final ArtModel? nearbyItem,
      required final LoadingState loadingState}) = _$_ArtDetailState;

  factory _ArtDetailState.fromJson(Map<String, dynamic> json) =
      _$_ArtDetailState.fromJson;

  @override
  bool get isBookmarked;
  @override
  int get preSelectedIndex;
  @override
  ArtModel? get nearbyItem;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_ArtDetailStateCopyWith<_$_ArtDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
