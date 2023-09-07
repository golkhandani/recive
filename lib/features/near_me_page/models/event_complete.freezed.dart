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

EventComplete _$EventCompleteFromJson(Map<String, dynamic> json) {
  return _EventComplete.fromJson(json);
}

/// @nodoc
mixin _$EventComplete {
  String? get id => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool? get hasAvailableTickets => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  bool? get isFree => throw _privateConstructorUsedError;
  bool? get isOnlineEvent => throw _privateConstructorUsedError;
  bool? get isSoldOut => throw _privateConstructorUsedError;
  double? get maxPrice => throw _privateConstructorUsedError;
  double? get minPrice => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  Organizer? get organizer => throw _privateConstructorUsedError;
  DateTime? get publishedDate => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Venue? get venue => throw _privateConstructorUsedError;
  Source? get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCompleteCopyWith<EventComplete> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCompleteCopyWith<$Res> {
  factory $EventCompleteCopyWith(
          EventComplete value, $Res Function(EventComplete) then) =
      _$EventCompleteCopyWithImpl<$Res, EventComplete>;
  @useResult
  $Res call(
      {String? id,
      DateTime? endDate,
      bool? hasAvailableTickets,
      String? imageUrl,
      List<String>? imageUrls,
      bool? isFree,
      bool? isOnlineEvent,
      bool? isSoldOut,
      double? maxPrice,
      double? minPrice,
      String? title,
      Organizer? organizer,
      DateTime? publishedDate,
      DateTime? startDate,
      String? description,
      List<String>? tags,
      Venue? venue,
      Source? source});

  $OrganizerCopyWith<$Res>? get organizer;
  $VenueCopyWith<$Res>? get venue;
  $SourceCopyWith<$Res>? get source;
}

/// @nodoc
class _$EventCompleteCopyWithImpl<$Res, $Val extends EventComplete>
    implements $EventCompleteCopyWith<$Res> {
  _$EventCompleteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? endDate = freezed,
    Object? hasAvailableTickets = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = freezed,
    Object? isFree = freezed,
    Object? isOnlineEvent = freezed,
    Object? isSoldOut = freezed,
    Object? maxPrice = freezed,
    Object? minPrice = freezed,
    Object? title = freezed,
    Object? organizer = freezed,
    Object? publishedDate = freezed,
    Object? startDate = freezed,
    Object? description = freezed,
    Object? tags = freezed,
    Object? venue = freezed,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasAvailableTickets: freezed == hasAvailableTickets
          ? _value.hasAvailableTickets
          : hasAvailableTickets // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFree: freezed == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOnlineEvent: freezed == isOnlineEvent
          ? _value.isOnlineEvent
          : isOnlineEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSoldOut: freezed == isSoldOut
          ? _value.isSoldOut
          : isSoldOut // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      organizer: freezed == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as Organizer?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as Venue?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrganizerCopyWith<$Res>? get organizer {
    if (_value.organizer == null) {
      return null;
    }

    return $OrganizerCopyWith<$Res>(_value.organizer!, (value) {
      return _then(_value.copyWith(organizer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VenueCopyWith<$Res>? get venue {
    if (_value.venue == null) {
      return null;
    }

    return $VenueCopyWith<$Res>(_value.venue!, (value) {
      return _then(_value.copyWith(venue: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SourceCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $SourceCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventCompleteCopyWith<$Res>
    implements $EventCompleteCopyWith<$Res> {
  factory _$$_EventCompleteCopyWith(
          _$_EventComplete value, $Res Function(_$_EventComplete) then) =
      __$$_EventCompleteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime? endDate,
      bool? hasAvailableTickets,
      String? imageUrl,
      List<String>? imageUrls,
      bool? isFree,
      bool? isOnlineEvent,
      bool? isSoldOut,
      double? maxPrice,
      double? minPrice,
      String? title,
      Organizer? organizer,
      DateTime? publishedDate,
      DateTime? startDate,
      String? description,
      List<String>? tags,
      Venue? venue,
      Source? source});

  @override
  $OrganizerCopyWith<$Res>? get organizer;
  @override
  $VenueCopyWith<$Res>? get venue;
  @override
  $SourceCopyWith<$Res>? get source;
}

/// @nodoc
class __$$_EventCompleteCopyWithImpl<$Res>
    extends _$EventCompleteCopyWithImpl<$Res, _$_EventComplete>
    implements _$$_EventCompleteCopyWith<$Res> {
  __$$_EventCompleteCopyWithImpl(
      _$_EventComplete _value, $Res Function(_$_EventComplete) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? endDate = freezed,
    Object? hasAvailableTickets = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = freezed,
    Object? isFree = freezed,
    Object? isOnlineEvent = freezed,
    Object? isSoldOut = freezed,
    Object? maxPrice = freezed,
    Object? minPrice = freezed,
    Object? title = freezed,
    Object? organizer = freezed,
    Object? publishedDate = freezed,
    Object? startDate = freezed,
    Object? description = freezed,
    Object? tags = freezed,
    Object? venue = freezed,
    Object? source = freezed,
  }) {
    return _then(_$_EventComplete(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasAvailableTickets: freezed == hasAvailableTickets
          ? _value.hasAvailableTickets
          : hasAvailableTickets // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFree: freezed == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOnlineEvent: freezed == isOnlineEvent
          ? _value.isOnlineEvent
          : isOnlineEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSoldOut: freezed == isSoldOut
          ? _value.isSoldOut
          : isSoldOut // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      organizer: freezed == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as Organizer?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as Venue?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventComplete implements _EventComplete {
  const _$_EventComplete(
      {this.id,
      this.endDate,
      this.hasAvailableTickets,
      this.imageUrl,
      final List<String>? imageUrls,
      this.isFree,
      this.isOnlineEvent,
      this.isSoldOut,
      this.maxPrice,
      this.minPrice,
      this.title,
      this.organizer,
      this.publishedDate,
      this.startDate,
      this.description,
      final List<String>? tags,
      this.venue,
      this.source})
      : _imageUrls = imageUrls,
        _tags = tags;

  factory _$_EventComplete.fromJson(Map<String, dynamic> json) =>
      _$$_EventCompleteFromJson(json);

  @override
  final String? id;
  @override
  final DateTime? endDate;
  @override
  final bool? hasAvailableTickets;
  @override
  final String? imageUrl;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isFree;
  @override
  final bool? isOnlineEvent;
  @override
  final bool? isSoldOut;
  @override
  final double? maxPrice;
  @override
  final double? minPrice;
  @override
  final String? title;
  @override
  final Organizer? organizer;
  @override
  final DateTime? publishedDate;
  @override
  final DateTime? startDate;
  @override
  final String? description;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Venue? venue;
  @override
  final Source? source;

  @override
  String toString() {
    return 'EventComplete(id: $id, endDate: $endDate, hasAvailableTickets: $hasAvailableTickets, imageUrl: $imageUrl, imageUrls: $imageUrls, isFree: $isFree, isOnlineEvent: $isOnlineEvent, isSoldOut: $isSoldOut, maxPrice: $maxPrice, minPrice: $minPrice, title: $title, organizer: $organizer, publishedDate: $publishedDate, startDate: $startDate, description: $description, tags: $tags, venue: $venue, source: $source)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventComplete &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.hasAvailableTickets, hasAvailableTickets) ||
                other.hasAvailableTickets == hasAvailableTickets) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.isOnlineEvent, isOnlineEvent) ||
                other.isOnlineEvent == isOnlineEvent) &&
            (identical(other.isSoldOut, isSoldOut) ||
                other.isSoldOut == isSoldOut) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.organizer, organizer) ||
                other.organizer == organizer) &&
            (identical(other.publishedDate, publishedDate) ||
                other.publishedDate == publishedDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      endDate,
      hasAvailableTickets,
      imageUrl,
      const DeepCollectionEquality().hash(_imageUrls),
      isFree,
      isOnlineEvent,
      isSoldOut,
      maxPrice,
      minPrice,
      title,
      organizer,
      publishedDate,
      startDate,
      description,
      const DeepCollectionEquality().hash(_tags),
      venue,
      source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCompleteCopyWith<_$_EventComplete> get copyWith =>
      __$$_EventCompleteCopyWithImpl<_$_EventComplete>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventCompleteToJson(
      this,
    );
  }
}

abstract class _EventComplete implements EventComplete {
  const factory _EventComplete(
      {final String? id,
      final DateTime? endDate,
      final bool? hasAvailableTickets,
      final String? imageUrl,
      final List<String>? imageUrls,
      final bool? isFree,
      final bool? isOnlineEvent,
      final bool? isSoldOut,
      final double? maxPrice,
      final double? minPrice,
      final String? title,
      final Organizer? organizer,
      final DateTime? publishedDate,
      final DateTime? startDate,
      final String? description,
      final List<String>? tags,
      final Venue? venue,
      final Source? source}) = _$_EventComplete;

  factory _EventComplete.fromJson(Map<String, dynamic> json) =
      _$_EventComplete.fromJson;

  @override
  String? get id;
  @override
  DateTime? get endDate;
  @override
  bool? get hasAvailableTickets;
  @override
  String? get imageUrl;
  @override
  List<String>? get imageUrls;
  @override
  bool? get isFree;
  @override
  bool? get isOnlineEvent;
  @override
  bool? get isSoldOut;
  @override
  double? get maxPrice;
  @override
  double? get minPrice;
  @override
  String? get title;
  @override
  Organizer? get organizer;
  @override
  DateTime? get publishedDate;
  @override
  DateTime? get startDate;
  @override
  String? get description;
  @override
  List<String>? get tags;
  @override
  Venue? get venue;
  @override
  Source? get source;
  @override
  @JsonKey(ignore: true)
  _$$_EventCompleteCopyWith<_$_EventComplete> get copyWith =>
      throw _privateConstructorUsedError;
}

Organizer _$OrganizerFromJson(Map<String, dynamic> json) {
  return _Organizer.fromJson(json);
}

/// @nodoc
mixin _$Organizer {
  String? get organizerId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int? get numFollowers => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get websiteUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizerCopyWith<Organizer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizerCopyWith<$Res> {
  factory $OrganizerCopyWith(Organizer value, $Res Function(Organizer) then) =
      _$OrganizerCopyWithImpl<$Res, Organizer>;
  @useResult
  $Res call(
      {String? organizerId,
      String? title,
      int? numFollowers,
      String? description,
      String? websiteUrl});
}

/// @nodoc
class _$OrganizerCopyWithImpl<$Res, $Val extends Organizer>
    implements $OrganizerCopyWith<$Res> {
  _$OrganizerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizerId = freezed,
    Object? title = freezed,
    Object? numFollowers = freezed,
    Object? description = freezed,
    Object? websiteUrl = freezed,
  }) {
    return _then(_value.copyWith(
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      numFollowers: freezed == numFollowers
          ? _value.numFollowers
          : numFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrganizerCopyWith<$Res> implements $OrganizerCopyWith<$Res> {
  factory _$$_OrganizerCopyWith(
          _$_Organizer value, $Res Function(_$_Organizer) then) =
      __$$_OrganizerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? organizerId,
      String? title,
      int? numFollowers,
      String? description,
      String? websiteUrl});
}

/// @nodoc
class __$$_OrganizerCopyWithImpl<$Res>
    extends _$OrganizerCopyWithImpl<$Res, _$_Organizer>
    implements _$$_OrganizerCopyWith<$Res> {
  __$$_OrganizerCopyWithImpl(
      _$_Organizer _value, $Res Function(_$_Organizer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizerId = freezed,
    Object? title = freezed,
    Object? numFollowers = freezed,
    Object? description = freezed,
    Object? websiteUrl = freezed,
  }) {
    return _then(_$_Organizer(
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      numFollowers: freezed == numFollowers
          ? _value.numFollowers
          : numFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Organizer implements _Organizer {
  const _$_Organizer(
      {this.organizerId,
      this.title,
      this.numFollowers,
      this.description,
      this.websiteUrl});

  factory _$_Organizer.fromJson(Map<String, dynamic> json) =>
      _$$_OrganizerFromJson(json);

  @override
  final String? organizerId;
  @override
  final String? title;
  @override
  final int? numFollowers;
  @override
  final String? description;
  @override
  final String? websiteUrl;

  @override
  String toString() {
    return 'Organizer(organizerId: $organizerId, title: $title, numFollowers: $numFollowers, description: $description, websiteUrl: $websiteUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Organizer &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.numFollowers, numFollowers) ||
                other.numFollowers == numFollowers) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, organizerId, title, numFollowers, description, websiteUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrganizerCopyWith<_$_Organizer> get copyWith =>
      __$$_OrganizerCopyWithImpl<_$_Organizer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrganizerToJson(
      this,
    );
  }
}

abstract class _Organizer implements Organizer {
  const factory _Organizer(
      {final String? organizerId,
      final String? title,
      final int? numFollowers,
      final String? description,
      final String? websiteUrl}) = _$_Organizer;

  factory _Organizer.fromJson(Map<String, dynamic> json) =
      _$_Organizer.fromJson;

  @override
  String? get organizerId;
  @override
  String? get title;
  @override
  int? get numFollowers;
  @override
  String? get description;
  @override
  String? get websiteUrl;
  @override
  @JsonKey(ignore: true)
  _$$_OrganizerCopyWith<_$_Organizer> get copyWith =>
      throw _privateConstructorUsedError;
}

Source _$SourceFromJson(Map<String, dynamic> json) {
  return _Source.fromJson(json);
}

/// @nodoc
mixin _$Source {
  String? get id => throw _privateConstructorUsedError;
  String? get organizerId => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get venueId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceCopyWith<Source> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceCopyWith<$Res> {
  factory $SourceCopyWith(Source value, $Res Function(Source) then) =
      _$SourceCopyWithImpl<$Res, Source>;
  @useResult
  $Res call(
      {String? id,
      String? organizerId,
      String? url,
      String? venueId,
      String? name});
}

/// @nodoc
class _$SourceCopyWithImpl<$Res, $Val extends Source>
    implements $SourceCopyWith<$Res> {
  _$SourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? organizerId = freezed,
    Object? url = freezed,
    Object? venueId = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      venueId: freezed == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SourceCopyWith<$Res> implements $SourceCopyWith<$Res> {
  factory _$$_SourceCopyWith(_$_Source value, $Res Function(_$_Source) then) =
      __$$_SourceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? organizerId,
      String? url,
      String? venueId,
      String? name});
}

/// @nodoc
class __$$_SourceCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$_Source>
    implements _$$_SourceCopyWith<$Res> {
  __$$_SourceCopyWithImpl(_$_Source _value, $Res Function(_$_Source) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? organizerId = freezed,
    Object? url = freezed,
    Object? venueId = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Source(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      venueId: freezed == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Source implements _Source {
  const _$_Source(
      {this.id, this.organizerId, this.url, this.venueId, this.name});

  factory _$_Source.fromJson(Map<String, dynamic> json) =>
      _$$_SourceFromJson(json);

  @override
  final String? id;
  @override
  final String? organizerId;
  @override
  final String? url;
  @override
  final String? venueId;
  @override
  final String? name;

  @override
  String toString() {
    return 'Source(id: $id, organizerId: $organizerId, url: $url, venueId: $venueId, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Source &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.venueId, venueId) || other.venueId == venueId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, organizerId, url, venueId, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SourceCopyWith<_$_Source> get copyWith =>
      __$$_SourceCopyWithImpl<_$_Source>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SourceToJson(
      this,
    );
  }
}

abstract class _Source implements Source {
  const factory _Source(
      {final String? id,
      final String? organizerId,
      final String? url,
      final String? venueId,
      final String? name}) = _$_Source;

  factory _Source.fromJson(Map<String, dynamic> json) = _$_Source.fromJson;

  @override
  String? get id;
  @override
  String? get organizerId;
  @override
  String? get url;
  @override
  String? get venueId;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_SourceCopyWith<_$_Source> get copyWith =>
      throw _privateConstructorUsedError;
}

Venue _$VenueFromJson(Map<String, dynamic> json) {
  return _Venue.fromJson(json);
}

/// @nodoc
mixin _$Venue {
  Address? get address => throw _privateConstructorUsedError;
  String? get venueId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  LatLng? get latLng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VenueCopyWith<Venue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenueCopyWith<$Res> {
  factory $VenueCopyWith(Venue value, $Res Function(Venue) then) =
      _$VenueCopyWithImpl<$Res, Venue>;
  @useResult
  $Res call({Address? address, String? venueId, String? title, LatLng? latLng});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$VenueCopyWithImpl<$Res, $Val extends Venue>
    implements $VenueCopyWith<$Res> {
  _$VenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? venueId = freezed,
    Object? title = freezed,
    Object? latLng = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      venueId: freezed == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      latLng: freezed == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_VenueCopyWith<$Res> implements $VenueCopyWith<$Res> {
  factory _$$_VenueCopyWith(_$_Venue value, $Res Function(_$_Venue) then) =
      __$$_VenueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address? address, String? venueId, String? title, LatLng? latLng});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$_VenueCopyWithImpl<$Res> extends _$VenueCopyWithImpl<$Res, _$_Venue>
    implements _$$_VenueCopyWith<$Res> {
  __$$_VenueCopyWithImpl(_$_Venue _value, $Res Function(_$_Venue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? venueId = freezed,
    Object? title = freezed,
    Object? latLng = freezed,
  }) {
    return _then(_$_Venue(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      venueId: freezed == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      latLng: freezed == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Venue implements _Venue {
  const _$_Venue({this.address, this.venueId, this.title, this.latLng});

  factory _$_Venue.fromJson(Map<String, dynamic> json) =>
      _$$_VenueFromJson(json);

  @override
  final Address? address;
  @override
  final String? venueId;
  @override
  final String? title;
  @override
  final LatLng? latLng;

  @override
  String toString() {
    return 'Venue(address: $address, venueId: $venueId, title: $title, latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Venue &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.venueId, venueId) || other.venueId == venueId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.latLng, latLng) || other.latLng == latLng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, venueId, title, latLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VenueCopyWith<_$_Venue> get copyWith =>
      __$$_VenueCopyWithImpl<_$_Venue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VenueToJson(
      this,
    );
  }
}

abstract class _Venue implements Venue {
  const factory _Venue(
      {final Address? address,
      final String? venueId,
      final String? title,
      final LatLng? latLng}) = _$_Venue;

  factory _Venue.fromJson(Map<String, dynamic> json) = _$_Venue.fromJson;

  @override
  Address? get address;
  @override
  String? get venueId;
  @override
  String? get title;
  @override
  LatLng? get latLng;
  @override
  @JsonKey(ignore: true)
  _$$_VenueCopyWith<_$_Venue> get copyWith =>
      throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  String? get localizedAddressDisplay => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String? city,
      String? country,
      double? latitude,
      String? localizedAddressDisplay,
      double? longitude,
      String? postalCode,
      String? region});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
    Object? latitude = freezed,
    Object? localizedAddressDisplay = freezed,
    Object? longitude = freezed,
    Object? postalCode = freezed,
    Object? region = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      localizedAddressDisplay: freezed == localizedAddressDisplay
          ? _value.localizedAddressDisplay
          : localizedAddressDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$_AddressCopyWith(
          _$_Address value, $Res Function(_$_Address) then) =
      __$$_AddressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? city,
      String? country,
      double? latitude,
      String? localizedAddressDisplay,
      double? longitude,
      String? postalCode,
      String? region});
}

/// @nodoc
class __$$_AddressCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$_Address>
    implements _$$_AddressCopyWith<$Res> {
  __$$_AddressCopyWithImpl(_$_Address _value, $Res Function(_$_Address) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
    Object? latitude = freezed,
    Object? localizedAddressDisplay = freezed,
    Object? longitude = freezed,
    Object? postalCode = freezed,
    Object? region = freezed,
  }) {
    return _then(_$_Address(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      localizedAddressDisplay: freezed == localizedAddressDisplay
          ? _value.localizedAddressDisplay
          : localizedAddressDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Address implements _Address {
  const _$_Address(
      {this.city,
      this.country,
      this.latitude,
      this.localizedAddressDisplay,
      this.longitude,
      this.postalCode,
      this.region});

  factory _$_Address.fromJson(Map<String, dynamic> json) =>
      _$$_AddressFromJson(json);

  @override
  final String? city;
  @override
  final String? country;
  @override
  final double? latitude;
  @override
  final String? localizedAddressDisplay;
  @override
  final double? longitude;
  @override
  final String? postalCode;
  @override
  final String? region;

  @override
  String toString() {
    return 'Address(city: $city, country: $country, latitude: $latitude, localizedAddressDisplay: $localizedAddressDisplay, longitude: $longitude, postalCode: $postalCode, region: $region)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Address &&
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
  int get hashCode => Object.hash(runtimeType, city, country, latitude,
      localizedAddressDisplay, longitude, postalCode, region);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressCopyWith<_$_Address> get copyWith =>
      __$$_AddressCopyWithImpl<_$_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {final String? city,
      final String? country,
      final double? latitude,
      final String? localizedAddressDisplay,
      final double? longitude,
      final String? postalCode,
      final String? region}) = _$_Address;

  factory _Address.fromJson(Map<String, dynamic> json) = _$_Address.fromJson;

  @override
  String? get city;
  @override
  String? get country;
  @override
  double? get latitude;
  @override
  String? get localizedAddressDisplay;
  @override
  double? get longitude;
  @override
  String? get postalCode;
  @override
  String? get region;
  @override
  @JsonKey(ignore: true)
  _$$_AddressCopyWith<_$_Address> get copyWith =>
      throw _privateConstructorUsedError;
}
