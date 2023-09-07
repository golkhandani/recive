// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<NearbyEvent> get events => throw _privateConstructorUsedError;
  List<LatLng>? get polyline => throw _privateConstructorUsedError;
  List<String>? get roadInstructions => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res, Package>;
  @useResult
  $Res call(
      {String id,
      String title,
      String subtitle,
      String description,
      String imageUrl,
      List<String> tags,
      List<NearbyEvent> events,
      List<LatLng>? polyline,
      List<String>? roadInstructions,
      double distance,
      Duration duration});
}

/// @nodoc
class _$PackageCopyWithImpl<$Res, $Val extends Package>
    implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? tags = null,
    Object? events = null,
    Object? polyline = freezed,
    Object? roadInstructions = freezed,
    Object? distance = null,
    Object? duration = null,
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
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<NearbyEvent>,
      polyline: freezed == polyline
          ? _value.polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      roadInstructions: freezed == roadInstructions
          ? _value.roadInstructions
          : roadInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$_PackageCopyWith(
          _$_Package value, $Res Function(_$_Package) then) =
      __$$_PackageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String subtitle,
      String description,
      String imageUrl,
      List<String> tags,
      List<NearbyEvent> events,
      List<LatLng>? polyline,
      List<String>? roadInstructions,
      double distance,
      Duration duration});
}

/// @nodoc
class __$$_PackageCopyWithImpl<$Res>
    extends _$PackageCopyWithImpl<$Res, _$_Package>
    implements _$$_PackageCopyWith<$Res> {
  __$$_PackageCopyWithImpl(_$_Package _value, $Res Function(_$_Package) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? tags = null,
    Object? events = null,
    Object? polyline = freezed,
    Object? roadInstructions = freezed,
    Object? distance = null,
    Object? duration = null,
  }) {
    return _then(_$_Package(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<NearbyEvent>,
      polyline: freezed == polyline
          ? _value._polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as List<LatLng>?,
      roadInstructions: freezed == roadInstructions
          ? _value._roadInstructions
          : roadInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Package implements _Package {
  const _$_Package(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.imageUrl,
      required final List<String> tags,
      required final List<NearbyEvent> events,
      required final List<LatLng>? polyline,
      required final List<String>? roadInstructions,
      required this.distance,
      required this.duration})
      : _tags = tags,
        _events = events,
        _polyline = polyline,
        _roadInstructions = roadInstructions;

  factory _$_Package.fromJson(Map<String, dynamic> json) =>
      _$$_PackageFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String description;
  @override
  final String imageUrl;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<NearbyEvent> _events;
  @override
  List<NearbyEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<LatLng>? _polyline;
  @override
  List<LatLng>? get polyline {
    final value = _polyline;
    if (value == null) return null;
    if (_polyline is EqualUnmodifiableListView) return _polyline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _roadInstructions;
  @override
  List<String>? get roadInstructions {
    final value = _roadInstructions;
    if (value == null) return null;
    if (_roadInstructions is EqualUnmodifiableListView)
      return _roadInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double distance;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'Package(id: $id, title: $title, subtitle: $subtitle, description: $description, imageUrl: $imageUrl, tags: $tags, events: $events, polyline: $polyline, roadInstructions: $roadInstructions, distance: $distance, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Package &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._polyline, _polyline) &&
            const DeepCollectionEquality()
                .equals(other._roadInstructions, _roadInstructions) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_polyline),
      const DeepCollectionEquality().hash(_roadInstructions),
      distance,
      duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      __$$_PackageCopyWithImpl<_$_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageToJson(
      this,
    );
  }
}

abstract class _Package implements Package {
  const factory _Package(
      {required final String id,
      required final String title,
      required final String subtitle,
      required final String description,
      required final String imageUrl,
      required final List<String> tags,
      required final List<NearbyEvent> events,
      required final List<LatLng>? polyline,
      required final List<String>? roadInstructions,
      required final double distance,
      required final Duration duration}) = _$_Package;

  factory _Package.fromJson(Map<String, dynamic> json) = _$_Package.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  List<String> get tags;
  @override
  List<NearbyEvent> get events;
  @override
  List<LatLng>? get polyline;
  @override
  List<String>? get roadInstructions;
  @override
  double get distance;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      throw _privateConstructorUsedError;
}
