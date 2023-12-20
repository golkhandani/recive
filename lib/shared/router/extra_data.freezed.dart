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
abstract class _$$ExtraDataImplCopyWith<T, $Res>
    implements $ExtraDataCopyWith<T, $Res> {
  factory _$$ExtraDataImplCopyWith(
          _$ExtraDataImpl<T> value, $Res Function(_$ExtraDataImpl<T>) then) =
      __$$ExtraDataImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T? summary, String heroTag});
}

/// @nodoc
class __$$ExtraDataImplCopyWithImpl<T, $Res>
    extends _$ExtraDataCopyWithImpl<T, $Res, _$ExtraDataImpl<T>>
    implements _$$ExtraDataImplCopyWith<T, $Res> {
  __$$ExtraDataImplCopyWithImpl(
      _$ExtraDataImpl<T> _value, $Res Function(_$ExtraDataImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = freezed,
    Object? heroTag = null,
  }) {
    return _then(_$ExtraDataImpl<T>(
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
class _$ExtraDataImpl<T> implements _ExtraData<T> {
  const _$ExtraDataImpl({required this.summary, required this.heroTag});

  factory _$ExtraDataImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ExtraDataImplFromJson(json, fromJsonT);

  @override
  final T? summary;
  @override
  final String heroTag;

  @override
  String toString() {
    return 'ExtraData<$T>(summary: $summary, heroTag: $heroTag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtraDataImpl<T> &&
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
  _$$ExtraDataImplCopyWith<T, _$ExtraDataImpl<T>> get copyWith =>
      __$$ExtraDataImplCopyWithImpl<T, _$ExtraDataImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ExtraDataImplToJson<T>(this, toJsonT);
  }
}

abstract class _ExtraData<T> implements ExtraData<T> {
  const factory _ExtraData(
      {required final T? summary,
      required final String heroTag}) = _$ExtraDataImpl<T>;

  factory _ExtraData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ExtraDataImpl<T>.fromJson;

  @override
  T? get summary;
  @override
  String get heroTag;
  @override
  @JsonKey(ignore: true)
  _$$ExtraDataImplCopyWith<T, _$ExtraDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDetailSummaryData _$ArtDetailSummaryDataFromJson(Map<String, dynamic> json) {
  return _ArtDetailSummaryData.fromJson(json);
}

/// @nodoc
mixin _$ArtDetailSummaryData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtDetailSummaryDataCopyWith<ArtDetailSummaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDetailSummaryDataCopyWith<$Res> {
  factory $ArtDetailSummaryDataCopyWith(ArtDetailSummaryData value,
          $Res Function(ArtDetailSummaryData) then) =
      _$ArtDetailSummaryDataCopyWithImpl<$Res, ArtDetailSummaryData>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$ArtDetailSummaryDataCopyWithImpl<$Res,
        $Val extends ArtDetailSummaryData>
    implements $ArtDetailSummaryDataCopyWith<$Res> {
  _$ArtDetailSummaryDataCopyWithImpl(this._value, this._then);

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
abstract class _$$ArtDetailSummaryDataImplCopyWith<$Res>
    implements $ArtDetailSummaryDataCopyWith<$Res> {
  factory _$$ArtDetailSummaryDataImplCopyWith(_$ArtDetailSummaryDataImpl value,
          $Res Function(_$ArtDetailSummaryDataImpl) then) =
      __$$ArtDetailSummaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$ArtDetailSummaryDataImplCopyWithImpl<$Res>
    extends _$ArtDetailSummaryDataCopyWithImpl<$Res, _$ArtDetailSummaryDataImpl>
    implements _$$ArtDetailSummaryDataImplCopyWith<$Res> {
  __$$ArtDetailSummaryDataImplCopyWithImpl(_$ArtDetailSummaryDataImpl _value,
      $Res Function(_$ArtDetailSummaryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$ArtDetailSummaryDataImpl(
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
class _$ArtDetailSummaryDataImpl implements _ArtDetailSummaryData {
  const _$ArtDetailSummaryDataImpl(
      {required this.id, required this.title, required this.imageUrl});

  factory _$ArtDetailSummaryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtDetailSummaryDataImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'ArtDetailSummaryData(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtDetailSummaryDataImpl &&
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
  _$$ArtDetailSummaryDataImplCopyWith<_$ArtDetailSummaryDataImpl>
      get copyWith =>
          __$$ArtDetailSummaryDataImplCopyWithImpl<_$ArtDetailSummaryDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtDetailSummaryDataImplToJson(
      this,
    );
  }
}

abstract class _ArtDetailSummaryData implements ArtDetailSummaryData {
  const factory _ArtDetailSummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$ArtDetailSummaryDataImpl;

  factory _ArtDetailSummaryData.fromJson(Map<String, dynamic> json) =
      _$ArtDetailSummaryDataImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ArtDetailSummaryDataImplCopyWith<_$ArtDetailSummaryDataImpl>
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
abstract class _$$CategorySummaryDataImplCopyWith<$Res>
    implements $CategorySummaryDataCopyWith<$Res> {
  factory _$$CategorySummaryDataImplCopyWith(_$CategorySummaryDataImpl value,
          $Res Function(_$CategorySummaryDataImpl) then) =
      __$$CategorySummaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$CategorySummaryDataImplCopyWithImpl<$Res>
    extends _$CategorySummaryDataCopyWithImpl<$Res, _$CategorySummaryDataImpl>
    implements _$$CategorySummaryDataImplCopyWith<$Res> {
  __$$CategorySummaryDataImplCopyWithImpl(_$CategorySummaryDataImpl _value,
      $Res Function(_$CategorySummaryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$CategorySummaryDataImpl(
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
class _$CategorySummaryDataImpl implements _CategorySummaryData {
  const _$CategorySummaryDataImpl(
      {required this.id, required this.title, required this.imageUrl});

  factory _$CategorySummaryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySummaryDataImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySummaryDataImpl &&
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
  _$$CategorySummaryDataImplCopyWith<_$CategorySummaryDataImpl> get copyWith =>
      __$$CategorySummaryDataImplCopyWithImpl<_$CategorySummaryDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySummaryDataImplToJson(
      this,
    );
  }
}

abstract class _CategorySummaryData implements CategorySummaryData {
  const factory _CategorySummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$CategorySummaryDataImpl;

  factory _CategorySummaryData.fromJson(Map<String, dynamic> json) =
      _$CategorySummaryDataImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$CategorySummaryDataImplCopyWith<_$CategorySummaryDataImpl> get copyWith =>
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
abstract class _$$PackageSummaryDataImplCopyWith<$Res>
    implements $PackageSummaryDataCopyWith<$Res> {
  factory _$$PackageSummaryDataImplCopyWith(_$PackageSummaryDataImpl value,
          $Res Function(_$PackageSummaryDataImpl) then) =
      __$$PackageSummaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$PackageSummaryDataImplCopyWithImpl<$Res>
    extends _$PackageSummaryDataCopyWithImpl<$Res, _$PackageSummaryDataImpl>
    implements _$$PackageSummaryDataImplCopyWith<$Res> {
  __$$PackageSummaryDataImplCopyWithImpl(_$PackageSummaryDataImpl _value,
      $Res Function(_$PackageSummaryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(_$PackageSummaryDataImpl(
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
class _$PackageSummaryDataImpl implements _PackageSummaryData {
  const _$PackageSummaryDataImpl(
      {required this.id, required this.title, required this.imageUrl});

  factory _$PackageSummaryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackageSummaryDataImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageSummaryDataImpl &&
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
  _$$PackageSummaryDataImplCopyWith<_$PackageSummaryDataImpl> get copyWith =>
      __$$PackageSummaryDataImplCopyWithImpl<_$PackageSummaryDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackageSummaryDataImplToJson(
      this,
    );
  }
}

abstract class _PackageSummaryData implements PackageSummaryData {
  const factory _PackageSummaryData(
      {required final String id,
      required final String title,
      required final String imageUrl}) = _$PackageSummaryDataImpl;

  factory _PackageSummaryData.fromJson(Map<String, dynamic> json) =
      _$PackageSummaryDataImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$PackageSummaryDataImplCopyWith<_$PackageSummaryDataImpl> get copyWith =>
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
abstract class _$$NewsSummaryDataImplCopyWith<$Res>
    implements $NewsSummaryDataCopyWith<$Res> {
  factory _$$NewsSummaryDataImplCopyWith(_$NewsSummaryDataImpl value,
          $Res Function(_$NewsSummaryDataImpl) then) =
      __$$NewsSummaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$NewsSummaryDataImplCopyWithImpl<$Res>
    extends _$NewsSummaryDataCopyWithImpl<$Res, _$NewsSummaryDataImpl>
    implements _$$NewsSummaryDataImplCopyWith<$Res> {
  __$$NewsSummaryDataImplCopyWithImpl(
      _$NewsSummaryDataImpl _value, $Res Function(_$NewsSummaryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$NewsSummaryDataImpl(
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
class _$NewsSummaryDataImpl implements _NewsSummaryData {
  const _$NewsSummaryDataImpl({required this.id, required this.title});

  factory _$NewsSummaryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsSummaryDataImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'NewsSummaryData(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsSummaryDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsSummaryDataImplCopyWith<_$NewsSummaryDataImpl> get copyWith =>
      __$$NewsSummaryDataImplCopyWithImpl<_$NewsSummaryDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsSummaryDataImplToJson(
      this,
    );
  }
}

abstract class _NewsSummaryData implements NewsSummaryData {
  const factory _NewsSummaryData(
      {required final String id,
      required final String title}) = _$NewsSummaryDataImpl;

  factory _NewsSummaryData.fromJson(Map<String, dynamic> json) =
      _$NewsSummaryDataImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$NewsSummaryDataImplCopyWith<_$NewsSummaryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
