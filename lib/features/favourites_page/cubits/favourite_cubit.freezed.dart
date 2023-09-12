// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouritesState _$FavouritesStateFromJson(Map<String, dynamic> json) {
  return _FavouritesState.fromJson(json);
}

/// @nodoc
mixin _$FavouritesState {
  List<String> get ids => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  List<FeaturedEvent> get favouriteEvents => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouritesStateCopyWith<FavouritesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouritesStateCopyWith<$Res> {
  factory $FavouritesStateCopyWith(
          FavouritesState value, $Res Function(FavouritesState) then) =
      _$FavouritesStateCopyWithImpl<$Res, FavouritesState>;
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<FeaturedEvent> favouriteEvents,
      LoadingState loadingState});
}

/// @nodoc
class _$FavouritesStateCopyWithImpl<$Res, $Val extends FavouritesState>
    implements $FavouritesStateCopyWith<$Res> {
  _$FavouritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? favouriteEvents = null,
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
      favouriteEvents: null == favouriteEvents
          ? _value.favouriteEvents
          : favouriteEvents // ignore: cast_nullable_to_non_nullable
              as List<FeaturedEvent>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavouritesStateCopyWith<$Res>
    implements $FavouritesStateCopyWith<$Res> {
  factory _$$_FavouritesStateCopyWith(
          _$_FavouritesState value, $Res Function(_$_FavouritesState) then) =
      __$$_FavouritesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> ids,
      int count,
      List<FeaturedEvent> favouriteEvents,
      LoadingState loadingState});
}

/// @nodoc
class __$$_FavouritesStateCopyWithImpl<$Res>
    extends _$FavouritesStateCopyWithImpl<$Res, _$_FavouritesState>
    implements _$$_FavouritesStateCopyWith<$Res> {
  __$$_FavouritesStateCopyWithImpl(
      _$_FavouritesState _value, $Res Function(_$_FavouritesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? count = null,
    Object? favouriteEvents = null,
    Object? loadingState = null,
  }) {
    return _then(_$_FavouritesState(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      favouriteEvents: null == favouriteEvents
          ? _value._favouriteEvents
          : favouriteEvents // ignore: cast_nullable_to_non_nullable
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
class _$_FavouritesState implements _FavouritesState {
  const _$_FavouritesState(
      {required final List<String> ids,
      required this.count,
      required final List<FeaturedEvent> favouriteEvents,
      required this.loadingState})
      : _ids = ids,
        _favouriteEvents = favouriteEvents;

  factory _$_FavouritesState.fromJson(Map<String, dynamic> json) =>
      _$$_FavouritesStateFromJson(json);

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  final int count;
  final List<FeaturedEvent> _favouriteEvents;
  @override
  List<FeaturedEvent> get favouriteEvents {
    if (_favouriteEvents is EqualUnmodifiableListView) return _favouriteEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favouriteEvents);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'FavouritesState(ids: $ids, count: $count, favouriteEvents: $favouriteEvents, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavouritesState &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._favouriteEvents, _favouriteEvents) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ids),
      count,
      const DeepCollectionEquality().hash(_favouriteEvents),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavouritesStateCopyWith<_$_FavouritesState> get copyWith =>
      __$$_FavouritesStateCopyWithImpl<_$_FavouritesState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouritesStateToJson(
      this,
    );
  }
}

abstract class _FavouritesState implements FavouritesState {
  const factory _FavouritesState(
      {required final List<String> ids,
      required final int count,
      required final List<FeaturedEvent> favouriteEvents,
      required final LoadingState loadingState}) = _$_FavouritesState;

  factory _FavouritesState.fromJson(Map<String, dynamic> json) =
      _$_FavouritesState.fromJson;

  @override
  List<String> get ids;
  @override
  int get count;
  @override
  List<FeaturedEvent> get favouriteEvents;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_FavouritesStateCopyWith<_$_FavouritesState> get copyWith =>
      throw _privateConstructorUsedError;
}
