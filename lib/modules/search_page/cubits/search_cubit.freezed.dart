// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchState _$SearchStateFromJson(Map<String, dynamic> json) {
  return _SearchState.fromJson(json);
}

/// @nodoc
mixin _$SearchState {
  int get preSelectedIndex => throw _privateConstructorUsedError;
  List<ArtRouteAbstractModel> get searchedItems =>
      throw _privateConstructorUsedError;
  LoadingState get loadingKeywordsState => throw _privateConstructorUsedError;
  List<String> get searchedkeywords => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;
  int? get distanceFilter => throw _privateConstructorUsedError;
  String? get queryFilter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {int preSelectedIndex,
      List<ArtRouteAbstractModel> searchedItems,
      LoadingState loadingKeywordsState,
      List<String> searchedkeywords,
      LoadingState loadingState,
      int? distanceFilter,
      String? queryFilter});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedIndex = null,
    Object? searchedItems = null,
    Object? loadingKeywordsState = null,
    Object? searchedkeywords = null,
    Object? loadingState = null,
    Object? distanceFilter = freezed,
    Object? queryFilter = freezed,
  }) {
    return _then(_value.copyWith(
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchedItems: null == searchedItems
          ? _value.searchedItems
          : searchedItems // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
      loadingKeywordsState: null == loadingKeywordsState
          ? _value.loadingKeywordsState
          : loadingKeywordsState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      searchedkeywords: null == searchedkeywords
          ? _value.searchedkeywords
          : searchedkeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      distanceFilter: freezed == distanceFilter
          ? _value.distanceFilter
          : distanceFilter // ignore: cast_nullable_to_non_nullable
              as int?,
      queryFilter: freezed == queryFilter
          ? _value.queryFilter
          : queryFilter // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int preSelectedIndex,
      List<ArtRouteAbstractModel> searchedItems,
      LoadingState loadingKeywordsState,
      List<String> searchedkeywords,
      LoadingState loadingState,
      int? distanceFilter,
      String? queryFilter});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedIndex = null,
    Object? searchedItems = null,
    Object? loadingKeywordsState = null,
    Object? searchedkeywords = null,
    Object? loadingState = null,
    Object? distanceFilter = freezed,
    Object? queryFilter = freezed,
  }) {
    return _then(_$SearchStateImpl(
      preSelectedIndex: null == preSelectedIndex
          ? _value.preSelectedIndex
          : preSelectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchedItems: null == searchedItems
          ? _value._searchedItems
          : searchedItems // ignore: cast_nullable_to_non_nullable
              as List<ArtRouteAbstractModel>,
      loadingKeywordsState: null == loadingKeywordsState
          ? _value.loadingKeywordsState
          : loadingKeywordsState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      searchedkeywords: null == searchedkeywords
          ? _value._searchedkeywords
          : searchedkeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      distanceFilter: freezed == distanceFilter
          ? _value.distanceFilter
          : distanceFilter // ignore: cast_nullable_to_non_nullable
              as int?,
      queryFilter: freezed == queryFilter
          ? _value.queryFilter
          : queryFilter // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl(
      {required this.preSelectedIndex,
      required final List<ArtRouteAbstractModel> searchedItems,
      required this.loadingKeywordsState,
      required final List<String> searchedkeywords,
      required this.loadingState,
      required this.distanceFilter,
      required this.queryFilter})
      : _searchedItems = searchedItems,
        _searchedkeywords = searchedkeywords;

  factory _$SearchStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchStateImplFromJson(json);

  @override
  final int preSelectedIndex;
  final List<ArtRouteAbstractModel> _searchedItems;
  @override
  List<ArtRouteAbstractModel> get searchedItems {
    if (_searchedItems is EqualUnmodifiableListView) return _searchedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedItems);
  }

  @override
  final LoadingState loadingKeywordsState;
  final List<String> _searchedkeywords;
  @override
  List<String> get searchedkeywords {
    if (_searchedkeywords is EqualUnmodifiableListView)
      return _searchedkeywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedkeywords);
  }

  @override
  final LoadingState loadingState;
  @override
  final int? distanceFilter;
  @override
  final String? queryFilter;

  @override
  String toString() {
    return 'SearchState(preSelectedIndex: $preSelectedIndex, searchedItems: $searchedItems, loadingKeywordsState: $loadingKeywordsState, searchedkeywords: $searchedkeywords, loadingState: $loadingState, distanceFilter: $distanceFilter, queryFilter: $queryFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.preSelectedIndex, preSelectedIndex) ||
                other.preSelectedIndex == preSelectedIndex) &&
            const DeepCollectionEquality()
                .equals(other._searchedItems, _searchedItems) &&
            (identical(other.loadingKeywordsState, loadingKeywordsState) ||
                other.loadingKeywordsState == loadingKeywordsState) &&
            const DeepCollectionEquality()
                .equals(other._searchedkeywords, _searchedkeywords) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState) &&
            (identical(other.distanceFilter, distanceFilter) ||
                other.distanceFilter == distanceFilter) &&
            (identical(other.queryFilter, queryFilter) ||
                other.queryFilter == queryFilter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      preSelectedIndex,
      const DeepCollectionEquality().hash(_searchedItems),
      loadingKeywordsState,
      const DeepCollectionEquality().hash(_searchedkeywords),
      loadingState,
      distanceFilter,
      queryFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchStateImplToJson(
      this,
    );
  }
}

abstract class _SearchState implements SearchState {
  const factory _SearchState(
      {required final int preSelectedIndex,
      required final List<ArtRouteAbstractModel> searchedItems,
      required final LoadingState loadingKeywordsState,
      required final List<String> searchedkeywords,
      required final LoadingState loadingState,
      required final int? distanceFilter,
      required final String? queryFilter}) = _$SearchStateImpl;

  factory _SearchState.fromJson(Map<String, dynamic> json) =
      _$SearchStateImpl.fromJson;

  @override
  int get preSelectedIndex;
  @override
  List<ArtRouteAbstractModel> get searchedItems;
  @override
  LoadingState get loadingKeywordsState;
  @override
  List<String> get searchedkeywords;
  @override
  LoadingState get loadingState;
  @override
  int? get distanceFilter;
  @override
  String? get queryFilter;
  @override
  @JsonKey(ignore: true)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
