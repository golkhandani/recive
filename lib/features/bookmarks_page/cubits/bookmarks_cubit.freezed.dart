// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookmarksState _$BookmarksStateFromJson(Map<String, dynamic> json) {
  return _BookmarksState.fromJson(json);
}

/// @nodoc
mixin _$BookmarksState {
  List<String> get ids => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  List<FeaturedEvent> get bookmarkEvents => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookmarksStateCopyWith<BookmarksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarksStateCopyWith<$Res> {
  factory $BookmarksStateCopyWith(
          BookmarksState value, $Res Function(BookmarksState) then) =
      _$BookmarksStateCopyWithImpl<$Res, BookmarksState>;
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<FeaturedEvent> bookmarkEvents,
      LoadingState loadingState});
}

/// @nodoc
class _$BookmarksStateCopyWithImpl<$Res, $Val extends BookmarksState>
    implements $BookmarksStateCopyWith<$Res> {
  _$BookmarksStateCopyWithImpl(this._value, this._then);

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
              as List<FeaturedEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookmarksStateCopyWith<$Res>
    implements $BookmarksStateCopyWith<$Res> {
  factory _$$_BookmarksStateCopyWith(
          _$_BookmarksState value, $Res Function(_$_BookmarksState) then) =
      __$$_BookmarksStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<FeaturedEvent> bookmarkEvents,
      LoadingState loadingState});
}

/// @nodoc
class __$$_BookmarksStateCopyWithImpl<$Res>
    extends _$BookmarksStateCopyWithImpl<$Res, _$_BookmarksState>
    implements _$$_BookmarksStateCopyWith<$Res> {
  __$$_BookmarksStateCopyWithImpl(
      _$_BookmarksState _value, $Res Function(_$_BookmarksState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? bookmarkEvents = null,
    Object? loadingState = null,
  }) {
    return _then(_$_BookmarksState(
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
class _$_BookmarksState implements _BookmarksState {
  const _$_BookmarksState(
      {required final List<String> ids,
      required this.count,
      required final List<FeaturedEvent> bookmarkEvents,
      required this.loadingState})
      : _ids = ids,
        _bookmarkEvents = bookmarkEvents;

  factory _$_BookmarksState.fromJson(Map<String, dynamic> json) =>
      _$$_BookmarksStateFromJson(json);

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  final int count;
  final List<FeaturedEvent> _bookmarkEvents;
  @override
  List<FeaturedEvent> get bookmarkEvents {
    if (_bookmarkEvents is EqualUnmodifiableListView) return _bookmarkEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkEvents);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'BookmarksState(ids: $ids, count: $count, bookmarkEvents: $bookmarkEvents, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookmarksState &&
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
  _$$_BookmarksStateCopyWith<_$_BookmarksState> get copyWith =>
      __$$_BookmarksStateCopyWithImpl<_$_BookmarksState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookmarksStateToJson(
      this,
    );
  }
}

abstract class _BookmarksState implements BookmarksState {
  const factory _BookmarksState(
      {required final List<String> ids,
      required final int count,
      required final List<FeaturedEvent> bookmarkEvents,
      required final LoadingState loadingState}) = _$_BookmarksState;

  factory _BookmarksState.fromJson(Map<String, dynamic> json) =
      _$_BookmarksState.fromJson;

  @override
  List<String> get ids;
  @override
  int get count;
  @override
  List<FeaturedEvent> get bookmarkEvents;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_BookmarksStateCopyWith<_$_BookmarksState> get copyWith =>
      throw _privateConstructorUsedError;
}
