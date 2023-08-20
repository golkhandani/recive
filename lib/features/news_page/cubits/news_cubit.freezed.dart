// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewsState _$NewsStateFromJson(Map<String, dynamic> json) {
  return _NewsState.fromJson(json);
}

/// @nodoc
mixin _$NewsState {
  List<NewsModel> get news => throw _privateConstructorUsedError;
  List<NewsModel> get newsSpotlight => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsStateCopyWith<NewsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsStateCopyWith<$Res> {
  factory $NewsStateCopyWith(NewsState value, $Res Function(NewsState) then) =
      _$NewsStateCopyWithImpl<$Res, NewsState>;
  @useResult
  $Res call(
      {List<NewsModel> news,
      List<NewsModel> newsSpotlight,
      LoadingState loadingState});
}

/// @nodoc
class _$NewsStateCopyWithImpl<$Res, $Val extends NewsState>
    implements $NewsStateCopyWith<$Res> {
  _$NewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? news = null,
    Object? newsSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      news: null == news
          ? _value.news
          : news // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      newsSpotlight: null == newsSpotlight
          ? _value.newsSpotlight
          : newsSpotlight // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewsStateCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$$_NewsStateCopyWith(
          _$_NewsState value, $Res Function(_$_NewsState) then) =
      __$$_NewsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NewsModel> news,
      List<NewsModel> newsSpotlight,
      LoadingState loadingState});
}

/// @nodoc
class __$$_NewsStateCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$_NewsState>
    implements _$$_NewsStateCopyWith<$Res> {
  __$$_NewsStateCopyWithImpl(
      _$_NewsState _value, $Res Function(_$_NewsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? news = null,
    Object? newsSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_$_NewsState(
      news: null == news
          ? _value._news
          : news // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      newsSpotlight: null == newsSpotlight
          ? _value._newsSpotlight
          : newsSpotlight // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewsState implements _NewsState {
  const _$_NewsState(
      {required final List<NewsModel> news,
      required final List<NewsModel> newsSpotlight,
      required this.loadingState})
      : _news = news,
        _newsSpotlight = newsSpotlight;

  factory _$_NewsState.fromJson(Map<String, dynamic> json) =>
      _$$_NewsStateFromJson(json);

  final List<NewsModel> _news;
  @override
  List<NewsModel> get news {
    if (_news is EqualUnmodifiableListView) return _news;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_news);
  }

  final List<NewsModel> _newsSpotlight;
  @override
  List<NewsModel> get newsSpotlight {
    if (_newsSpotlight is EqualUnmodifiableListView) return _newsSpotlight;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newsSpotlight);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'NewsState(news: $news, newsSpotlight: $newsSpotlight, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewsState &&
            const DeepCollectionEquality().equals(other._news, _news) &&
            const DeepCollectionEquality()
                .equals(other._newsSpotlight, _newsSpotlight) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_news),
      const DeepCollectionEquality().hash(_newsSpotlight),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewsStateCopyWith<_$_NewsState> get copyWith =>
      __$$_NewsStateCopyWithImpl<_$_NewsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewsStateToJson(
      this,
    );
  }
}

abstract class _NewsState implements NewsState {
  const factory _NewsState(
      {required final List<NewsModel> news,
      required final List<NewsModel> newsSpotlight,
      required final LoadingState loadingState}) = _$_NewsState;

  factory _NewsState.fromJson(Map<String, dynamic> json) =
      _$_NewsState.fromJson;

  @override
  List<NewsModel> get news;
  @override
  List<NewsModel> get newsSpotlight;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_NewsStateCopyWith<_$_NewsState> get copyWith =>
      throw _privateConstructorUsedError;
}
