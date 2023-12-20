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
abstract class _$$QuickSearchHeaderStateImplCopyWith<$Res>
    implements $QuickSearchHeaderStateCopyWith<$Res> {
  factory _$$QuickSearchHeaderStateImplCopyWith(
          _$QuickSearchHeaderStateImpl value,
          $Res Function(_$QuickSearchHeaderStateImpl) then) =
      __$$QuickSearchHeaderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query,
      bool isLoading,
      bool isSelected,
      List<String> suggestions});
}

/// @nodoc
class __$$QuickSearchHeaderStateImplCopyWithImpl<$Res>
    extends _$QuickSearchHeaderStateCopyWithImpl<$Res,
        _$QuickSearchHeaderStateImpl>
    implements _$$QuickSearchHeaderStateImplCopyWith<$Res> {
  __$$QuickSearchHeaderStateImplCopyWithImpl(
      _$QuickSearchHeaderStateImpl _value,
      $Res Function(_$QuickSearchHeaderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isLoading = null,
    Object? isSelected = null,
    Object? suggestions = null,
  }) {
    return _then(_$QuickSearchHeaderStateImpl(
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

class _$QuickSearchHeaderStateImpl implements _QuickSearchHeaderState {
  const _$QuickSearchHeaderStateImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickSearchHeaderStateImpl &&
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
  _$$QuickSearchHeaderStateImplCopyWith<_$QuickSearchHeaderStateImpl>
      get copyWith => __$$QuickSearchHeaderStateImplCopyWithImpl<
          _$QuickSearchHeaderStateImpl>(this, _$identity);
}

abstract class _QuickSearchHeaderState implements QuickSearchHeaderState {
  const factory _QuickSearchHeaderState(
      {final String query,
      final bool isLoading,
      final bool isSelected,
      final List<String> suggestions}) = _$QuickSearchHeaderStateImpl;

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
  _$$QuickSearchHeaderStateImplCopyWith<_$QuickSearchHeaderStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
