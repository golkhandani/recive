// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_custom_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserCustomData _$UserCustomDataFromJson(Map<String, dynamic> json) {
  return _UserCustomData.fromJson(json);
}

/// @nodoc
mixin _$UserCustomData {
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmark_events')
  List<String>? get bookmarkEvents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCustomDataCopyWith<UserCustomData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCustomDataCopyWith<$Res> {
  factory $UserCustomDataCopyWith(
          UserCustomData value, $Res Function(UserCustomData) then) =
      _$UserCustomDataCopyWithImpl<$Res, UserCustomData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'bookmark_events') List<String>? bookmarkEvents});
}

/// @nodoc
class _$UserCustomDataCopyWithImpl<$Res, $Val extends UserCustomData>
    implements $UserCustomDataCopyWith<$Res> {
  _$UserCustomDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
    Object? name = freezed,
    Object? bookmarkEvents = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarkEvents: freezed == bookmarkEvents
          ? _value.bookmarkEvents
          : bookmarkEvents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCustomDataCopyWith<$Res>
    implements $UserCustomDataCopyWith<$Res> {
  factory _$$_UserCustomDataCopyWith(
          _$_UserCustomData value, $Res Function(_$_UserCustomData) then) =
      __$$_UserCustomDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'bookmark_events') List<String>? bookmarkEvents});
}

/// @nodoc
class __$$_UserCustomDataCopyWithImpl<$Res>
    extends _$UserCustomDataCopyWithImpl<$Res, _$_UserCustomData>
    implements _$$_UserCustomDataCopyWith<$Res> {
  __$$_UserCustomDataCopyWithImpl(
      _$_UserCustomData _value, $Res Function(_$_UserCustomData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
    Object? name = freezed,
    Object? bookmarkEvents = freezed,
  }) {
    return _then(_$_UserCustomData(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarkEvents: freezed == bookmarkEvents
          ? _value._bookmarkEvents
          : bookmarkEvents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserCustomData implements _UserCustomData {
  const _$_UserCustomData(
      {@JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'bookmark_events') final List<String>? bookmarkEvents})
      : _bookmarkEvents = bookmarkEvents;

  factory _$_UserCustomData.fromJson(Map<String, dynamic> json) =>
      _$$_UserCustomDataFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final String? userId;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'name')
  final String? name;
  final List<String>? _bookmarkEvents;
  @override
  @JsonKey(name: 'bookmark_events')
  List<String>? get bookmarkEvents {
    final value = _bookmarkEvents;
    if (value == null) return null;
    if (_bookmarkEvents is EqualUnmodifiableListView) return _bookmarkEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserCustomData(userId: $userId, email: $email, imageUrl: $imageUrl, name: $name, bookmarkEvents: $bookmarkEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserCustomData &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkEvents, _bookmarkEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, email, imageUrl, name,
      const DeepCollectionEquality().hash(_bookmarkEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCustomDataCopyWith<_$_UserCustomData> get copyWith =>
      __$$_UserCustomDataCopyWithImpl<_$_UserCustomData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCustomDataToJson(
      this,
    );
  }
}

abstract class _UserCustomData implements UserCustomData {
  const factory _UserCustomData(
      {@JsonKey(name: 'userId') final String? userId,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'bookmark_events')
      final List<String>? bookmarkEvents}) = _$_UserCustomData;

  factory _UserCustomData.fromJson(Map<String, dynamic> json) =
      _$_UserCustomData.fromJson;

  @override
  @JsonKey(name: 'userId')
  String? get userId;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'bookmark_events')
  List<String>? get bookmarkEvents;
  @override
  @JsonKey(ignore: true)
  _$$_UserCustomDataCopyWith<_$_UserCustomData> get copyWith =>
      throw _privateConstructorUsedError;
}
