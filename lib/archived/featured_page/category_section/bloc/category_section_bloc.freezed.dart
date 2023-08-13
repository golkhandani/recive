// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_section_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategorySectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CategorySectionEventLoad value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CategorySectionEventLoad value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CategorySectionEventLoad value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySectionEventCopyWith<$Res> {
  factory $CategorySectionEventCopyWith(CategorySectionEvent value,
          $Res Function(CategorySectionEvent) then) =
      _$CategorySectionEventCopyWithImpl<$Res, CategorySectionEvent>;
}

/// @nodoc
class _$CategorySectionEventCopyWithImpl<$Res,
        $Val extends CategorySectionEvent>
    implements $CategorySectionEventCopyWith<$Res> {
  _$CategorySectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_CategorySectionEventLoadCopyWith<$Res> {
  factory _$$_CategorySectionEventLoadCopyWith(
          _$_CategorySectionEventLoad value,
          $Res Function(_$_CategorySectionEventLoad) then) =
      __$$_CategorySectionEventLoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CategorySectionEventLoadCopyWithImpl<$Res>
    extends _$CategorySectionEventCopyWithImpl<$Res,
        _$_CategorySectionEventLoad>
    implements _$$_CategorySectionEventLoadCopyWith<$Res> {
  __$$_CategorySectionEventLoadCopyWithImpl(_$_CategorySectionEventLoad _value,
      $Res Function(_$_CategorySectionEventLoad) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_CategorySectionEventLoad implements _CategorySectionEventLoad {
  const _$_CategorySectionEventLoad();

  @override
  String toString() {
    return 'CategorySectionEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategorySectionEventLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CategorySectionEventLoad value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CategorySectionEventLoad value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CategorySectionEventLoad value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _CategorySectionEventLoad implements CategorySectionEvent {
  const factory _CategorySectionEventLoad() = _$_CategorySectionEventLoad;
}

CategorySectionState _$CategorySectionStateFromJson(Map<String, dynamic> json) {
  return _CategorySectionState.fromJson(json);
}

/// @nodoc
mixin _$CategorySectionState {
  bool get isLoada => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<ReciveCategory> get categories => throw _privateConstructorUsedError;
  DateTime? get $cachedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategorySectionStateCopyWith<CategorySectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySectionStateCopyWith<$Res> {
  factory $CategorySectionStateCopyWith(CategorySectionState value,
          $Res Function(CategorySectionState) then) =
      _$CategorySectionStateCopyWithImpl<$Res, CategorySectionState>;
  @useResult
  $Res call(
      {bool isLoada,
      bool isLoading,
      List<ReciveCategory> categories,
      DateTime? $cachedAt});
}

/// @nodoc
class _$CategorySectionStateCopyWithImpl<$Res,
        $Val extends CategorySectionState>
    implements $CategorySectionStateCopyWith<$Res> {
  _$CategorySectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoada = null,
    Object? isLoading = null,
    Object? categories = null,
    Object? $cachedAt = freezed,
  }) {
    return _then(_value.copyWith(
      isLoada: null == isLoada
          ? _value.isLoada
          : isLoada // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ReciveCategory>,
      $cachedAt: freezed == $cachedAt
          ? _value.$cachedAt
          : $cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategorySectionStateCopyWith<$Res>
    implements $CategorySectionStateCopyWith<$Res> {
  factory _$$_CategorySectionStateCopyWith(_$_CategorySectionState value,
          $Res Function(_$_CategorySectionState) then) =
      __$$_CategorySectionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoada,
      bool isLoading,
      List<ReciveCategory> categories,
      DateTime? $cachedAt});
}

/// @nodoc
class __$$_CategorySectionStateCopyWithImpl<$Res>
    extends _$CategorySectionStateCopyWithImpl<$Res, _$_CategorySectionState>
    implements _$$_CategorySectionStateCopyWith<$Res> {
  __$$_CategorySectionStateCopyWithImpl(_$_CategorySectionState _value,
      $Res Function(_$_CategorySectionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoada = null,
    Object? isLoading = null,
    Object? categories = null,
    Object? $cachedAt = freezed,
  }) {
    return _then(_$_CategorySectionState(
      isLoada: null == isLoada
          ? _value.isLoada
          : isLoada // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ReciveCategory>,
      $cachedAt: freezed == $cachedAt
          ? _value.$cachedAt
          : $cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategorySectionState extends _CategorySectionState {
  const _$_CategorySectionState(
      {this.isLoada = false,
      this.isLoading = true,
      final List<ReciveCategory> categories = const [],
      this.$cachedAt = null})
      : _categories = categories,
        super._();

  factory _$_CategorySectionState.fromJson(Map<String, dynamic> json) =>
      _$$_CategorySectionStateFromJson(json);

  @override
  @JsonKey()
  final bool isLoada;
  @override
  @JsonKey()
  final bool isLoading;
  final List<ReciveCategory> _categories;
  @override
  @JsonKey()
  List<ReciveCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final DateTime? $cachedAt;

  @override
  String toString() {
    return 'CategorySectionState(isLoada: $isLoada, isLoading: $isLoading, categories: $categories, \$cachedAt: ${$cachedAt})';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategorySectionState &&
            (identical(other.isLoada, isLoada) || other.isLoada == isLoada) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.$cachedAt, $cachedAt) ||
                other.$cachedAt == $cachedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoada, isLoading,
      const DeepCollectionEquality().hash(_categories), $cachedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategorySectionStateCopyWith<_$_CategorySectionState> get copyWith =>
      __$$_CategorySectionStateCopyWithImpl<_$_CategorySectionState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategorySectionStateToJson(
      this,
    );
  }
}

abstract class _CategorySectionState extends CategorySectionState {
  const factory _CategorySectionState(
      {final bool isLoada,
      final bool isLoading,
      final List<ReciveCategory> categories,
      final DateTime? $cachedAt}) = _$_CategorySectionState;
  const _CategorySectionState._() : super._();

  factory _CategorySectionState.fromJson(Map<String, dynamic> json) =
      _$_CategorySectionState.fromJson;

  @override
  bool get isLoada;
  @override
  bool get isLoading;
  @override
  List<ReciveCategory> get categories;
  @override
  DateTime? get $cachedAt;
  @override
  @JsonKey(ignore: true)
  _$$_CategorySectionStateCopyWith<_$_CategorySectionState> get copyWith =>
      throw _privateConstructorUsedError;
}
