// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeaturedEvent _$FeaturedEventFromJson(Map<String, dynamic> json) {
  return _FeaturedEvent.fromJson(json);
}

/// @nodoc
mixin _$FeaturedEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  List<String> get organizers => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeaturedEventCopyWith<FeaturedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedEventCopyWith<$Res> {
  factory $FeaturedEventCopyWith(
          FeaturedEvent value, $Res Function(FeaturedEvent) then) =
      _$FeaturedEventCopyWithImpl<$Res, FeaturedEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      List<String> organizers,
      List<String> participants,
      String imageUrl,
      List<String> tags});
}

/// @nodoc
class _$FeaturedEventCopyWithImpl<$Res, $Val extends FeaturedEvent>
    implements $FeaturedEventCopyWith<$Res> {
  _$FeaturedEventCopyWithImpl(this._value, this._then);

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
    Object? organizers = null,
    Object? participants = null,
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
      organizers: null == organizers
          ? _value.organizers
          : organizers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$_FeaturedEventCopyWith<$Res>
    implements $FeaturedEventCopyWith<$Res> {
  factory _$$_FeaturedEventCopyWith(
          _$_FeaturedEvent value, $Res Function(_$_FeaturedEvent) then) =
      __$$_FeaturedEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String location,
      List<String> organizers,
      List<String> participants,
      String imageUrl,
      List<String> tags});
}

/// @nodoc
class __$$_FeaturedEventCopyWithImpl<$Res>
    extends _$FeaturedEventCopyWithImpl<$Res, _$_FeaturedEvent>
    implements _$$_FeaturedEventCopyWith<$Res> {
  __$$_FeaturedEventCopyWithImpl(
      _$_FeaturedEvent _value, $Res Function(_$_FeaturedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? organizers = null,
    Object? participants = null,
    Object? imageUrl = null,
    Object? tags = null,
  }) {
    return _then(_$_FeaturedEvent(
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
      organizers: null == organizers
          ? _value._organizers
          : organizers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$_FeaturedEvent implements _FeaturedEvent {
  const _$_FeaturedEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required final List<String> organizers,
      required final List<String> participants,
      required this.imageUrl,
      required final List<String> tags})
      : _organizers = organizers,
        _participants = participants,
        _tags = tags;

  factory _$_FeaturedEvent.fromJson(Map<String, dynamic> json) =>
      _$$_FeaturedEventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String location;
  final List<String> _organizers;
  @override
  List<String> get organizers {
    if (_organizers is EqualUnmodifiableListView) return _organizers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organizers);
  }

  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

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
    return 'FeaturedEvent(id: $id, title: $title, description: $description, location: $location, organizers: $organizers, participants: $participants, imageUrl: $imageUrl, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeaturedEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._organizers, _organizers) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      location,
      const DeepCollectionEquality().hash(_organizers),
      const DeepCollectionEquality().hash(_participants),
      imageUrl,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeaturedEventCopyWith<_$_FeaturedEvent> get copyWith =>
      __$$_FeaturedEventCopyWithImpl<_$_FeaturedEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeaturedEventToJson(
      this,
    );
  }
}

abstract class _FeaturedEvent implements FeaturedEvent {
  const factory _FeaturedEvent(
      {required final String id,
      required final String title,
      required final String description,
      required final String location,
      required final List<String> organizers,
      required final List<String> participants,
      required final String imageUrl,
      required final List<String> tags}) = _$_FeaturedEvent;

  factory _FeaturedEvent.fromJson(Map<String, dynamic> json) =
      _$_FeaturedEvent.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get location;
  @override
  List<String> get organizers;
  @override
  List<String> get participants;
  @override
  String get imageUrl;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$_FeaturedEventCopyWith<_$_FeaturedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
