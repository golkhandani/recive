// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'likes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LikesState _$LikesStateFromJson(Map<String, dynamic> json) {
  return _LikesState.fromJson(json);
}

/// @nodoc
mixin _$LikesState {
  List<String> get ids => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  List<ArtAbstractModel> get bookmarkEvents =>
      throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LikesStateCopyWith<LikesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikesStateCopyWith<$Res> {
  factory $LikesStateCopyWith(
          LikesState value, $Res Function(LikesState) then) =
      _$LikesStateCopyWithImpl<$Res, LikesState>;
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<ArtAbstractModel> bookmarkEvents,
      LoadingState loadingState});
}

/// @nodoc
class _$LikesStateCopyWithImpl<$Res, $Val extends LikesState>
    implements $LikesStateCopyWith<$Res> {
  _$LikesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? bookmarkEvents = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarkEvents: null == bookmarkEvents
          ? _value.bookmarkEvents
          : bookmarkEvents // ignore: cast_nullable_to_non_nullable
              as List<ArtAbstractModel>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LikesStateCopyWith<$Res>
    implements $LikesStateCopyWith<$Res> {
  factory _$$_LikesStateCopyWith(
          _$_LikesState value, $Res Function(_$_LikesState) then) =
      __$$_LikesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<ArtAbstractModel> bookmarkEvents,
      LoadingState loadingState});
}

/// @nodoc
class __$$_LikesStateCopyWithImpl<$Res>
    extends _$LikesStateCopyWithImpl<$Res, _$_LikesState>
    implements _$$_LikesStateCopyWith<$Res> {
  __$$_LikesStateCopyWithImpl(
      _$_LikesState _value, $Res Function(_$_LikesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? bookmarkEvents = null,
    Object? loadingState = null,
  }) {
    return _then(_$_LikesState(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarkEvents: null == bookmarkEvents
          ? _value._bookmarkEvents
          : bookmarkEvents // ignore: cast_nullable_to_non_nullable
              as List<ArtAbstractModel>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LikesState implements _LikesState {
  const _$_LikesState(
      {required final List<String> ids,
      required this.count,
      required final List<ArtAbstractModel> bookmarkEvents,
      required this.loadingState})
      : _ids = ids,
        _bookmarkEvents = bookmarkEvents;

  factory _$_LikesState.fromJson(Map<String, dynamic> json) =>
      _$$_LikesStateFromJson(json);

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  final int count;
  final List<ArtAbstractModel> _bookmarkEvents;
  @override
  List<ArtAbstractModel> get bookmarkEvents {
    if (_bookmarkEvents is EqualUnmodifiableListView) return _bookmarkEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkEvents);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'LikesState(ids: $ids, count: $count, bookmarkEvents: $bookmarkEvents, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LikesState &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkEvents, _bookmarkEvents) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ids),
      count,
      const DeepCollectionEquality().hash(_bookmarkEvents),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LikesStateCopyWith<_$_LikesState> get copyWith =>
      __$$_LikesStateCopyWithImpl<_$_LikesState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LikesStateToJson(
      this,
    );
  }
}

abstract class _LikesState implements LikesState {
  const factory _LikesState(
      {required final List<String> ids,
      required final int count,
      required final List<ArtAbstractModel> bookmarkEvents,
      required final LoadingState loadingState}) = _$_LikesState;

  factory _LikesState.fromJson(Map<String, dynamic> json) =
      _$_LikesState.fromJson;

  @override
  List<String> get ids;
  @override
  int get count;
  @override
  List<ArtAbstractModel> get bookmarkEvents;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_LikesStateCopyWith<_$_LikesState> get copyWith =>
      throw _privateConstructorUsedError;
}
