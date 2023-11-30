// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtModelImpl _$$ArtModelImplFromJson(Map<String, dynamic> json) =>
    _$ArtModelImpl(
      id: json['id'] as String,
      artType: json['artType'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      material:
          (json['material'] as List<dynamic>).map((e) => e as String).toList(),
      originalId: json['originalId'] as int,
      originalUrl: json['originalUrl'] as String,
      ownership: json['ownership'] as String,
      source: SourceModel.fromJson(json['source'] as Map<String, dynamic>),
      statement: json['statement'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$$ArtModelImplToJson(_$ArtModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artType': instance.artType,
      'artists': instance.artists,
      'description': instance.description,
      'images': instance.images,
      'location': instance.location,
      'material': instance.material,
      'originalId': instance.originalId,
      'originalUrl': instance.originalUrl,
      'ownership': instance.ownership,
      'source': instance.source,
      'statement': instance.statement,
      'tags': instance.tags,
      'title': instance.title,
    };

_$ArtistModelImpl _$$ArtistModelImplFromJson(Map<String, dynamic> json) =>
    _$ArtistModelImpl(
      typename: json['typename'] as String,
      id: json['id'] as String,
      biography: json['biography'] as String,
      country: json['country'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      originalId: json['originalId'] as int,
      website: json['website'] as String,
    );

Map<String, dynamic> _$$ArtistModelImplToJson(_$ArtistModelImpl instance) =>
    <String, dynamic>{
      'typename': instance.typename,
      'id': instance.id,
      'biography': instance.biography,
      'country': instance.country,
      'images': instance.images,
      'name': instance.name,
      'originalId': instance.originalId,
      'website': instance.website,
    };

_$ImageModelImpl _$$ImageModelImplFromJson(Map<String, dynamic> json) =>
    _$ImageModelImpl(
      typename: json['typename'] as String,
      id: json['id'] as String,
      imageCredit: json['imageCredit'] as String,
      imageData: json['imageData'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$ImageModelImplToJson(_$ImageModelImpl instance) =>
    <String, dynamic>{
      'typename': instance.typename,
      'id': instance.id,
      'imageCredit': instance.imageCredit,
      'imageData': instance.imageData,
      'imageUrl': instance.imageUrl,
    };

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      geolocation: GeolocationModel.fromJson(
          json['geolocation'] as Map<String, dynamic>),
      venue: VenueModel.fromJson(json['venue'] as Map<String, dynamic>),
      latLng: LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'geolocation': instance.geolocation,
      'venue': instance.venue,
      'latLng': instance.latLng,
    };

_$GeolocationModelImpl _$$GeolocationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GeolocationModelImpl(
      typename: json['typename'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$GeolocationModelImplToJson(
        _$GeolocationModelImpl instance) =>
    <String, dynamic>{
      'typename': instance.typename,
      'coordinates': instance.coordinates,
      'type': instance.type,
    };

_$VenueModelImpl _$$VenueModelImplFromJson(Map<String, dynamic> json) =>
    _$VenueModelImpl(
      typename: json['typename'] as String,
      id: json['id'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      geolocation: GeolocationModel.fromJson(
          json['geolocation'] as Map<String, dynamic>),
      osmId: json['osmId'] as int,
      osmLicence: json['osmLicence'] as String,
      osmVenueId: json['osmVenueId'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$VenueModelImplToJson(_$VenueModelImpl instance) =>
    <String, dynamic>{
      'typename': instance.typename,
      'id': instance.id,
      'address': instance.address,
      'geolocation': instance.geolocation,
      'osmId': instance.osmId,
      'osmLicence': instance.osmLicence,
      'osmVenueId': instance.osmVenueId,
      'title': instance.title,
    };

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      area: json['area'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      localizedAddressDisplay: json['localizedAddressDisplay'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      postalCode: json['postalCode'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'city': instance.city,
      'country': instance.country,
      'latitude': instance.latitude,
      'localizedAddressDisplay': instance.localizedAddressDisplay,
      'longitude': instance.longitude,
      'postalCode': instance.postalCode,
      'region': instance.region,
    };

_$SourceModelImpl _$$SourceModelImplFromJson(Map<String, dynamic> json) =>
    _$SourceModelImpl(
      id: json['id'] as String,
      copyRight: json['copyRight'] as String,
      dataUrl: json['dataUrl'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$SourceModelImplToJson(_$SourceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'copyRight': instance.copyRight,
      'dataUrl': instance.dataUrl,
      'name': instance.name,
    };
