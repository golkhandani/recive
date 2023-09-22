import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'art_model.freezed.dart';
part 'art_model.g.dart';

@freezed
class ArtModel with _$ArtModel {
  const factory ArtModel({
    required String id,
    required String artType,
    required List<ArtistModel> artists,
    required String description,
    required List<ImageModel> images,
    required LocationModel location,
    required List<String> material,
    required int originalId,
    required String originalUrl,
    required String ownership,
    required SourceModel source,
    required String statement,
    required List<String> tags,
    required String title,
  }) = _ArtModel;

  factory ArtModel.fromJson(Map<String, dynamic> json) =>
      _$ArtModelFromJson(json);
}

@freezed
class ArtistModel with _$ArtistModel {
  const factory ArtistModel({
    required String typename,
    required String id,
    required String biography,
    required String country,
    required List<ImageModel> images,
    required String name,
    required int originalId,
    required String website,
  }) = _ArtistModel;

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
}

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
    required String typename,
    required String id,
    required String imageCredit,
    required String imageData,
    required String imageUrl,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required GeolocationModel geolocation,
    required VenueModel venue,
    required LatLng latLng,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

@freezed
class GeolocationModel with _$GeolocationModel {
  const factory GeolocationModel({
    required String typename,
    required List<double> coordinates,
    required String type,
  }) = _GeolocationModel;

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeolocationModelFromJson(json);
}

@freezed
class VenueModel with _$VenueModel {
  const factory VenueModel({
    required String typename,
    required String id,
    required AddressModel address,
    required GeolocationModel geolocation,
    required int osmId,
    required String osmLicence,
    required int osmVenueId,
    required String title,
  }) = _VenueModel;

  factory VenueModel.fromJson(Map<String, dynamic> json) =>
      _$VenueModelFromJson(json);
}

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    required String area,
    required String city,
    required String country,
    required double latitude,
    required String localizedAddressDisplay,
    required double longitude,
    required String postalCode,
    required String region,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@freezed
class SourceModel with _$SourceModel {
  const factory SourceModel({
    required String id,
    required String copyRight,
    required String dataUrl,
    required String name,
  }) = _SourceModel;

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);
}
