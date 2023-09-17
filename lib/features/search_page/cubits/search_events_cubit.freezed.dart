// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchEventsState _$SearchEventsStateFromJson(Map<String, dynamic> json) {
  return _SearchEventsState.fromJson(json);
}

/// @nodoc
mixin _$SearchEventsState {
  int get preSelectedEventIndex => throw _privateConstructorUsedError;
  List<PackageAbstract> get searchedEvents =>
      throw _privateConstructorUsedError;
  LoadingState get loadingKeywordsState => throw _privateConstructorUsedError;
  List<String> get searchedkeywords => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;
  int? get distanceFilter => throw _privateConstructorUsedError;
  String? get queryFilter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchEventsStateCopyWith<SearchEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchEventsStateCopyWith<$Res> {
  factory $SearchEventsStateCopyWith(
          SearchEventsState value, $Res Function(SearchEventsState) then) =
      _$SearchEventsStateCopyWithImpl<$Res, SearchEventsState>;
  @useResult
  $Res call(
      {int preSelectedEventIndex,
      List<PackageAbstract> searchedEvents,
      LoadingState loadingKeywordsState,
      List<String> searchedkeywords,
      LoadingState loadingState,
      int? distanceFilter,
      String? queryFilter});
}

/// @nodoc
class _$SearchEventsStateCopyWithImpl<$Res, $Val extends SearchEventsState>
    implements $SearchEventsStateCopyWith<$Res> {
  _$SearchEventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedEventIndex = null,
    Object? searchedEvents = null,
    Object? loadingKeywordsState = null,
    Object? searchedkeywords = null,
    Object? loadingState = null,
    Object? distanceFilter = freezed,
    Object? queryFilter = freezed,
  }) {
    return _then(_value.copyWith(
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchedEvents: null == searchedEvents
          ? _value.searchedEvents
          : searchedEvents // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
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
abstract class _$$_SearchEventsStateCopyWith<$Res>
    implements $SearchEventsStateCopyWith<$Res> {
  factory _$$_SearchEventsStateCopyWith(_$_SearchEventsState value,
          $Res Function(_$_SearchEventsState) then) =
      __$$_SearchEventsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int preSelectedEventIndex,
      List<PackageAbstract> searchedEvents,
      LoadingState loadingKeywordsState,
      List<String> searchedkeywords,
      LoadingState loadingState,
      int? distanceFilter,
      String? queryFilter});
}

/// @nodoc
class __$$_SearchEventsStateCopyWithImpl<$Res>
    extends _$SearchEventsStateCopyWithImpl<$Res, _$_SearchEventsState>
    implements _$$_SearchEventsStateCopyWith<$Res> {
  __$$_SearchEventsStateCopyWithImpl(
      _$_SearchEventsState _value, $Res Function(_$_SearchEventsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSelectedEventIndex = null,
    Object? searchedEvents = null,
    Object? loadingKeywordsState = null,
    Object? searchedkeywords = null,
    Object? loadingState = null,
    Object? distanceFilter = freezed,
    Object? queryFilter = freezed,
  }) {
    return _then(_$_SearchEventsState(
      preSelectedEventIndex: null == preSelectedEventIndex
          ? _value.preSelectedEventIndex
          : preSelectedEventIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchedEvents: null == searchedEvents
          ? _value._searchedEvents
          : searchedEvents // ignore: cast_nullable_to_non_nullable
              as List<PackageAbstract>,
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
class _$_SearchEventsState implements _SearchEventsState {
  const _$_SearchEventsState(
      {required this.preSelectedEventIndex,
      required final List<PackageAbstract> searchedEvents,
      required this.loadingKeywordsState,
      required final List<String> searchedkeywords,
      required this.loadingState,
      required this.distanceFilter,
      required this.queryFilter})
      : _searchedEvents = searchedEvents,
        _searchedkeywords = searchedkeywords;

  factory _$_SearchEventsState.fromJson(Map<String, dynamic> json) =>
      _$$_SearchEventsStateFromJson(json);

  @override
  final int preSelectedEventIndex;
  final List<PackageAbstract> _searchedEvents;
  @override
  List<PackageAbstract> get searchedEvents {
    if (_searchedEvents is EqualUnmodifiableListView) return _searchedEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedEvents);
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
    return 'SearchEventsState(preSelectedEventIndex: $preSelectedEventIndex, searchedEvents: $searchedEvents, loadingKeywordsState: $loadingKeywordsState, searchedkeywords: $searchedkeywords, loadingState: $loadingState, distanceFilter: $distanceFilter, queryFilter: $queryFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchEventsState &&
            (identical(other.preSelectedEventIndex, preSelectedEventIndex) ||
                other.preSelectedEventIndex == preSelectedEventIndex) &&
            const DeepCollectionEquality()
                .equals(other._searchedEvents, _searchedEvents) &&
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
      preSelectedEventIndex,
      const DeepCollectionEquality().hash(_searchedEvents),
      loadingKeywordsState,
      const DeepCollectionEquality().hash(_searchedkeywords),
      loadingState,
      distanceFilter,
      queryFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchEventsStateCopyWith<_$_SearchEventsState> get copyWith =>
      __$$_SearchEventsStateCopyWithImpl<_$_SearchEventsState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchEventsStateToJson(
      this,
    );
  }
}

abstract class _SearchEventsState implements SearchEventsState {
  const factory _SearchEventsState(
      {required final int preSelectedEventIndex,
      required final List<PackageAbstract> searchedEvents,
      required final LoadingState loadingKeywordsState,
      required final List<String> searchedkeywords,
      required final LoadingState loadingState,
      required final int? distanceFilter,
      required final String? queryFilter}) = _$_SearchEventsState;

  factory _SearchEventsState.fromJson(Map<String, dynamic> json) =
      _$_SearchEventsState.fromJson;

  @override
  int get preSelectedEventIndex;
  @override
  List<PackageAbstract> get searchedEvents;
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
  _$$_SearchEventsStateCopyWith<_$_SearchEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}
