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
  List<ArtAbstractModel> get bookmarkArts => throw _privateConstructorUsedError;
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
      List<ArtAbstractModel> bookmarkArts,
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
    Object? bookmarkArts = null,
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
      bookmarkArts: null == bookmarkArts
          ? _value.bookmarkArts
          : bookmarkArts // ignore: cast_nullable_to_non_nullable
              as List<ArtAbstractModel>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarksStateImplCopyWith<$Res>
    implements $BookmarksStateCopyWith<$Res> {
  factory _$$BookmarksStateImplCopyWith(_$BookmarksStateImpl value,
          $Res Function(_$BookmarksStateImpl) then) =
      __$$BookmarksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<ArtAbstractModel> bookmarkArts,
      LoadingState loadingState});
}

/// @nodoc
class __$$BookmarksStateImplCopyWithImpl<$Res>
    extends _$BookmarksStateCopyWithImpl<$Res, _$BookmarksStateImpl>
    implements _$$BookmarksStateImplCopyWith<$Res> {
  __$$BookmarksStateImplCopyWithImpl(
      _$BookmarksStateImpl _value, $Res Function(_$BookmarksStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? bookmarkArts = null,
    Object? loadingState = null,
  }) {
    return _then(_$BookmarksStateImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarkArts: null == bookmarkArts
          ? _value._bookmarkArts
          : bookmarkArts // ignore: cast_nullable_to_non_nullable
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
class _$BookmarksStateImpl
    with DiagnosticableTreeMixin
    implements _BookmarksState {
  const _$BookmarksStateImpl(
      {required final List<String> ids,
      required this.count,
      required final List<ArtAbstractModel> bookmarkArts,
      required this.loadingState})
      : _ids = ids,
        _bookmarkArts = bookmarkArts;

  factory _$BookmarksStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarksStateImplFromJson(json);

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  final int count;
  final List<ArtAbstractModel> _bookmarkArts;
  @override
  List<ArtAbstractModel> get bookmarkArts {
    if (_bookmarkArts is EqualUnmodifiableListView) return _bookmarkArts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkArts);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookmarksState(ids: $ids, count: $count, bookmarkArts: $bookmarkArts, loadingState: $loadingState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookmarksState'))
      ..add(DiagnosticsProperty('ids', ids))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('bookmarkArts', bookmarkArts))
      ..add(DiagnosticsProperty('loadingState', loadingState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarksStateImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkArts, _bookmarkArts) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ids),
      count,
      const DeepCollectionEquality().hash(_bookmarkArts),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarksStateImplCopyWith<_$BookmarksStateImpl> get copyWith =>
      __$$BookmarksStateImplCopyWithImpl<_$BookmarksStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarksStateImplToJson(
      this,
    );
  }
}

abstract class _BookmarksState implements BookmarksState {
  const factory _BookmarksState(
      {required final List<String> ids,
      required final int count,
      required final List<ArtAbstractModel> bookmarkArts,
      required final LoadingState loadingState}) = _$BookmarksStateImpl;

  factory _BookmarksState.fromJson(Map<String, dynamic> json) =
      _$BookmarksStateImpl.fromJson;

  @override
  List<String> get ids;
  @override
  int get count;
  @override
  List<ArtAbstractModel> get bookmarkArts;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$BookmarksStateImplCopyWith<_$BookmarksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
