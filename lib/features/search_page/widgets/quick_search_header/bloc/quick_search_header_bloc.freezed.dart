// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_search_header_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuickSearchHeaderState {
  String get query => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;
  List<String> get suggestions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuickSearchHeaderStateCopyWith<QuickSearchHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickSearchHeaderStateCopyWith<$Res> {
  factory $QuickSearchHeaderStateCopyWith(QuickSearchHeaderState value,
          $Res Function(QuickSearchHeaderState) then) =
      _$QuickSearchHeaderStateCopyWithImpl<$Res, QuickSearchHeaderState>;
  @useResult
  $Res call(
      {String query,
      bool isLoading,
      bool isSelected,
      List<String> suggestions});
}

/// @nodoc
class _$QuickSearchHeaderStateCopyWithImpl<$Res,
        $Val extends QuickSearchHeaderState>
    implements $QuickSearchHeaderStateCopyWith<$Res> {
  _$QuickSearchHeaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isLoading = null,
    Object? isSelected = null,
    Object? suggestions = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestions: null == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuickSearchHeaderStateCopyWith<$Res>
    implements $QuickSearchHeaderStateCopyWith<$Res> {
  factory _$$_QuickSearchHeaderStateCopyWith(_$_QuickSearchHeaderState value,
          $Res Function(_$_QuickSearchHeaderState) then) =
      __$$_QuickSearchHeaderStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query,
      bool isLoading,
      bool isSelected,
      List<String> suggestions});
}

/// @nodoc
class __$$_QuickSearchHeaderStateCopyWithImpl<$Res>
    extends _$QuickSearchHeaderStateCopyWithImpl<$Res,
        _$_QuickSearchHeaderState>
    implements _$$_QuickSearchHeaderStateCopyWith<$Res> {
  __$$_QuickSearchHeaderStateCopyWithImpl(_$_QuickSearchHeaderState _value,
      $Res Function(_$_QuickSearchHeaderState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isLoading = null,
    Object? isSelected = null,
    Object? suggestions = null,
  }) {
    return _then(_$_QuickSearchHeaderState(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestions: null == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_QuickSearchHeaderState implements _QuickSearchHeaderState {
  const _$_QuickSearchHeaderState(
      {this.query = '',
      this.isLoading = false,
      this.isSelected = false,
      final List<String> suggestions = const []})
      : _suggestions = suggestions;

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSelected;
  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  String toString() {
    return 'QuickSearchHeaderState(query: $query, isLoading: $isLoading, isSelected: $isSelected, suggestions: $suggestions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuickSearchHeaderState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, isLoading, isSelected,
      const DeepCollectionEquality().hash(_suggestions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuickSearchHeaderStateCopyWith<_$_QuickSearchHeaderState> get copyWith =>
      __$$_QuickSearchHeaderStateCopyWithImpl<_$_QuickSearchHeaderState>(
          this, _$identity);
}

abstract class _QuickSearchHeaderState implements QuickSearchHeaderState {
  const factory _QuickSearchHeaderState(
      {final String query,
      final bool isLoading,
      final bool isSelected,
      final List<String> suggestions}) = _$_QuickSearchHeaderState;

  @override
  String get query;
  @override
  bool get isLoading;
  @override
  bool get isSelected;
  @override
  List<String> get suggestions;
  @override
  @JsonKey(ignore: true)
  _$$_QuickSearchHeaderStateCopyWith<_$_QuickSearchHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuickSearchHeaderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function(String selected) select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function(String selected)? select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function(String selected)? select,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuickSearchHeaderEventSearch value) search,
    required TResult Function(_QuickSearchHeaderEventSelect value) select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuickSearchHeaderEventSearch value)? search,
    TResult? Function(_QuickSearchHeaderEventSelect value)? select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuickSearchHeaderEventSearch value)? search,
    TResult Function(_QuickSearchHeaderEventSelect value)? select,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickSearchHeaderEventCopyWith<$Res> {
  factory $QuickSearchHeaderEventCopyWith(QuickSearchHeaderEvent value,
          $Res Function(QuickSearchHeaderEvent) then) =
      _$QuickSearchHeaderEventCopyWithImpl<$Res, QuickSearchHeaderEvent>;
}

/// @nodoc
class _$QuickSearchHeaderEventCopyWithImpl<$Res,
        $Val extends QuickSearchHeaderEvent>
    implements $QuickSearchHeaderEventCopyWith<$Res> {
  _$QuickSearchHeaderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_QuickSearchHeaderEventSearchCopyWith<$Res> {
  factory _$$_QuickSearchHeaderEventSearchCopyWith(
          _$_QuickSearchHeaderEventSearch value,
          $Res Function(_$_QuickSearchHeaderEventSearch) then) =
      __$$_QuickSearchHeaderEventSearchCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$_QuickSearchHeaderEventSearchCopyWithImpl<$Res>
    extends _$QuickSearchHeaderEventCopyWithImpl<$Res,
        _$_QuickSearchHeaderEventSearch>
    implements _$$_QuickSearchHeaderEventSearchCopyWith<$Res> {
  __$$_QuickSearchHeaderEventSearchCopyWithImpl(
      _$_QuickSearchHeaderEventSearch _value,
      $Res Function(_$_QuickSearchHeaderEventSearch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$_QuickSearchHeaderEventSearch(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_QuickSearchHeaderEventSearch implements _QuickSearchHeaderEventSearch {
  const _$_QuickSearchHeaderEventSearch({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'QuickSearchHeaderEvent.search(query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuickSearchHeaderEventSearch &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuickSearchHeaderEventSearchCopyWith<_$_QuickSearchHeaderEventSearch>
      get copyWith => __$$_QuickSearchHeaderEventSearchCopyWithImpl<
          _$_QuickSearchHeaderEventSearch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function(String selected) select,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function(String selected)? select,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function(String selected)? select,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuickSearchHeaderEventSearch value) search,
    required TResult Function(_QuickSearchHeaderEventSelect value) select,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuickSearchHeaderEventSearch value)? search,
    TResult? Function(_QuickSearchHeaderEventSelect value)? select,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuickSearchHeaderEventSearch value)? search,
    TResult Function(_QuickSearchHeaderEventSelect value)? select,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class _QuickSearchHeaderEventSearch implements QuickSearchHeaderEvent {
  const factory _QuickSearchHeaderEventSearch({required final String query}) =
      _$_QuickSearchHeaderEventSearch;

  String get query;
  @JsonKey(ignore: true)
  _$$_QuickSearchHeaderEventSearchCopyWith<_$_QuickSearchHeaderEventSearch>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_QuickSearchHeaderEventSelectCopyWith<$Res> {
  factory _$$_QuickSearchHeaderEventSelectCopyWith(
          _$_QuickSearchHeaderEventSelect value,
          $Res Function(_$_QuickSearchHeaderEventSelect) then) =
      __$$_QuickSearchHeaderEventSelectCopyWithImpl<$Res>;
  @useResult
  $Res call({String selected});
}

/// @nodoc
class __$$_QuickSearchHeaderEventSelectCopyWithImpl<$Res>
    extends _$QuickSearchHeaderEventCopyWithImpl<$Res,
        _$_QuickSearchHeaderEventSelect>
    implements _$$_QuickSearchHeaderEventSelectCopyWith<$Res> {
  __$$_QuickSearchHeaderEventSelectCopyWithImpl(
      _$_QuickSearchHeaderEventSelect _value,
      $Res Function(_$_QuickSearchHeaderEventSelect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = null,
  }) {
    return _then(_$_QuickSearchHeaderEventSelect(
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_QuickSearchHeaderEventSelect implements _QuickSearchHeaderEventSelect {
  const _$_QuickSearchHeaderEventSelect({required this.selected});

  @override
  final String selected;

  @override
  String toString() {
    return 'QuickSearchHeaderEvent.select(selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuickSearchHeaderEventSelect &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuickSearchHeaderEventSelectCopyWith<_$_QuickSearchHeaderEventSelect>
      get copyWith => __$$_QuickSearchHeaderEventSelectCopyWithImpl<
          _$_QuickSearchHeaderEventSelect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function(String selected) select,
  }) {
    return select(selected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function(String selected)? select,
  }) {
    return select?.call(selected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function(String selected)? select,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(selected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QuickSearchHeaderEventSearch value) search,
    required TResult Function(_QuickSearchHeaderEventSelect value) select,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_QuickSearchHeaderEventSearch value)? search,
    TResult? Function(_QuickSearchHeaderEventSelect value)? select,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QuickSearchHeaderEventSearch value)? search,
    TResult Function(_QuickSearchHeaderEventSelect value)? select,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }
}

abstract class _QuickSearchHeaderEventSelect implements QuickSearchHeaderEvent {
  const factory _QuickSearchHeaderEventSelect(
      {required final String selected}) = _$_QuickSearchHeaderEventSelect;

  String get selected;
  @JsonKey(ignore: true)
  _$$_QuickSearchHeaderEventSelectCopyWith<_$_QuickSearchHeaderEventSelect>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuickSearchHeaderState {
  String get query => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;
  List<String> get suggestions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuickSearchHeaderStateCopyWith<QuickSearchHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickSearchHeaderStateCopyWith<$Res> {
  factory $QuickSearchHeaderStateCopyWith(QuickSearchHeaderState value,
          $Res Function(QuickSearchHeaderState) then) =
      _$QuickSearchHeaderStateCopyWithImpl<$Res, QuickSearchHeaderState>;
  @useResult
  $Res call(
      {String query,
      bool isLoading,
      bool isSelected,
      List<String> suggestions});
}

/// @nodoc
class _$QuickSearchHeaderStateCopyWithImpl<$Res,
        $Val extends QuickSearchHeaderState>
    implements $QuickSearchHeaderStateCopyWith<$Res> {
  _$QuickSearchHeaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isLoading = null,
    Object? isSelected = null,
    Object? suggestions = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestions: null == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuickSearchHeaderStateCopyWith<$Res>
    implements $QuickSearchHeaderStateCopyWith<$Res> {
  factory _$$_QuickSearchHeaderStateCopyWith(_$_QuickSearchHeaderState value,
          $Res Function(_$_QuickSearchHeaderState) then) =
      __$$_QuickSearchHeaderStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query,
      bool isLoading,
      bool isSelected,
      List<String> suggestions});
}

/// @nodoc
class __$$_QuickSearchHeaderStateCopyWithImpl<$Res>
    extends _$QuickSearchHeaderStateCopyWithImpl<$Res,
        _$_QuickSearchHeaderState>
    implements _$$_QuickSearchHeaderStateCopyWith<$Res> {
  __$$_QuickSearchHeaderStateCopyWithImpl(_$_QuickSearchHeaderState _value,
      $Res Function(_$_QuickSearchHeaderState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isLoading = null,
    Object? isSelected = null,
    Object? suggestions = null,
  }) {
    return _then(_$_QuickSearchHeaderState(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestions: null == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_QuickSearchHeaderState implements _QuickSearchHeaderState {
  const _$_QuickSearchHeaderState(
      {this.query = '',
      this.isLoading = false,
      this.isSelected = false,
      final List<String> suggestions = const []})
      : _suggestions = suggestions;

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSelected;
  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  String toString() {
    return 'QuickSearchHeaderState(query: $query, isLoading: $isLoading, isSelected: $isSelected, suggestions: $suggestions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuickSearchHeaderState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, isLoading, isSelected,
      const DeepCollectionEquality().hash(_suggestions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuickSearchHeaderStateCopyWith<_$_QuickSearchHeaderState> get copyWith =>
      __$$_QuickSearchHeaderStateCopyWithImpl<_$_QuickSearchHeaderState>(
          this, _$identity);
}

abstract class _QuickSearchHeaderState implements QuickSearchHeaderState {
  const factory _QuickSearchHeaderState(
      {final String query,
      final bool isLoading,
      final bool isSelected,
      final List<String> suggestions}) = _$_QuickSearchHeaderState;

  @override
  String get query;
  @override
  bool get isLoading;
  @override
  bool get isSelected;
  @override
  List<String> get suggestions;
  @override
  @JsonKey(ignore: true)
  _$$_QuickSearchHeaderStateCopyWith<_$_QuickSearchHeaderState> get copyWith =>
      throw _privateConstructorUsedError;
}
