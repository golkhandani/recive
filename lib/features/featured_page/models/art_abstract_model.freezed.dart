// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_abstract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtAbstractModel _$ArtAbstractModelFromJson(Map<String, dynamic> json) {
  return _ArtAbstractModel.fromJson(json);
}

/// @nodoc
mixin _$ArtAbstractModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  LatLng get geoLocation => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtAbstractModelCopyWith<ArtAbstractModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtAbstractModelCopyWith<$Res> {
  factory $ArtAbstractModelCopyWith(
          ArtAbstractModel value, $Res Function(ArtAbstractModel) then) =
      _$ArtAbstractModelCopyWithImpl<$Res, ArtAbstractModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      LatLng geoLocation,
      String imageUrl,
      List<String> tags});
}

/// @nodoc
class _$ArtAbstractModelCopyWithImpl<$Res, $Val extends ArtAbstractModel>
    implements $ArtAbstractModelCopyWith<$Res> {
  _$ArtAbstractModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? geoLocation = null,
    Object? imageUrl = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      geoLocation: null == geoLocation
          ? _value.geoLocation
          : geoLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArtAbstractModelCopyWith<$Res>
    implements $ArtAbstractModelCopyWith<$Res> {
  factory _$$_ArtAbstractModelCopyWith(
          _$_ArtAbstractModel value, $Res Function(_$_ArtAbstractModel) then) =
      __$$_ArtAbstractModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      LatLng geoLocation,
      String imageUrl,
      List<String> tags});
}

/// @nodoc
class __$$_ArtAbstractModelCopyWithImpl<$Res>
    extends _$ArtAbstractModelCopyWithImpl<$Res, _$_ArtAbstractModel>
    implements _$$_ArtAbstractModelCopyWith<$Res> {
  __$$_ArtAbstractModelCopyWithImpl(
      _$_ArtAbstractModel _value, $Res Function(_$_ArtAbstractModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? geoLocation = null,
    Object? imageUrl = null,
    Object? tags = null,
  }) {
    return _then(_$_ArtAbstractModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      geoLocation: null == geoLocation
          ? _value.geoLocation
          : geoLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtAbstractModel implements _ArtAbstractModel {
  const _$_ArtAbstractModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.geoLocation,
      required this.imageUrl,
      required final List<String> tags})
      : _tags = tags;

  factory _$_ArtAbstractModel.fromJson(Map<String, dynamic> json) =>
      _$$_ArtAbstractModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String location;
  @override
  final LatLng geoLocation;
  @override
  final String imageUrl;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'ArtAbstractModel(id: $id, title: $title, description: $description, location: $location, geoLocation: $geoLocation, imageUrl: $imageUrl, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArtAbstractModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.geoLocation, geoLocation) ||
                other.geoLocation == geoLocation) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, location,
      geoLocation, imageUrl, const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArtAbstractModelCopyWith<_$_ArtAbstractModel> get copyWith =>
      __$$_ArtAbstractModelCopyWithImpl<_$_ArtAbstractModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtAbstractModelToJson(
      this,
    );
  }
}

abstract class _ArtAbstractModel implements ArtAbstractModel {
  const factory _ArtAbstractModel(
      {required final String id,
      required final String title,
      required final String description,
      required final String location,
      required final LatLng geoLocation,
      required final String imageUrl,
      required final List<String> tags}) = _$_ArtAbstractModel;

  factory _ArtAbstractModel.fromJson(Map<String, dynamic> json) =
      _$_ArtAbstractModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get location;
  @override
  LatLng get geoLocation;
  @override
  String get imageUrl;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$_ArtAbstractModelCopyWith<_$_ArtAbstractModel> get copyWith =>
      throw _privateConstructorUsedError;
}
