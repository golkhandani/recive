// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_section_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoriesState _$CategoriesStateFromJson(Map<String, dynamic> json) {
  return _CategoriesState.fromJson(json);
}

/// @nodoc
mixin _$CategoriesState {
  List<Category> get categories => throw _privateConstructorUsedError;
  List<Category> get categoriesSpotlight => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoriesStateCopyWith<CategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesStateCopyWith<$Res> {
  factory $CategoriesStateCopyWith(
          CategoriesState value, $Res Function(CategoriesState) then) =
      _$CategoriesStateCopyWithImpl<$Res, CategoriesState>;
  @useResult
  $Res call(
      {List<Category> categories,
      List<Category> categoriesSpotlight,
      LoadingState loadingState});
}

/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res, $Val extends CategoriesState>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? categoriesSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      categoriesSpotlight: null == categoriesSpotlight
          ? _value.categoriesSpotlight
          : categoriesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategoriesStateCopyWith<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  factory _$$_CategoriesStateCopyWith(
          _$_CategoriesState value, $Res Function(_$_CategoriesState) then) =
      __$$_CategoriesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Category> categories,
      List<Category> categoriesSpotlight,
      LoadingState loadingState});
}

/// @nodoc
class __$$_CategoriesStateCopyWithImpl<$Res>
    extends _$CategoriesStateCopyWithImpl<$Res, _$_CategoriesState>
    implements _$$_CategoriesStateCopyWith<$Res> {
  __$$_CategoriesStateCopyWithImpl(
      _$_CategoriesState _value, $Res Function(_$_CategoriesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? categoriesSpotlight = null,
    Object? loadingState = null,
  }) {
    return _then(_$_CategoriesState(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      categoriesSpotlight: null == categoriesSpotlight
          ? _value._categoriesSpotlight
          : categoriesSpotlight // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategoriesState implements _CategoriesState {
  const _$_CategoriesState(
      {required final List<Category> categories,
      required final List<Category> categoriesSpotlight,
      required this.loadingState})
      : _categories = categories,
        _categoriesSpotlight = categoriesSpotlight;

  factory _$_CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$$_CategoriesStateFromJson(json);

  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Category> _categoriesSpotlight;
  @override
  List<Category> get categoriesSpotlight {
    if (_categoriesSpotlight is EqualUnmodifiableListView)
      return _categoriesSpotlight;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoriesSpotlight);
  }

  @override
  final LoadingState loadingState;

  @override
  String toString() {
    return 'CategoriesState(categories: $categories, categoriesSpotlight: $categoriesSpotlight, loadingState: $loadingState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategoriesState &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesSpotlight, _categoriesSpotlight) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoriesSpotlight),
      loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoriesStateCopyWith<_$_CategoriesState> get copyWith =>
      __$$_CategoriesStateCopyWithImpl<_$_CategoriesState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoriesStateToJson(
      this,
    );
  }
}

abstract class _CategoriesState implements CategoriesState {
  const factory _CategoriesState(
      {required final List<Category> categories,
      required final List<Category> categoriesSpotlight,
      required final LoadingState loadingState}) = _$_CategoriesState;

  factory _CategoriesState.fromJson(Map<String, dynamic> json) =
      _$_CategoriesState.fromJson;

  @override
  List<Category> get categories;
  @override
  List<Category> get categoriesSpotlight;
  @override
  LoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$_CategoriesStateCopyWith<_$_CategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}