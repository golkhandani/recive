// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recive.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Recive _$ReciveFromJson(Map<String, dynamic> json) {
  return _Recive.fromJson(json);
}

/// @nodoc
mixin _$Recive {
  String get title => throw _privateConstructorUsedError;
  CreatorSummary get creatorSummary => throw _privateConstructorUsedError;
  Origin get origin => throw _privateConstructorUsedError;
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  List<InstructionStep> get instructions => throw _privateConstructorUsedError;
  DifficultyLevel get difficultyLevel => throw _privateConstructorUsedError;
  int get preparationTimeMinute => throw _privateConstructorUsedError;
  int get cookingTimeMinute => throw _privateConstructorUsedError;
  String get serving => throw _privateConstructorUsedError;
  String get cuisineType => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<Allergen> get allergens => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  List<String> get variations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReciveCopyWith<Recive> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReciveCopyWith<$Res> {
  factory $ReciveCopyWith(Recive value, $Res Function(Recive) then) =
      _$ReciveCopyWithImpl<$Res, Recive>;
  @useResult
  $Res call(
      {String title,
      CreatorSummary creatorSummary,
      Origin origin,
      List<Ingredient> ingredients,
      List<InstructionStep> instructions,
      DifficultyLevel difficultyLevel,
      int preparationTimeMinute,
      int cookingTimeMinute,
      String serving,
      String cuisineType,
      int calories,
      List<String> imageUrls,
      List<String> tags,
      List<Allergen> allergens,
      String source,
      List<String> variations});

  $CreatorSummaryCopyWith<$Res> get creatorSummary;
  $OriginCopyWith<$Res> get origin;
}

/// @nodoc
class _$ReciveCopyWithImpl<$Res, $Val extends Recive>
    implements $ReciveCopyWith<$Res> {
  _$ReciveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? creatorSummary = null,
    Object? origin = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? difficultyLevel = null,
    Object? preparationTimeMinute = null,
    Object? cookingTimeMinute = null,
    Object? serving = null,
    Object? cuisineType = null,
    Object? calories = null,
    Object? imageUrls = null,
    Object? tags = null,
    Object? allergens = null,
    Object? source = null,
    Object? variations = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      creatorSummary: null == creatorSummary
          ? _value.creatorSummary
          : creatorSummary // ignore: cast_nullable_to_non_nullable
              as CreatorSummary,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Origin,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<InstructionStep>,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      preparationTimeMinute: null == preparationTimeMinute
          ? _value.preparationTimeMinute
          : preparationTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      cookingTimeMinute: null == cookingTimeMinute
          ? _value.cookingTimeMinute
          : cookingTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      serving: null == serving
          ? _value.serving
          : serving // ignore: cast_nullable_to_non_nullable
              as String,
      cuisineType: null == cuisineType
          ? _value.cuisineType
          : cuisineType // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value.allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<Allergen>,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      variations: null == variations
          ? _value.variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreatorSummaryCopyWith<$Res> get creatorSummary {
    return $CreatorSummaryCopyWith<$Res>(_value.creatorSummary, (value) {
      return _then(_value.copyWith(creatorSummary: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OriginCopyWith<$Res> get origin {
    return $OriginCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReciveCopyWith<$Res> implements $ReciveCopyWith<$Res> {
  factory _$$_ReciveCopyWith(_$_Recive value, $Res Function(_$_Recive) then) =
      __$$_ReciveCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      CreatorSummary creatorSummary,
      Origin origin,
      List<Ingredient> ingredients,
      List<InstructionStep> instructions,
      DifficultyLevel difficultyLevel,
      int preparationTimeMinute,
      int cookingTimeMinute,
      String serving,
      String cuisineType,
      int calories,
      List<String> imageUrls,
      List<String> tags,
      List<Allergen> allergens,
      String source,
      List<String> variations});

  @override
  $CreatorSummaryCopyWith<$Res> get creatorSummary;
  @override
  $OriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$_ReciveCopyWithImpl<$Res>
    extends _$ReciveCopyWithImpl<$Res, _$_Recive>
    implements _$$_ReciveCopyWith<$Res> {
  __$$_ReciveCopyWithImpl(_$_Recive _value, $Res Function(_$_Recive) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? creatorSummary = null,
    Object? origin = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? difficultyLevel = null,
    Object? preparationTimeMinute = null,
    Object? cookingTimeMinute = null,
    Object? serving = null,
    Object? cuisineType = null,
    Object? calories = null,
    Object? imageUrls = null,
    Object? tags = null,
    Object? allergens = null,
    Object? source = null,
    Object? variations = null,
  }) {
    return _then(_$_Recive(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      creatorSummary: null == creatorSummary
          ? _value.creatorSummary
          : creatorSummary // ignore: cast_nullable_to_non_nullable
              as CreatorSummary,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Origin,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<InstructionStep>,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      preparationTimeMinute: null == preparationTimeMinute
          ? _value.preparationTimeMinute
          : preparationTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      cookingTimeMinute: null == cookingTimeMinute
          ? _value.cookingTimeMinute
          : cookingTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      serving: null == serving
          ? _value.serving
          : serving // ignore: cast_nullable_to_non_nullable
              as String,
      cuisineType: null == cuisineType
          ? _value.cuisineType
          : cuisineType // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allergens: null == allergens
          ? _value._allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<Allergen>,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      variations: null == variations
          ? _value._variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Recive with DiagnosticableTreeMixin implements _Recive {
  const _$_Recive(
      {required this.title,
      required this.creatorSummary,
      required this.origin,
      required final List<Ingredient> ingredients,
      required final List<InstructionStep> instructions,
      required this.difficultyLevel,
      required this.preparationTimeMinute,
      required this.cookingTimeMinute,
      required this.serving,
      required this.cuisineType,
      required this.calories,
      required final List<String> imageUrls,
      required final List<String> tags,
      required final List<Allergen> allergens,
      required this.source,
      required final List<String> variations})
      : _ingredients = ingredients,
        _instructions = instructions,
        _imageUrls = imageUrls,
        _tags = tags,
        _allergens = allergens,
        _variations = variations;

  factory _$_Recive.fromJson(Map<String, dynamic> json) =>
      _$$_ReciveFromJson(json);

  @override
  final String title;
  @override
  final CreatorSummary creatorSummary;
  @override
  final Origin origin;
  final List<Ingredient> _ingredients;
  @override
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<InstructionStep> _instructions;
  @override
  List<InstructionStep> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  @override
  final DifficultyLevel difficultyLevel;
  @override
  final int preparationTimeMinute;
  @override
  final int cookingTimeMinute;
  @override
  final String serving;
  @override
  final String cuisineType;
  @override
  final int calories;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<Allergen> _allergens;
  @override
  List<Allergen> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  @override
  final String source;
  final List<String> _variations;
  @override
  List<String> get variations {
    if (_variations is EqualUnmodifiableListView) return _variations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variations);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Recive(title: $title, creatorSummary: $creatorSummary, origin: $origin, ingredients: $ingredients, instructions: $instructions, difficultyLevel: $difficultyLevel, preparationTimeMinute: $preparationTimeMinute, cookingTimeMinute: $cookingTimeMinute, serving: $serving, cuisineType: $cuisineType, calories: $calories, imageUrls: $imageUrls, tags: $tags, allergens: $allergens, source: $source, variations: $variations)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Recive'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('creatorSummary', creatorSummary))
      ..add(DiagnosticsProperty('origin', origin))
      ..add(DiagnosticsProperty('ingredients', ingredients))
      ..add(DiagnosticsProperty('instructions', instructions))
      ..add(DiagnosticsProperty('difficultyLevel', difficultyLevel))
      ..add(DiagnosticsProperty('preparationTimeMinute', preparationTimeMinute))
      ..add(DiagnosticsProperty('cookingTimeMinute', cookingTimeMinute))
      ..add(DiagnosticsProperty('serving', serving))
      ..add(DiagnosticsProperty('cuisineType', cuisineType))
      ..add(DiagnosticsProperty('calories', calories))
      ..add(DiagnosticsProperty('imageUrls', imageUrls))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('allergens', allergens))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('variations', variations));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recive &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.creatorSummary, creatorSummary) ||
                other.creatorSummary == creatorSummary) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.preparationTimeMinute, preparationTimeMinute) ||
                other.preparationTimeMinute == preparationTimeMinute) &&
            (identical(other.cookingTimeMinute, cookingTimeMinute) ||
                other.cookingTimeMinute == cookingTimeMinute) &&
            (identical(other.serving, serving) || other.serving == serving) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._allergens, _allergens) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality()
                .equals(other._variations, _variations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      creatorSummary,
      origin,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_instructions),
      difficultyLevel,
      preparationTimeMinute,
      cookingTimeMinute,
      serving,
      cuisineType,
      calories,
      const DeepCollectionEquality().hash(_imageUrls),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_allergens),
      source,
      const DeepCollectionEquality().hash(_variations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReciveCopyWith<_$_Recive> get copyWith =>
      __$$_ReciveCopyWithImpl<_$_Recive>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReciveToJson(
      this,
    );
  }
}

abstract class _Recive implements Recive {
  const factory _Recive(
      {required final String title,
      required final CreatorSummary creatorSummary,
      required final Origin origin,
      required final List<Ingredient> ingredients,
      required final List<InstructionStep> instructions,
      required final DifficultyLevel difficultyLevel,
      required final int preparationTimeMinute,
      required final int cookingTimeMinute,
      required final String serving,
      required final String cuisineType,
      required final int calories,
      required final List<String> imageUrls,
      required final List<String> tags,
      required final List<Allergen> allergens,
      required final String source,
      required final List<String> variations}) = _$_Recive;

  factory _Recive.fromJson(Map<String, dynamic> json) = _$_Recive.fromJson;

  @override
  String get title;
  @override
  CreatorSummary get creatorSummary;
  @override
  Origin get origin;
  @override
  List<Ingredient> get ingredients;
  @override
  List<InstructionStep> get instructions;
  @override
  DifficultyLevel get difficultyLevel;
  @override
  int get preparationTimeMinute;
  @override
  int get cookingTimeMinute;
  @override
  String get serving;
  @override
  String get cuisineType;
  @override
  int get calories;
  @override
  List<String> get imageUrls;
  @override
  List<String> get tags;
  @override
  List<Allergen> get allergens;
  @override
  String get source;
  @override
  List<String> get variations;
  @override
  @JsonKey(ignore: true)
  _$$_ReciveCopyWith<_$_Recive> get copyWith =>
      throw _privateConstructorUsedError;
}

Allergen _$AllergenFromJson(Map<String, dynamic> json) {
  return _Allergen.fromJson(json);
}

/// @nodoc
mixin _$Allergen {
  String get name => throw _privateConstructorUsedError;
  String get infoLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllergenCopyWith<Allergen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergenCopyWith<$Res> {
  factory $AllergenCopyWith(Allergen value, $Res Function(Allergen) then) =
      _$AllergenCopyWithImpl<$Res, Allergen>;
  @useResult
  $Res call({String name, String infoLink});
}

/// @nodoc
class _$AllergenCopyWithImpl<$Res, $Val extends Allergen>
    implements $AllergenCopyWith<$Res> {
  _$AllergenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? infoLink = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      infoLink: null == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AllergenCopyWith<$Res> implements $AllergenCopyWith<$Res> {
  factory _$$_AllergenCopyWith(
          _$_Allergen value, $Res Function(_$_Allergen) then) =
      __$$_AllergenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String infoLink});
}

/// @nodoc
class __$$_AllergenCopyWithImpl<$Res>
    extends _$AllergenCopyWithImpl<$Res, _$_Allergen>
    implements _$$_AllergenCopyWith<$Res> {
  __$$_AllergenCopyWithImpl(
      _$_Allergen _value, $Res Function(_$_Allergen) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? infoLink = null,
  }) {
    return _then(_$_Allergen(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      infoLink: null == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Allergen with DiagnosticableTreeMixin implements _Allergen {
  const _$_Allergen({required this.name, required this.infoLink});

  factory _$_Allergen.fromJson(Map<String, dynamic> json) =>
      _$$_AllergenFromJson(json);

  @override
  final String name;
  @override
  final String infoLink;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Allergen(name: $name, infoLink: $infoLink)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Allergen'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('infoLink', infoLink));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Allergen &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.infoLink, infoLink) ||
                other.infoLink == infoLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, infoLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AllergenCopyWith<_$_Allergen> get copyWith =>
      __$$_AllergenCopyWithImpl<_$_Allergen>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllergenToJson(
      this,
    );
  }
}

abstract class _Allergen implements Allergen {
  const factory _Allergen(
      {required final String name,
      required final String infoLink}) = _$_Allergen;

  factory _Allergen.fromJson(Map<String, dynamic> json) = _$_Allergen.fromJson;

  @override
  String get name;
  @override
  String get infoLink;
  @override
  @JsonKey(ignore: true)
  _$$_AllergenCopyWith<_$_Allergen> get copyWith =>
      throw _privateConstructorUsedError;
}

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return _Ingredient.fromJson(json);
}

/// @nodoc
mixin _$Ingredient {
  double get amount => throw _privateConstructorUsedError;
  String get measurement => throw _privateConstructorUsedError;
  String get svgIcon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IngredientCopyWith<Ingredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientCopyWith<$Res> {
  factory $IngredientCopyWith(
          Ingredient value, $Res Function(Ingredient) then) =
      _$IngredientCopyWithImpl<$Res, Ingredient>;
  @useResult
  $Res call({double amount, String measurement, String svgIcon, String name});
}

/// @nodoc
class _$IngredientCopyWithImpl<$Res, $Val extends Ingredient>
    implements $IngredientCopyWith<$Res> {
  _$IngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? measurement = null,
    Object? svgIcon = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      measurement: null == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String,
      svgIcon: null == svgIcon
          ? _value.svgIcon
          : svgIcon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IngredientCopyWith<$Res>
    implements $IngredientCopyWith<$Res> {
  factory _$$_IngredientCopyWith(
          _$_Ingredient value, $Res Function(_$_Ingredient) then) =
      __$$_IngredientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String measurement, String svgIcon, String name});
}

/// @nodoc
class __$$_IngredientCopyWithImpl<$Res>
    extends _$IngredientCopyWithImpl<$Res, _$_Ingredient>
    implements _$$_IngredientCopyWith<$Res> {
  __$$_IngredientCopyWithImpl(
      _$_Ingredient _value, $Res Function(_$_Ingredient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? measurement = null,
    Object? svgIcon = null,
    Object? name = null,
  }) {
    return _then(_$_Ingredient(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      measurement: null == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String,
      svgIcon: null == svgIcon
          ? _value.svgIcon
          : svgIcon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ingredient with DiagnosticableTreeMixin implements _Ingredient {
  const _$_Ingredient(
      {required this.amount,
      required this.measurement,
      required this.svgIcon,
      required this.name});

  factory _$_Ingredient.fromJson(Map<String, dynamic> json) =>
      _$$_IngredientFromJson(json);

  @override
  final double amount;
  @override
  final String measurement;
  @override
  final String svgIcon;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Ingredient(amount: $amount, measurement: $measurement, svgIcon: $svgIcon, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Ingredient'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('measurement', measurement))
      ..add(DiagnosticsProperty('svgIcon', svgIcon))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ingredient &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.measurement, measurement) ||
                other.measurement == measurement) &&
            (identical(other.svgIcon, svgIcon) || other.svgIcon == svgIcon) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, measurement, svgIcon, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IngredientCopyWith<_$_Ingredient> get copyWith =>
      __$$_IngredientCopyWithImpl<_$_Ingredient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IngredientToJson(
      this,
    );
  }
}

abstract class _Ingredient implements Ingredient {
  const factory _Ingredient(
      {required final double amount,
      required final String measurement,
      required final String svgIcon,
      required final String name}) = _$_Ingredient;

  factory _Ingredient.fromJson(Map<String, dynamic> json) =
      _$_Ingredient.fromJson;

  @override
  double get amount;
  @override
  String get measurement;
  @override
  String get svgIcon;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_IngredientCopyWith<_$_Ingredient> get copyWith =>
      throw _privateConstructorUsedError;
}

InstructionStep _$InstructionStepFromJson(Map<String, dynamic> json) {
  return _InstructionStep.fromJson(json);
}

/// @nodoc
mixin _$InstructionStep {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get preparationTimeMinute => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InstructionStepCopyWith<InstructionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstructionStepCopyWith<$Res> {
  factory $InstructionStepCopyWith(
          InstructionStep value, $Res Function(InstructionStep) then) =
      _$InstructionStepCopyWithImpl<$Res, InstructionStep>;
  @useResult
  $Res call(
      {String name,
      String description,
      int preparationTimeMinute,
      List<String> imageUrls});
}

/// @nodoc
class _$InstructionStepCopyWithImpl<$Res, $Val extends InstructionStep>
    implements $InstructionStepCopyWith<$Res> {
  _$InstructionStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? preparationTimeMinute = null,
    Object? imageUrls = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      preparationTimeMinute: null == preparationTimeMinute
          ? _value.preparationTimeMinute
          : preparationTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InstructionStepCopyWith<$Res>
    implements $InstructionStepCopyWith<$Res> {
  factory _$$_InstructionStepCopyWith(
          _$_InstructionStep value, $Res Function(_$_InstructionStep) then) =
      __$$_InstructionStepCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      int preparationTimeMinute,
      List<String> imageUrls});
}

/// @nodoc
class __$$_InstructionStepCopyWithImpl<$Res>
    extends _$InstructionStepCopyWithImpl<$Res, _$_InstructionStep>
    implements _$$_InstructionStepCopyWith<$Res> {
  __$$_InstructionStepCopyWithImpl(
      _$_InstructionStep _value, $Res Function(_$_InstructionStep) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? preparationTimeMinute = null,
    Object? imageUrls = null,
  }) {
    return _then(_$_InstructionStep(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      preparationTimeMinute: null == preparationTimeMinute
          ? _value.preparationTimeMinute
          : preparationTimeMinute // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InstructionStep
    with DiagnosticableTreeMixin
    implements _InstructionStep {
  const _$_InstructionStep(
      {required this.name,
      required this.description,
      required this.preparationTimeMinute,
      required final List<String> imageUrls})
      : _imageUrls = imageUrls;

  factory _$_InstructionStep.fromJson(Map<String, dynamic> json) =>
      _$$_InstructionStepFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final int preparationTimeMinute;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InstructionStep(name: $name, description: $description, preparationTimeMinute: $preparationTimeMinute, imageUrls: $imageUrls)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InstructionStep'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('preparationTimeMinute', preparationTimeMinute))
      ..add(DiagnosticsProperty('imageUrls', imageUrls));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InstructionStep &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.preparationTimeMinute, preparationTimeMinute) ||
                other.preparationTimeMinute == preparationTimeMinute) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      preparationTimeMinute, const DeepCollectionEquality().hash(_imageUrls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InstructionStepCopyWith<_$_InstructionStep> get copyWith =>
      __$$_InstructionStepCopyWithImpl<_$_InstructionStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InstructionStepToJson(
      this,
    );
  }
}

abstract class _InstructionStep implements InstructionStep {
  const factory _InstructionStep(
      {required final String name,
      required final String description,
      required final int preparationTimeMinute,
      required final List<String> imageUrls}) = _$_InstructionStep;

  factory _InstructionStep.fromJson(Map<String, dynamic> json) =
      _$_InstructionStep.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  int get preparationTimeMinute;
  @override
  List<String> get imageUrls;
  @override
  @JsonKey(ignore: true)
  _$$_InstructionStepCopyWith<_$_InstructionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatorSummary _$CreatorSummaryFromJson(Map<String, dynamic> json) {
  return _CreatorSummary.fromJson(json);
}

/// @nodoc
mixin _$CreatorSummary {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorSummaryCopyWith<CreatorSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorSummaryCopyWith<$Res> {
  factory $CreatorSummaryCopyWith(
          CreatorSummary value, $Res Function(CreatorSummary) then) =
      _$CreatorSummaryCopyWithImpl<$Res, CreatorSummary>;
  @useResult
  $Res call({String firstName, String lastName, String imageUrl});
}

/// @nodoc
class _$CreatorSummaryCopyWithImpl<$Res, $Val extends CreatorSummary>
    implements $CreatorSummaryCopyWith<$Res> {
  _$CreatorSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatorSummaryCopyWith<$Res>
    implements $CreatorSummaryCopyWith<$Res> {
  factory _$$_CreatorSummaryCopyWith(
          _$_CreatorSummary value, $Res Function(_$_CreatorSummary) then) =
      __$$_CreatorSummaryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String firstName, String lastName, String imageUrl});
}

/// @nodoc
class __$$_CreatorSummaryCopyWithImpl<$Res>
    extends _$CreatorSummaryCopyWithImpl<$Res, _$_CreatorSummary>
    implements _$$_CreatorSummaryCopyWith<$Res> {
  __$$_CreatorSummaryCopyWithImpl(
      _$_CreatorSummary _value, $Res Function(_$_CreatorSummary) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_CreatorSummary(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatorSummary
    with DiagnosticableTreeMixin
    implements _CreatorSummary {
  const _$_CreatorSummary(
      {required this.firstName,
      required this.lastName,
      required this.imageUrl});

  factory _$_CreatorSummary.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorSummaryFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreatorSummary(firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreatorSummary'))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatorSummary &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatorSummaryCopyWith<_$_CreatorSummary> get copyWith =>
      __$$_CreatorSummaryCopyWithImpl<_$_CreatorSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorSummaryToJson(
      this,
    );
  }
}

abstract class _CreatorSummary implements CreatorSummary {
  const factory _CreatorSummary(
      {required final String firstName,
      required final String lastName,
      required final String imageUrl}) = _$_CreatorSummary;

  factory _CreatorSummary.fromJson(Map<String, dynamic> json) =
      _$_CreatorSummary.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorSummaryCopyWith<_$_CreatorSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

Origin _$OriginFromJson(Map<String, dynamic> json) {
  return _Origin.fromJson(json);
}

/// @nodoc
mixin _$Origin {
  String get code => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OriginCopyWith<Origin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OriginCopyWith<$Res> {
  factory $OriginCopyWith(Origin value, $Res Function(Origin) then) =
      _$OriginCopyWithImpl<$Res, Origin>;
  @useResult
  $Res call(
      {String code, String country, String state, String city, String title});
}

/// @nodoc
class _$OriginCopyWithImpl<$Res, $Val extends Origin>
    implements $OriginCopyWith<$Res> {
  _$OriginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? country = null,
    Object? state = null,
    Object? city = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OriginCopyWith<$Res> implements $OriginCopyWith<$Res> {
  factory _$$_OriginCopyWith(_$_Origin value, $Res Function(_$_Origin) then) =
      __$$_OriginCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code, String country, String state, String city, String title});
}

/// @nodoc
class __$$_OriginCopyWithImpl<$Res>
    extends _$OriginCopyWithImpl<$Res, _$_Origin>
    implements _$$_OriginCopyWith<$Res> {
  __$$_OriginCopyWithImpl(_$_Origin _value, $Res Function(_$_Origin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? country = null,
    Object? state = null,
    Object? city = null,
    Object? title = null,
  }) {
    return _then(_$_Origin(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Origin with DiagnosticableTreeMixin implements _Origin {
  const _$_Origin(
      {required this.code,
      required this.country,
      required this.state,
      required this.city,
      required this.title});

  factory _$_Origin.fromJson(Map<String, dynamic> json) =>
      _$$_OriginFromJson(json);

  @override
  final String code;
  @override
  final String country;
  @override
  final String state;
  @override
  final String city;
  @override
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Origin(code: $code, country: $country, state: $state, city: $city, title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Origin'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('title', title));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Origin &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, country, state, city, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OriginCopyWith<_$_Origin> get copyWith =>
      __$$_OriginCopyWithImpl<_$_Origin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OriginToJson(
      this,
    );
  }
}

abstract class _Origin implements Origin {
  const factory _Origin(
      {required final String code,
      required final String country,
      required final String state,
      required final String city,
      required final String title}) = _$_Origin;

  factory _Origin.fromJson(Map<String, dynamic> json) = _$_Origin.fromJson;

  @override
  String get code;
  @override
  String get country;
  @override
  String get state;
  @override
  String get city;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_OriginCopyWith<_$_Origin> get copyWith =>
      throw _privateConstructorUsedError;
}
