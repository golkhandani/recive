// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extra_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExtraData<T> _$ExtraDataFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ExtraData<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ExtraData<T> {
  T? get summary => throw _privateConstructorUsedError;
  String get heroTag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtraDataCopyWith<T, ExtraData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraDataCopyWith<T, $Res> {
  factory $ExtraDataCopyWith(
          ExtraData<T> value, $Res Function(ExtraData<T>) then) =
      _$ExtraDataCopyWithImpl<T, $Res, ExtraData<T>>;
  @useResult
  $Res call({T? summary, String heroTag});
}

/// @nodoc
class _$ExtraDataCopyWithImpl<T, $Res, $Val extends ExtraData<T>>
    implements $ExtraDataCopyWith<T, $Res> {
  _$ExtraDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = freezed,
    Object? heroTag = null,
  }) {
    return _then(_value.copyWith(
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as T?,
      heroTag: null == heroTag
          ? _value.heroTag
          : heroTag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExtraDataCopyWith<T, $Res>
    implements $ExtraDataCopyWith<T, $Res> {
  factory _$$_ExtraDataCopyWith(
          _$_ExtraData<T> value, $Res Function(_$_ExtraData<T>) then) =
      __$$_ExtraDataCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T? summary, String heroTag});
}

/// @nodoc
class __$$_ExtraDataCopyWithImpl<T, $Res>
    extends _$ExtraDataCopyWithImpl<T, $Res, _$_ExtraData<T>>
    implements _$$_ExtraDataCopyWith<T, $Res> {
  __$$_ExtraDataCopyWithImpl(
      _$_ExtraData<T> _value, $Res Function(_$_ExtraData<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = freezed,
    Object? heroTag = null,
  }) {
    return _then(_$_ExtraData<T>(
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as T?,
      heroTag: null == heroTag
          ? _value.heroTag
          : heroTag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$_ExtraData<T> implements _ExtraData<T> {
  const _$_ExtraData({required this.summary, required this.heroTag});

  factory _$_ExtraData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$_ExtraDataFromJson(json, fromJsonT);

  @override
  final T? summary;
  @override
  final String heroTag;

  @override
  String toString() {
    return 'ExtraData<$T>(summary: $summary, heroTag: $heroTag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExtraData<T> &&
            const DeepCollectionEquality().equals(other.summary, summary) &&
            (identical(other.heroTag, heroTag) || other.heroTag == heroTag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(summary), heroTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExtraDataCopyWith<T, _$_ExtraData<T>> get copyWith =>
      __$$_ExtraDataCopyWithImpl<T, _$_ExtraData<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$_ExtraDataToJson<T>(this, toJsonT);
  }
}

abstract class _ExtraData<T> implements ExtraData<T> {
  const factory _ExtraData(
      {required final T? summary,
      required final String heroTag}) = _$_ExtraData<T>;

  factory _ExtraData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$_ExtraData<T>.fromJson;

  @override
  T? get summary;
  @override
  String get heroTag;
  @override
  @JsonKey(ignore: true)
  _$$_ExtraDataCopyWith<T, _$_ExtraData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

FeaturedEventDetailSummaryData _$FeaturedEventDetailSummaryDataFromJson(
    Map<String, dynamic> json) {
  return _FeaturedEventDetailSummaryData.fromJson(json);
}

/// @nodoc
mixin _$FeaturedEventDetailSummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeaturedEventDetailSummaryDataCopyWith<FeaturedEventDetailSummaryData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedEventDetailSummaryDataCopyWith<$Res> {
  factory $FeaturedEventDetailSummaryDataCopyWith(
          FeaturedEventDetailSummaryData value,
          $Res Function(FeaturedEventDetailSummaryData) then) =
      _$FeaturedEventDetailSummaryDataCopyWithImpl<$Res,
          FeaturedEventDetailSummaryData>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$FeaturedEventDetailSummaryDataCopyWithImpl<$Res,
        $Val extends FeaturedEventDetailSummaryData>
    implements $FeaturedEventDetailSummaryDataCopyWith<$Res> {
  _$FeaturedEventDetailSummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FeaturedEventDetailSummaryDataCopyWith<$Res>
    implements $FeaturedEventDetailSummaryDataCopyWith<$Res> {
  factory _$$_FeaturedEventDetailSummaryDataCopyWith(
          _$_FeaturedEventDetailSummaryData value,
          $Res Function(_$_FeaturedEventDetailSummaryData) then) =
      __$$_FeaturedEventDetailSummaryDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$_FeaturedEventDetailSummaryDataCopyWithImpl<$Res>
    extends _$FeaturedEventDetailSummaryDataCopyWithImpl<$Res,
        _$_FeaturedEventDetailSummaryData>
    implements _$$_FeaturedEventDetailSummaryDataCopyWith<$Res> {
  __$$_FeaturedEventDetailSummaryDataCopyWithImpl(
      _$_FeaturedEventDetailSummaryData _value,
      $Res Function(_$_FeaturedEventDetailSummaryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_FeaturedEventDetailSummaryData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$_FeaturedEventDetailSummaryData
    implements _FeaturedEventDetailSummaryData {
  const _$_FeaturedEventDetailSummaryData(
      {required this.id, required this.title, required this.imageUrl});

  factory _$_FeaturedEventDetailSummaryData.fromJson(
          Map<String, dynamic> json) =>
      _$$_FeaturedEventDetailSummaryDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'FeaturedEventDetailSummaryData(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeaturedEventDetailSummaryData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeaturedEventDetailSummaryDataCopyWith<_$_FeaturedEventDetailSummaryData>
      get copyWith => __$$_FeaturedEventDetailSummaryDataCopyWithImpl<
          _$_FeaturedEventDetailSummaryData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeaturedEventDetailSummaryDataToJson(
      this,
    );
  }
}

abstract class _FeaturedEventDetailSummaryData
    implements FeaturedEventDetailSummaryData {
  const factory _FeaturedEventDetailSummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$_FeaturedEventDetailSummaryData;

  factory _FeaturedEventDetailSummaryData.fromJson(Map<String, dynamic> json) =
      _$_FeaturedEventDetailSummaryData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_FeaturedEventDetailSummaryDataCopyWith<_$_FeaturedEventDetailSummaryData>
      get copyWith => throw _privateConstructorUsedError;
}

NearbyDetailSummaryData _$NearbyDetailSummaryDataFromJson(
    Map<String, dynamic> json) {
  return _NearbyDetailSummaryData.fromJson(json);
}

/// @nodoc
mixin _$NearbyDetailSummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbyDetailSummaryDataCopyWith<NearbyDetailSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyDetailSummaryDataCopyWith<$Res> {
  factory $NearbyDetailSummaryDataCopyWith(NearbyDetailSummaryData value,
          $Res Function(NearbyDetailSummaryData) then) =
      _$NearbyDetailSummaryDataCopyWithImpl<$Res, NearbyDetailSummaryData>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$NearbyDetailSummaryDataCopyWithImpl<$Res,
        $Val extends NearbyDetailSummaryData>
    implements $NearbyDetailSummaryDataCopyWith<$Res> {
  _$NearbyDetailSummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NearbyDetailSummaryDataCopyWith<$Res>
    implements $NearbyDetailSummaryDataCopyWith<$Res> {
  factory _$$_NearbyDetailSummaryDataCopyWith(_$_NearbyDetailSummaryData value,
          $Res Function(_$_NearbyDetailSummaryData) then) =
      __$$_NearbyDetailSummaryDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$_NearbyDetailSummaryDataCopyWithImpl<$Res>
    extends _$NearbyDetailSummaryDataCopyWithImpl<$Res,
        _$_NearbyDetailSummaryData>
    implements _$$_NearbyDetailSummaryDataCopyWith<$Res> {
  __$$_NearbyDetailSummaryDataCopyWithImpl(_$_NearbyDetailSummaryData _value,
      $Res Function(_$_NearbyDetailSummaryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_NearbyDetailSummaryData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$_NearbyDetailSummaryData implements _NearbyDetailSummaryData {
  const _$_NearbyDetailSummaryData(
      {required this.id, required this.title, required this.imageUrl});

  factory _$_NearbyDetailSummaryData.fromJson(Map<String, dynamic> json) =>
      _$$_NearbyDetailSummaryDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'NearbyDetailSummaryData(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearbyDetailSummaryData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearbyDetailSummaryDataCopyWith<_$_NearbyDetailSummaryData>
      get copyWith =>
          __$$_NearbyDetailSummaryDataCopyWithImpl<_$_NearbyDetailSummaryData>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NearbyDetailSummaryDataToJson(
      this,
    );
  }
}

abstract class _NearbyDetailSummaryData implements NearbyDetailSummaryData {
  const factory _NearbyDetailSummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$_NearbyDetailSummaryData;

  factory _NearbyDetailSummaryData.fromJson(Map<String, dynamic> json) =
      _$_NearbyDetailSummaryData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_NearbyDetailSummaryDataCopyWith<_$_NearbyDetailSummaryData>
      get copyWith => throw _privateConstructorUsedError;
}

CategorySummaryData _$CategorySummaryDataFromJson(Map<String, dynamic> json) {
  return _CategorySummaryData.fromJson(json);
}

/// @nodoc
mixin _$CategorySummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategorySummaryDataCopyWith<CategorySummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySummaryDataCopyWith<$Res> {
  factory $CategorySummaryDataCopyWith(
          CategorySummaryData value, $Res Function(CategorySummaryData) then) =
      _$CategorySummaryDataCopyWithImpl<$Res, CategorySummaryData>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$CategorySummaryDataCopyWithImpl<$Res, $Val extends CategorySummaryData>
    implements $CategorySummaryDataCopyWith<$Res> {
  _$CategorySummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategorySummaryDataCopyWith<$Res>
    implements $CategorySummaryDataCopyWith<$Res> {
  factory _$$_CategorySummaryDataCopyWith(_$_CategorySummaryData value,
          $Res Function(_$_CategorySummaryData) then) =
      __$$_CategorySummaryDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$_CategorySummaryDataCopyWithImpl<$Res>
    extends _$CategorySummaryDataCopyWithImpl<$Res, _$_CategorySummaryData>
    implements _$$_CategorySummaryDataCopyWith<$Res> {
  __$$_CategorySummaryDataCopyWithImpl(_$_CategorySummaryData _value,
      $Res Function(_$_CategorySummaryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_CategorySummaryData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$_CategorySummaryData implements _CategorySummaryData {
  const _$_CategorySummaryData(
      {required this.id, required this.title, required this.imageUrl});

  factory _$_CategorySummaryData.fromJson(Map<String, dynamic> json) =>
      _$$_CategorySummaryDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'CategorySummaryData(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategorySummaryData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategorySummaryDataCopyWith<_$_CategorySummaryData> get copyWith =>
      __$$_CategorySummaryDataCopyWithImpl<_$_CategorySummaryData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategorySummaryDataToJson(
      this,
    );
  }
}

abstract class _CategorySummaryData implements CategorySummaryData {
  const factory _CategorySummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$_CategorySummaryData;

  factory _CategorySummaryData.fromJson(Map<String, dynamic> json) =
      _$_CategorySummaryData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_CategorySummaryDataCopyWith<_$_CategorySummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

PackageSummaryData _$PackageSummaryDataFromJson(Map<String, dynamic> json) {
  return _PackageSummaryData.fromJson(json);
}

/// @nodoc
mixin _$PackageSummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageSummaryDataCopyWith<PackageSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageSummaryDataCopyWith<$Res> {
  factory $PackageSummaryDataCopyWith(
          PackageSummaryData value, $Res Function(PackageSummaryData) then) =
      _$PackageSummaryDataCopyWithImpl<$Res, PackageSummaryData>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$PackageSummaryDataCopyWithImpl<$Res, $Val extends PackageSummaryData>
    implements $PackageSummaryDataCopyWith<$Res> {
  _$PackageSummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageSummaryDataCopyWith<$Res>
    implements $PackageSummaryDataCopyWith<$Res> {
  factory _$$_PackageSummaryDataCopyWith(_$_PackageSummaryData value,
          $Res Function(_$_PackageSummaryData) then) =
      __$$_PackageSummaryDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$_PackageSummaryDataCopyWithImpl<$Res>
    extends _$PackageSummaryDataCopyWithImpl<$Res, _$_PackageSummaryData>
    implements _$$_PackageSummaryDataCopyWith<$Res> {
  __$$_PackageSummaryDataCopyWithImpl(
      _$_PackageSummaryData _value, $Res Function(_$_PackageSummaryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_PackageSummaryData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$_PackageSummaryData implements _PackageSummaryData {
  const _$_PackageSummaryData(
      {required this.id, required this.title, required this.imageUrl});

  factory _$_PackageSummaryData.fromJson(Map<String, dynamic> json) =>
      _$$_PackageSummaryDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'PackageSummaryData(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageSummaryData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageSummaryDataCopyWith<_$_PackageSummaryData> get copyWith =>
      __$$_PackageSummaryDataCopyWithImpl<_$_PackageSummaryData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageSummaryDataToJson(
      this,
    );
  }
}

abstract class _PackageSummaryData implements PackageSummaryData {
  const factory _PackageSummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$_PackageSummaryData;

  factory _PackageSummaryData.fromJson(Map<String, dynamic> json) =
      _$_PackageSummaryData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PackageSummaryDataCopyWith<_$_PackageSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

NewsSummaryData _$NewsSummaryDataFromJson(Map<String, dynamic> json) {
  return _NewsSummaryData.fromJson(json);
}

/// @nodoc
mixin _$NewsSummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsSummaryDataCopyWith<NewsSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsSummaryDataCopyWith<$Res> {
  factory $NewsSummaryDataCopyWith(
          NewsSummaryData value, $Res Function(NewsSummaryData) then) =
      _$NewsSummaryDataCopyWithImpl<$Res, NewsSummaryData>;
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class _$NewsSummaryDataCopyWithImpl<$Res, $Val extends NewsSummaryData>
    implements $NewsSummaryDataCopyWith<$Res> {
  _$NewsSummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewsSummaryDataCopyWith<$Res>
    implements $NewsSummaryDataCopyWith<$Res> {
  factory _$$_NewsSummaryDataCopyWith(
          _$_NewsSummaryData value, $Res Function(_$_NewsSummaryData) then) =
      __$$_NewsSummaryDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$_NewsSummaryDataCopyWithImpl<$Res>
    extends _$NewsSummaryDataCopyWithImpl<$Res, _$_NewsSummaryData>
    implements _$$_NewsSummaryDataCopyWith<$Res> {
  __$$_NewsSummaryDataCopyWithImpl(
      _$_NewsSummaryData _value, $Res Function(_$_NewsSummaryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$_NewsSummaryData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$_NewsSummaryData implements _NewsSummaryData {
  const _$_NewsSummaryData({required this.id, required this.title});

  factory _$_NewsSummaryData.fromJson(Map<String, dynamic> json) =>
      _$$_NewsSummaryDataFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'NewsSummaryData(id: $id, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewsSummaryData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewsSummaryDataCopyWith<_$_NewsSummaryData> get copyWith =>
      __$$_NewsSummaryDataCopyWithImpl<_$_NewsSummaryData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewsSummaryDataToJson(
      this,
    );
  }
}

abstract class _NewsSummaryData implements NewsSummaryData {
  const factory _NewsSummaryData(
      {required final String id,
      required final String title}) = _$_NewsSummaryData;

  factory _NewsSummaryData.fromJson(Map<String, dynamic> json) =
      _$_NewsSummaryData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_NewsSummaryDataCopyWith<_$_NewsSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}
