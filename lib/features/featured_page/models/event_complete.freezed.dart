// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_complete.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtModel _$ArtModelFromJson(Map<String, dynamic> json) {
  return _ArtModel.fromJson(json);
}

/// @nodoc
mixin _$ArtModel {
  String get id => throw _privateConstructorUsedError;
  String get artType => throw _privateConstructorUsedError;
  List<ArtistModel> get artists => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ImageModel> get images => throw _privateConstructorUsedError;
  LocationModel get location => throw _privateConstructorUsedError;
  List<String> get material => throw _privateConstructorUsedError;
  int get originalId => throw _privateConstructorUsedError;
  String get originalUrl => throw _privateConstructorUsedError;
  String get ownership => throw _privateConstructorUsedError;
  SourceModel get source => throw _privateConstructorUsedError;
  String get statement => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtModelCopyWith<ArtModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtModelCopyWith<$Res> {
  factory $ArtModelCopyWith(ArtModel value, $Res Function(ArtModel) then) =
      _$ArtModelCopyWithImpl<$Res, ArtModel>;
  @useResult
  $Res call(
      {String id,
      String artType,
      List<ArtistModel> artists,
      String description,
      List<ImageModel> images,
      LocationModel location,
      List<String> material,
      int originalId,
      String originalUrl,
      String ownership,
      SourceModel source,
      String statement,
      List<String> tags,
      String title});

  $LocationModelCopyWith<$Res> get location;
  $SourceModelCopyWith<$Res> get source;
}

/// @nodoc
class _$ArtModelCopyWithImpl<$Res, $Val extends ArtModel>
    implements $ArtModelCopyWith<$Res> {
  _$ArtModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artType = null,
    Object? artists = null,
    Object? description = null,
    Object? images = null,
    Object? location = null,
    Object? material = null,
    Object? originalId = null,
    Object? originalUrl = null,
    Object? ownership = null,
    Object? source = null,
    Object? statement = null,
    Object? tags = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artType: null == artType
          ? _value.artType
          : artType // ignore: cast_nullable_to_non_nullable
              as String,
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<ArtistModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalId: null == originalId
          ? _value.originalId
          : originalId // ignore: cast_nullable_to_non_nullable
              as int,
      originalUrl: null == originalUrl
          ? _value.originalUrl
          : originalUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownership: null == ownership
          ? _value.ownership
          : ownership // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceModel,
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get location {
    return $LocationModelCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SourceModelCopyWith<$Res> get source {
    return $SourceModelCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ArtModelCopyWith<$Res> implements $ArtModelCopyWith<$Res> {
  factory _$$_ArtModelCopyWith(
          _$_ArtModel value, $Res Function(_$_ArtModel) then) =
      __$$_ArtModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String artType,
      List<ArtistModel> artists,
      String description,
      List<ImageModel> images,
      LocationModel location,
      List<String> material,
      int originalId,
      String originalUrl,
      String ownership,
      SourceModel source,
      String statement,
      List<String> tags,
      String title});

  @override
  $LocationModelCopyWith<$Res> get location;
  @override
  $SourceModelCopyWith<$Res> get source;
}

/// @nodoc
class __$$_ArtModelCopyWithImpl<$Res>
    extends _$ArtModelCopyWithImpl<$Res, _$_ArtModel>
    implements _$$_ArtModelCopyWith<$Res> {
  __$$_ArtModelCopyWithImpl(
      _$_ArtModel _value, $Res Function(_$_ArtModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artType = null,
    Object? artists = null,
    Object? description = null,
    Object? images = null,
    Object? location = null,
    Object? material = null,
    Object? originalId = null,
    Object? originalUrl = null,
    Object? ownership = null,
    Object? source = null,
    Object? statement = null,
    Object? tags = null,
    Object? title = null,
  }) {
    return _then(_$_ArtModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artType: null == artType
          ? _value.artType
          : artType // ignore: cast_nullable_to_non_nullable
              as String,
      artists: null == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<ArtistModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      material: null == material
          ? _value._material
          : material // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalId: null == originalId
          ? _value.originalId
          : originalId // ignore: cast_nullable_to_non_nullable
              as int,
      originalUrl: null == originalUrl
          ? _value.originalUrl
          : originalUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownership: null == ownership
          ? _value.ownership
          : ownership // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceModel,
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtModel implements _ArtModel {
  const _$_ArtModel(
      {required this.id,
      required this.artType,
      required final List<ArtistModel> artists,
      required this.description,
      required final List<ImageModel> images,
      required this.location,
      required final List<String> material,
      required this.originalId,
      required this.originalUrl,
      required this.ownership,
      required this.source,
      required this.statement,
      required final List<String> tags,
      required this.title})
      : _artists = artists,
        _images = images,
        _material = material,
        _tags = tags;

  factory _$_ArtModel.fromJson(Map<String, dynamic> json) =>
      _$$_ArtModelFromJson(json);

  @override
  final String id;
  @override
  final String artType;
  final List<ArtistModel> _artists;
  @override
  List<ArtistModel> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  @override
  final String description;
  final List<ImageModel> _images;
  @override
  List<ImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final LocationModel location;
  final List<String> _material;
  @override
  List<String> get material {
    if (_material is EqualUnmodifiableListView) return _material;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_material);
  }

  @override
  final int originalId;
  @override
  final String originalUrl;
  @override
  final String ownership;
  @override
  final SourceModel source;
  @override
  final String statement;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String title;

  @override
  String toString() {
    return 'ArtModel(id: $id, artType: $artType, artists: $artists, description: $description, images: $images, location: $location, material: $material, originalId: $originalId, originalUrl: $originalUrl, ownership: $ownership, source: $source, statement: $statement, tags: $tags, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArtModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.artType, artType) || other.artType == artType) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._material, _material) &&
            (identical(other.originalId, originalId) ||
                other.originalId == originalId) &&
            (identical(other.originalUrl, originalUrl) ||
                other.originalUrl == originalUrl) &&
            (identical(other.ownership, ownership) ||
                other.ownership == ownership) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      artType,
      const DeepCollectionEquality().hash(_artists),
      description,
      const DeepCollectionEquality().hash(_images),
      location,
      const DeepCollectionEquality().hash(_material),
      originalId,
      originalUrl,
      ownership,
      source,
      statement,
      const DeepCollectionEquality().hash(_tags),
      title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArtModelCopyWith<_$_ArtModel> get copyWith =>
      __$$_ArtModelCopyWithImpl<_$_ArtModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtModelToJson(
      this,
    );
  }
}

abstract class _ArtModel implements ArtModel {
  const factory _ArtModel(
      {required final String id,
      required final String artType,
      required final List<ArtistModel> artists,
      required final String description,
      required final List<ImageModel> images,
      required final LocationModel location,
      required final List<String> material,
      required final int originalId,
      required final String originalUrl,
      required final String ownership,
      required final SourceModel source,
      required final String statement,
      required final List<String> tags,
      required final String title}) = _$_ArtModel;

  factory _ArtModel.fromJson(Map<String, dynamic> json) = _$_ArtModel.fromJson;

  @override
  String get id;
  @override
  String get artType;
  @override
  List<ArtistModel> get artists;
  @override
  String get description;
  @override
  List<ImageModel> get images;
  @override
  LocationModel get location;
  @override
  List<String> get material;
  @override
  int get originalId;
  @override
  String get originalUrl;
  @override
  String get ownership;
  @override
  SourceModel get source;
  @override
  String get statement;
  @override
  List<String> get tags;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_ArtModelCopyWith<_$_ArtModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) {
  return _ArtistModel.fromJson(json);
}

/// @nodoc
mixin _$ArtistModel {
  String get typename => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get biography => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  List<ImageModel> get images => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get originalId => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtistModelCopyWith<ArtistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistModelCopyWith<$Res> {
  factory $ArtistModelCopyWith(
          ArtistModel value, $Res Function(ArtistModel) then) =
      _$ArtistModelCopyWithImpl<$Res, ArtistModel>;
  @useResult
  $Res call(
      {String typename,
      String id,
      String biography,
      String country,
      List<ImageModel> images,
      String name,
      int originalId,
      String website});
}

/// @nodoc
class _$ArtistModelCopyWithImpl<$Res, $Val extends ArtistModel>
    implements $ArtistModelCopyWith<$Res> {
  _$ArtistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? biography = null,
    Object? country = null,
    Object? images = null,
    Object? name = null,
    Object? originalId = null,
    Object? website = null,
  }) {
    return _then(_value.copyWith(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      biography: null == biography
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalId: null == originalId
          ? _value.originalId
          : originalId // ignore: cast_nullable_to_non_nullable
              as int,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArtistModelCopyWith<$Res>
    implements $ArtistModelCopyWith<$Res> {
  factory _$$_ArtistModelCopyWith(
          _$_ArtistModel value, $Res Function(_$_ArtistModel) then) =
      __$$_ArtistModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String typename,
      String id,
      String biography,
      String country,
      List<ImageModel> images,
      String name,
      int originalId,
      String website});
}

/// @nodoc
class __$$_ArtistModelCopyWithImpl<$Res>
    extends _$ArtistModelCopyWithImpl<$Res, _$_ArtistModel>
    implements _$$_ArtistModelCopyWith<$Res> {
  __$$_ArtistModelCopyWithImpl(
      _$_ArtistModel _value, $Res Function(_$_ArtistModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? biography = null,
    Object? country = null,
    Object? images = null,
    Object? name = null,
    Object? originalId = null,
    Object? website = null,
  }) {
    return _then(_$_ArtistModel(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      biography: null == biography
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalId: null == originalId
          ? _value.originalId
          : originalId // ignore: cast_nullable_to_non_nullable
              as int,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtistModel implements _ArtistModel {
  const _$_ArtistModel(
      {required this.typename,
      required this.id,
      required this.biography,
      required this.country,
      required final List<ImageModel> images,
      required this.name,
      required this.originalId,
      required this.website})
      : _images = images;

  factory _$_ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$$_ArtistModelFromJson(json);

  @override
  final String typename;
  @override
  final String id;
  @override
  final String biography;
  @override
  final String country;
  final List<ImageModel> _images;
  @override
  List<ImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String name;
  @override
  final int originalId;
  @override
  final String website;

  @override
  String toString() {
    return 'ArtistModel(typename: $typename, id: $id, biography: $biography, country: $country, images: $images, name: $name, originalId: $originalId, website: $website)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArtistModel &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalId, originalId) ||
                other.originalId == originalId) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, typename, id, biography, country,
      const DeepCollectionEquality().hash(_images), name, originalId, website);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArtistModelCopyWith<_$_ArtistModel> get copyWith =>
      __$$_ArtistModelCopyWithImpl<_$_ArtistModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtistModelToJson(
      this,
    );
  }
}

abstract class _ArtistModel implements ArtistModel {
  const factory _ArtistModel(
      {required final String typename,
      required final String id,
      required final String biography,
      required final String country,
      required final List<ImageModel> images,
      required final String name,
      required final int originalId,
      required final String website}) = _$_ArtistModel;

  factory _ArtistModel.fromJson(Map<String, dynamic> json) =
      _$_ArtistModel.fromJson;

  @override
  String get typename;
  @override
  String get id;
  @override
  String get biography;
  @override
  String get country;
  @override
  List<ImageModel> get images;
  @override
  String get name;
  @override
  int get originalId;
  @override
  String get website;
  @override
  @JsonKey(ignore: true)
  _$$_ArtistModelCopyWith<_$_ArtistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return _ImageModel.fromJson(json);
}

/// @nodoc
mixin _$ImageModel {
  String get typename => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get imageCredit => throw _privateConstructorUsedError;
  String get imageData => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageModelCopyWith<ImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageModelCopyWith<$Res> {
  factory $ImageModelCopyWith(
          ImageModel value, $Res Function(ImageModel) then) =
      _$ImageModelCopyWithImpl<$Res, ImageModel>;
  @useResult
  $Res call(
      {String typename,
      String id,
      String imageCredit,
      String imageData,
      String imageUrl});
}

/// @nodoc
class _$ImageModelCopyWithImpl<$Res, $Val extends ImageModel>
    implements $ImageModelCopyWith<$Res> {
  _$ImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? imageCredit = null,
    Object? imageData = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageCredit: null == imageCredit
          ? _value.imageCredit
          : imageCredit // ignore: cast_nullable_to_non_nullable
              as String,
      imageData: null == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageModelCopyWith<$Res>
    implements $ImageModelCopyWith<$Res> {
  factory _$$_ImageModelCopyWith(
          _$_ImageModel value, $Res Function(_$_ImageModel) then) =
      __$$_ImageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String typename,
      String id,
      String imageCredit,
      String imageData,
      String imageUrl});
}

/// @nodoc
class __$$_ImageModelCopyWithImpl<$Res>
    extends _$ImageModelCopyWithImpl<$Res, _$_ImageModel>
    implements _$$_ImageModelCopyWith<$Res> {
  __$$_ImageModelCopyWithImpl(
      _$_ImageModel _value, $Res Function(_$_ImageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? imageCredit = null,
    Object? imageData = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_ImageModel(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageCredit: null == imageCredit
          ? _value.imageCredit
          : imageCredit // ignore: cast_nullable_to_non_nullable
              as String,
      imageData: null == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
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
class _$_ImageModel implements _ImageModel {
  const _$_ImageModel(
      {required this.typename,
      required this.id,
      required this.imageCredit,
      required this.imageData,
      required this.imageUrl});

  factory _$_ImageModel.fromJson(Map<String, dynamic> json) =>
      _$$_ImageModelFromJson(json);

  @override
  final String typename;
  @override
  final String id;
  @override
  final String imageCredit;
  @override
  final String imageData;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'ImageModel(typename: $typename, id: $id, imageCredit: $imageCredit, imageData: $imageData, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageModel &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageCredit, imageCredit) ||
                other.imageCredit == imageCredit) &&
            (identical(other.imageData, imageData) ||
                other.imageData == imageData) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, typename, id, imageCredit, imageData, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageModelCopyWith<_$_ImageModel> get copyWith =>
      __$$_ImageModelCopyWithImpl<_$_ImageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageModelToJson(
      this,
    );
  }
}

abstract class _ImageModel implements ImageModel {
  const factory _ImageModel(
      {required final String typename,
      required final String id,
      required final String imageCredit,
      required final String imageData,
      required final String imageUrl}) = _$_ImageModel;

  factory _ImageModel.fromJson(Map<String, dynamic> json) =
      _$_ImageModel.fromJson;

  @override
  String get typename;
  @override
  String get id;
  @override
  String get imageCredit;
  @override
  String get imageData;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ImageModelCopyWith<_$_ImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return _LocationModel.fromJson(json);
}

/// @nodoc
mixin _$LocationModel {
  GeolocationModel get geolocation => throw _privateConstructorUsedError;
  VenueModel get venue => throw _privateConstructorUsedError;
  LatLng get latLng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationModelCopyWith<LocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModelCopyWith<$Res> {
  factory $LocationModelCopyWith(
          LocationModel value, $Res Function(LocationModel) then) =
      _$LocationModelCopyWithImpl<$Res, LocationModel>;
  @useResult
  $Res call({GeolocationModel geolocation, VenueModel venue, LatLng latLng});

  $GeolocationModelCopyWith<$Res> get geolocation;
  $VenueModelCopyWith<$Res> get venue;
}

/// @nodoc
class _$LocationModelCopyWithImpl<$Res, $Val extends LocationModel>
    implements $LocationModelCopyWith<$Res> {
  _$LocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geolocation = null,
    Object? venue = null,
    Object? latLng = null,
  }) {
    return _then(_value.copyWith(
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as GeolocationModel,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as VenueModel,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeolocationModelCopyWith<$Res> get geolocation {
    return $GeolocationModelCopyWith<$Res>(_value.geolocation, (value) {
      return _then(_value.copyWith(geolocation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VenueModelCopyWith<$Res> get venue {
    return $VenueModelCopyWith<$Res>(_value.venue, (value) {
      return _then(_value.copyWith(venue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LocationModelCopyWith<$Res>
    implements $LocationModelCopyWith<$Res> {
  factory _$$_LocationModelCopyWith(
          _$_LocationModel value, $Res Function(_$_LocationModel) then) =
      __$$_LocationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GeolocationModel geolocation, VenueModel venue, LatLng latLng});

  @override
  $GeolocationModelCopyWith<$Res> get geolocation;
  @override
  $VenueModelCopyWith<$Res> get venue;
}

/// @nodoc
class __$$_LocationModelCopyWithImpl<$Res>
    extends _$LocationModelCopyWithImpl<$Res, _$_LocationModel>
    implements _$$_LocationModelCopyWith<$Res> {
  __$$_LocationModelCopyWithImpl(
      _$_LocationModel _value, $Res Function(_$_LocationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geolocation = null,
    Object? venue = null,
    Object? latLng = null,
  }) {
    return _then(_$_LocationModel(
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as GeolocationModel,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as VenueModel,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationModel implements _LocationModel {
  const _$_LocationModel(
      {required this.geolocation, required this.venue, required this.latLng});

  factory _$_LocationModel.fromJson(Map<String, dynamic> json) =>
      _$$_LocationModelFromJson(json);

  @override
  final GeolocationModel geolocation;
  @override
  final VenueModel venue;
  @override
  final LatLng latLng;

  @override
  String toString() {
    return 'LocationModel(geolocation: $geolocation, venue: $venue, latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationModel &&
            (identical(other.geolocation, geolocation) ||
                other.geolocation == geolocation) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.latLng, latLng) || other.latLng == latLng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, geolocation, venue, latLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationModelCopyWith<_$_LocationModel> get copyWith =>
      __$$_LocationModelCopyWithImpl<_$_LocationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationModelToJson(
      this,
    );
  }
}

abstract class _LocationModel implements LocationModel {
  const factory _LocationModel(
      {required final GeolocationModel geolocation,
      required final VenueModel venue,
      required final LatLng latLng}) = _$_LocationModel;

  factory _LocationModel.fromJson(Map<String, dynamic> json) =
      _$_LocationModel.fromJson;

  @override
  GeolocationModel get geolocation;
  @override
  VenueModel get venue;
  @override
  LatLng get latLng;
  @override
  @JsonKey(ignore: true)
  _$$_LocationModelCopyWith<_$_LocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

GeolocationModel _$GeolocationModelFromJson(Map<String, dynamic> json) {
  return _GeolocationModel.fromJson(json);
}

/// @nodoc
mixin _$GeolocationModel {
  String get typename => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeolocationModelCopyWith<GeolocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeolocationModelCopyWith<$Res> {
  factory $GeolocationModelCopyWith(
          GeolocationModel value, $Res Function(GeolocationModel) then) =
      _$GeolocationModelCopyWithImpl<$Res, GeolocationModel>;
  @useResult
  $Res call({String typename, List<double> coordinates, String type});
}

/// @nodoc
class _$GeolocationModelCopyWithImpl<$Res, $Val extends GeolocationModel>
    implements $GeolocationModelCopyWith<$Res> {
  _$GeolocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? coordinates = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GeolocationModelCopyWith<$Res>
    implements $GeolocationModelCopyWith<$Res> {
  factory _$$_GeolocationModelCopyWith(
          _$_GeolocationModel value, $Res Function(_$_GeolocationModel) then) =
      __$$_GeolocationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String typename, List<double> coordinates, String type});
}

/// @nodoc
class __$$_GeolocationModelCopyWithImpl<$Res>
    extends _$GeolocationModelCopyWithImpl<$Res, _$_GeolocationModel>
    implements _$$_GeolocationModelCopyWith<$Res> {
  __$$_GeolocationModelCopyWithImpl(
      _$_GeolocationModel _value, $Res Function(_$_GeolocationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? coordinates = null,
    Object? type = null,
  }) {
    return _then(_$_GeolocationModel(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeolocationModel implements _GeolocationModel {
  const _$_GeolocationModel(
      {required this.typename,
      required final List<double> coordinates,
      required this.type})
      : _coordinates = coordinates;

  factory _$_GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$$_GeolocationModelFromJson(json);

  @override
  final String typename;
  final List<double> _coordinates;
  @override
  List<double> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  final String type;

  @override
  String toString() {
    return 'GeolocationModel(typename: $typename, coordinates: $coordinates, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeolocationModel &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, typename,
      const DeepCollectionEquality().hash(_coordinates), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GeolocationModelCopyWith<_$_GeolocationModel> get copyWith =>
      __$$_GeolocationModelCopyWithImpl<_$_GeolocationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeolocationModelToJson(
      this,
    );
  }
}

abstract class _GeolocationModel implements GeolocationModel {
  const factory _GeolocationModel(
      {required final String typename,
      required final List<double> coordinates,
      required final String type}) = _$_GeolocationModel;

  factory _GeolocationModel.fromJson(Map<String, dynamic> json) =
      _$_GeolocationModel.fromJson;

  @override
  String get typename;
  @override
  List<double> get coordinates;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_GeolocationModelCopyWith<_$_GeolocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

VenueModel _$VenueModelFromJson(Map<String, dynamic> json) {
  return _VenueModel.fromJson(json);
}

/// @nodoc
mixin _$VenueModel {
  String get typename => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  AddressModel get address => throw _privateConstructorUsedError;
  GeolocationModel get geolocation => throw _privateConstructorUsedError;
  int get osmId => throw _privateConstructorUsedError;
  String get osmLicence => throw _privateConstructorUsedError;
  int get osmVenueId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VenueModelCopyWith<VenueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenueModelCopyWith<$Res> {
  factory $VenueModelCopyWith(
          VenueModel value, $Res Function(VenueModel) then) =
      _$VenueModelCopyWithImpl<$Res, VenueModel>;
  @useResult
  $Res call(
      {String typename,
      String id,
      AddressModel address,
      GeolocationModel geolocation,
      int osmId,
      String osmLicence,
      int osmVenueId,
      String title});

  $AddressModelCopyWith<$Res> get address;
  $GeolocationModelCopyWith<$Res> get geolocation;
}

/// @nodoc
class _$VenueModelCopyWithImpl<$Res, $Val extends VenueModel>
    implements $VenueModelCopyWith<$Res> {
  _$VenueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? address = null,
    Object? geolocation = null,
    Object? osmId = null,
    Object? osmLicence = null,
    Object? osmVenueId = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as GeolocationModel,
      osmId: null == osmId
          ? _value.osmId
          : osmId // ignore: cast_nullable_to_non_nullable
              as int,
      osmLicence: null == osmLicence
          ? _value.osmLicence
          : osmLicence // ignore: cast_nullable_to_non_nullable
              as String,
      osmVenueId: null == osmVenueId
          ? _value.osmVenueId
          : osmVenueId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res> get address {
    return $AddressModelCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GeolocationModelCopyWith<$Res> get geolocation {
    return $GeolocationModelCopyWith<$Res>(_value.geolocation, (value) {
      return _then(_value.copyWith(geolocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_VenueModelCopyWith<$Res>
    implements $VenueModelCopyWith<$Res> {
  factory _$$_VenueModelCopyWith(
          _$_VenueModel value, $Res Function(_$_VenueModel) then) =
      __$$_VenueModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String typename,
      String id,
      AddressModel address,
      GeolocationModel geolocation,
      int osmId,
      String osmLicence,
      int osmVenueId,
      String title});

  @override
  $AddressModelCopyWith<$Res> get address;
  @override
  $GeolocationModelCopyWith<$Res> get geolocation;
}

/// @nodoc
class __$$_VenueModelCopyWithImpl<$Res>
    extends _$VenueModelCopyWithImpl<$Res, _$_VenueModel>
    implements _$$_VenueModelCopyWith<$Res> {
  __$$_VenueModelCopyWithImpl(
      _$_VenueModel _value, $Res Function(_$_VenueModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typename = null,
    Object? id = null,
    Object? address = null,
    Object? geolocation = null,
    Object? osmId = null,
    Object? osmLicence = null,
    Object? osmVenueId = null,
    Object? title = null,
  }) {
    return _then(_$_VenueModel(
      typename: null == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel,
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as GeolocationModel,
      osmId: null == osmId
          ? _value.osmId
          : osmId // ignore: cast_nullable_to_non_nullable
              as int,
      osmLicence: null == osmLicence
          ? _value.osmLicence
          : osmLicence // ignore: cast_nullable_to_non_nullable
              as String,
      osmVenueId: null == osmVenueId
          ? _value.osmVenueId
          : osmVenueId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VenueModel implements _VenueModel {
  const _$_VenueModel(
      {required this.typename,
      required this.id,
      required this.address,
      required this.geolocation,
      required this.osmId,
      required this.osmLicence,
      required this.osmVenueId,
      required this.title});

  factory _$_VenueModel.fromJson(Map<String, dynamic> json) =>
      _$$_VenueModelFromJson(json);

  @override
  final String typename;
  @override
  final String id;
  @override
  final AddressModel address;
  @override
  final GeolocationModel geolocation;
  @override
  final int osmId;
  @override
  final String osmLicence;
  @override
  final int osmVenueId;
  @override
  final String title;

  @override
  String toString() {
    return 'VenueModel(typename: $typename, id: $id, address: $address, geolocation: $geolocation, osmId: $osmId, osmLicence: $osmLicence, osmVenueId: $osmVenueId, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VenueModel &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.geolocation, geolocation) ||
                other.geolocation == geolocation) &&
            (identical(other.osmId, osmId) || other.osmId == osmId) &&
            (identical(other.osmLicence, osmLicence) ||
                other.osmLicence == osmLicence) &&
            (identical(other.osmVenueId, osmVenueId) ||
                other.osmVenueId == osmVenueId) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, typename, id, address,
      geolocation, osmId, osmLicence, osmVenueId, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VenueModelCopyWith<_$_VenueModel> get copyWith =>
      __$$_VenueModelCopyWithImpl<_$_VenueModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VenueModelToJson(
      this,
    );
  }
}

abstract class _VenueModel implements VenueModel {
  const factory _VenueModel(
      {required final String typename,
      required final String id,
      required final AddressModel address,
      required final GeolocationModel geolocation,
      required final int osmId,
      required final String osmLicence,
      required final int osmVenueId,
      required final String title}) = _$_VenueModel;

  factory _VenueModel.fromJson(Map<String, dynamic> json) =
      _$_VenueModel.fromJson;

  @override
  String get typename;
  @override
  String get id;
  @override
  AddressModel get address;
  @override
  GeolocationModel get geolocation;
  @override
  int get osmId;
  @override
  String get osmLicence;
  @override
  int get osmVenueId;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_VenueModelCopyWith<_$_VenueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  String get area => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  String get localizedAddressDisplay => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call(
      {String area,
      String city,
      String country,
      double latitude,
      String localizedAddressDisplay,
      double longitude,
      String postalCode,
      String region});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? city = null,
    Object? country = null,
    Object? latitude = null,
    Object? localizedAddressDisplay = null,
    Object? longitude = null,
    Object? postalCode = null,
    Object? region = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      localizedAddressDisplay: null == localizedAddressDisplay
          ? _value.localizedAddressDisplay
          : localizedAddressDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressModelCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$_AddressModelCopyWith(
          _$_AddressModel value, $Res Function(_$_AddressModel) then) =
      __$$_AddressModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String area,
      String city,
      String country,
      double latitude,
      String localizedAddressDisplay,
      double longitude,
      String postalCode,
      String region});
}

/// @nodoc
class __$$_AddressModelCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$_AddressModel>
    implements _$$_AddressModelCopyWith<$Res> {
  __$$_AddressModelCopyWithImpl(
      _$_AddressModel _value, $Res Function(_$_AddressModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? city = null,
    Object? country = null,
    Object? latitude = null,
    Object? localizedAddressDisplay = null,
    Object? longitude = null,
    Object? postalCode = null,
    Object? region = null,
  }) {
    return _then(_$_AddressModel(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      localizedAddressDisplay: null == localizedAddressDisplay
          ? _value.localizedAddressDisplay
          : localizedAddressDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddressModel implements _AddressModel {
  const _$_AddressModel(
      {required this.area,
      required this.city,
      required this.country,
      required this.latitude,
      required this.localizedAddressDisplay,
      required this.longitude,
      required this.postalCode,
      required this.region});

  factory _$_AddressModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddressModelFromJson(json);

  @override
  final String area;
  @override
  final String city;
  @override
  final String country;
  @override
  final double latitude;
  @override
  final String localizedAddressDisplay;
  @override
  final double longitude;
  @override
  final String postalCode;
  @override
  final String region;

  @override
  String toString() {
    return 'AddressModel(area: $area, city: $city, country: $country, latitude: $latitude, localizedAddressDisplay: $localizedAddressDisplay, longitude: $longitude, postalCode: $postalCode, region: $region)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressModel &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(
                    other.localizedAddressDisplay, localizedAddressDisplay) ||
                other.localizedAddressDisplay == localizedAddressDisplay) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.region, region) || other.region == region));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, city, country, latitude,
      localizedAddressDisplay, longitude, postalCode, region);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressModelCopyWith<_$_AddressModel> get copyWith =>
      __$$_AddressModelCopyWithImpl<_$_AddressModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressModelToJson(
      this,
    );
  }
}

abstract class _AddressModel implements AddressModel {
  const factory _AddressModel(
      {required final String area,
      required final String city,
      required final String country,
      required final double latitude,
      required final String localizedAddressDisplay,
      required final double longitude,
      required final String postalCode,
      required final String region}) = _$_AddressModel;

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$_AddressModel.fromJson;

  @override
  String get area;
  @override
  String get city;
  @override
  String get country;
  @override
  double get latitude;
  @override
  String get localizedAddressDisplay;
  @override
  double get longitude;
  @override
  String get postalCode;
  @override
  String get region;
  @override
  @JsonKey(ignore: true)
  _$$_AddressModelCopyWith<_$_AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) {
  return _SourceModel.fromJson(json);
}

/// @nodoc
mixin _$SourceModel {
  String get id => throw _privateConstructorUsedError;
  String get copyRight => throw _privateConstructorUsedError;
  String get dataUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceModelCopyWith<SourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceModelCopyWith<$Res> {
  factory $SourceModelCopyWith(
          SourceModel value, $Res Function(SourceModel) then) =
      _$SourceModelCopyWithImpl<$Res, SourceModel>;
  @useResult
  $Res call({String id, String copyRight, String dataUrl, String name});
}

/// @nodoc
class _$SourceModelCopyWithImpl<$Res, $Val extends SourceModel>
    implements $SourceModelCopyWith<$Res> {
  _$SourceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? copyRight = null,
    Object? dataUrl = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      copyRight: null == copyRight
          ? _value.copyRight
          : copyRight // ignore: cast_nullable_to_non_nullable
              as String,
      dataUrl: null == dataUrl
          ? _value.dataUrl
          : dataUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SourceModelCopyWith<$Res>
    implements $SourceModelCopyWith<$Res> {
  factory _$$_SourceModelCopyWith(
          _$_SourceModel value, $Res Function(_$_SourceModel) then) =
      __$$_SourceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String copyRight, String dataUrl, String name});
}

/// @nodoc
class __$$_SourceModelCopyWithImpl<$Res>
    extends _$SourceModelCopyWithImpl<$Res, _$_SourceModel>
    implements _$$_SourceModelCopyWith<$Res> {
  __$$_SourceModelCopyWithImpl(
      _$_SourceModel _value, $Res Function(_$_SourceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? copyRight = null,
    Object? dataUrl = null,
    Object? name = null,
  }) {
    return _then(_$_SourceModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      copyRight: null == copyRight
          ? _value.copyRight
          : copyRight // ignore: cast_nullable_to_non_nullable
              as String,
      dataUrl: null == dataUrl
          ? _value.dataUrl
          : dataUrl // ignore: cast_nullable_to_non_nullable
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
class _$_SourceModel implements _SourceModel {
  const _$_SourceModel(
      {required this.id,
      required this.copyRight,
      required this.dataUrl,
      required this.name});

  factory _$_SourceModel.fromJson(Map<String, dynamic> json) =>
      _$$_SourceModelFromJson(json);

  @override
  final String id;
  @override
  final String copyRight;
  @override
  final String dataUrl;
  @override
  final String name;

  @override
  String toString() {
    return 'SourceModel(id: $id, copyRight: $copyRight, dataUrl: $dataUrl, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SourceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.copyRight, copyRight) ||
                other.copyRight == copyRight) &&
            (identical(other.dataUrl, dataUrl) || other.dataUrl == dataUrl) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, copyRight, dataUrl, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SourceModelCopyWith<_$_SourceModel> get copyWith =>
      __$$_SourceModelCopyWithImpl<_$_SourceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SourceModelToJson(
      this,
    );
  }
}

abstract class _SourceModel implements SourceModel {
  const factory _SourceModel(
      {required final String id,
      required final String copyRight,
      required final String dataUrl,
      required final String name}) = _$_SourceModel;

  factory _SourceModel.fromJson(Map<String, dynamic> json) =
      _$_SourceModel.fromJson;

  @override
  String get id;
  @override
  String get copyRight;
  @override
  String get dataUrl;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_SourceModelCopyWith<_$_SourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
