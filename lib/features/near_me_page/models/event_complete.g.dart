// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_complete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventComplete _$$_EventCompleteFromJson(Map<String, dynamic> json) =>
    _$_EventComplete(
      id: json['id'] as String?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      hasAvailableTickets: json['hasAvailableTickets'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFree: json['isFree'] as bool?,
      isOnlineEvent: json['isOnlineEvent'] as bool?,
      isSoldOut: json['isSoldOut'] as bool?,
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      title: json['title'] as String?,
      organizer: json['organizer'] == null
          ? null
          : Organizer.fromJson(json['organizer'] as Map<String, dynamic>),
      publishedDate: json['publishedDate'] == null
          ? null
          : DateTime.parse(json['publishedDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      venue: json['venue'] == null
          ? null
          : Venue.fromJson(json['venue'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventCompleteToJson(_$_EventComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endDate': instance.endDate?.toIso8601String(),
      'hasAvailableTickets': instance.hasAvailableTickets,
      'imageUrl': instance.imageUrl,
      'imageUrls': instance.imageUrls,
      'isFree': instance.isFree,
      'isOnlineEvent': instance.isOnlineEvent,
      'isSoldOut': instance.isSoldOut,
      'maxPrice': instance.maxPrice,
      'minPrice': instance.minPrice,
      'title': instance.title,
      'organizer': instance.organizer,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'description': instance.description,
      'tags': instance.tags,
      'venue': instance.venue,
      'source': instance.source,
    };

_$_Organizer _$$_OrganizerFromJson(Map<String, dynamic> json) => _$_Organizer(
      organizerId: json['organizerId'] as String?,
      title: json['title'] as String?,
      numFollowers: json['numFollowers'] as int?,
      description: json['description'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
    );

Map<String, dynamic> _$$_OrganizerToJson(_$_Organizer instance) =>
    <String, dynamic>{
      'organizerId': instance.organizerId,
      'title': instance.title,
      'numFollowers': instance.numFollowers,
      'description': instance.description,
      'websiteUrl': instance.websiteUrl,
    };

_$_Source _$$_SourceFromJson(Map<String, dynamic> json) => _$_Source(
      id: json['id'] as String?,
      organizerId: json['organizerId'] as String?,
      url: json['url'] as String?,
      venueId: json['venueId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_SourceToJson(_$_Source instance) => <String, dynamic>{
      'id': instance.id,
      'organizerId': instance.organizerId,
      'url': instance.url,
      'venueId': instance.venueId,
      'name': instance.name,
    };

_$_Venue _$$_VenueFromJson(Map<String, dynamic> json) => _$_Venue(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      venueId: json['venueId'] as String?,
      title: json['title'] as String?,
      latLng: json['latLng'] == null
          ? null
          : LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_VenueToJson(_$_Venue instance) => <String, dynamic>{
      'address': instance.address,
      'venueId': instance.venueId,
      'title': instance.title,
      'latLng': instance.latLng,
    };

_$_Address _$$_AddressFromJson(Map<String, dynamic> json) => _$_Address(
      city: json['city'] as String?,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      localizedAddressDisplay: json['localizedAddressDisplay'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      postalCode: json['postalCode'] as String?,
      region: json['region'] as String?,
    );

Map<String, dynamic> _$$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'latitude': instance.latitude,
      'localizedAddressDisplay': instance.localizedAddressDisplay,
      'longitude': instance.longitude,
      'postalCode': instance.postalCode,
      'region': instance.region,
    };
