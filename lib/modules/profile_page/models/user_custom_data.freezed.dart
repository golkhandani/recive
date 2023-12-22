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
  @JsonKey(name: 'bookmark_arts', defaultValue: [])
  List<String>? get bookmarkArts => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'bookmark_arts', defaultValue: [])
      List<String>? bookmarkArts});
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
    Object? bookmarkArts = freezed,
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
      bookmarkArts: freezed == bookmarkArts
          ? _value.bookmarkArts
          : bookmarkArts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCustomDataImplCopyWith<$Res>
    implements $UserCustomDataCopyWith<$Res> {
  factory _$$UserCustomDataImplCopyWith(_$UserCustomDataImpl value,
          $Res Function(_$UserCustomDataImpl) then) =
      __$$UserCustomDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'bookmark_arts', defaultValue: [])
      List<String>? bookmarkArts});
}

/// @nodoc
class __$$UserCustomDataImplCopyWithImpl<$Res>
    extends _$UserCustomDataCopyWithImpl<$Res, _$UserCustomDataImpl>
    implements _$$UserCustomDataImplCopyWith<$Res> {
  __$$UserCustomDataImplCopyWithImpl(
      _$UserCustomDataImpl _value, $Res Function(_$UserCustomDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
    Object? name = freezed,
    Object? bookmarkArts = freezed,
  }) {
    return _then(_$UserCustomDataImpl(
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
      bookmarkArts: freezed == bookmarkArts
          ? _value._bookmarkArts
          : bookmarkArts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCustomDataImpl implements _UserCustomData {
  const _$UserCustomDataImpl(
      {@JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'bookmark_arts', defaultValue: [])
      final List<String>? bookmarkArts})
      : _bookmarkArts = bookmarkArts;

  factory _$UserCustomDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCustomDataImplFromJson(json);

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
  final List<String>? _bookmarkArts;
  @override
  @JsonKey(name: 'bookmark_arts', defaultValue: [])
  List<String>? get bookmarkArts {
    final value = _bookmarkArts;
    if (value == null) return null;
    if (_bookmarkArts is EqualUnmodifiableListView) return _bookmarkArts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserCustomData(userId: $userId, email: $email, imageUrl: $imageUrl, name: $name, bookmarkArts: $bookmarkArts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCustomDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkArts, _bookmarkArts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, email, imageUrl, name,
      const DeepCollectionEquality().hash(_bookmarkArts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCustomDataImplCopyWith<_$UserCustomDataImpl> get copyWith =>
      __$$UserCustomDataImplCopyWithImpl<_$UserCustomDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCustomDataImplToJson(
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
      @JsonKey(name: 'bookmark_arts', defaultValue: [])
      final List<String>? bookmarkArts}) = _$UserCustomDataImpl;

  factory _UserCustomData.fromJson(Map<String, dynamic> json) =
      _$UserCustomDataImpl.fromJson;

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
  @JsonKey(name: 'bookmark_arts', defaultValue: [])
  List<String>? get bookmarkArts;
  @override
  @JsonKey(ignore: true)
  _$$UserCustomDataImplCopyWith<_$UserCustomDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}