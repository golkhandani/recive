import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'event_complete.freezed.dart';
part 'event_complete.g.dart';

@freezed
class EventComplete with _$EventComplete {
  const factory EventComplete({
    String? id,
    DateTime? endDate,
    bool? hasAvailableTickets,
    String? imageUrl,
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
    Source? source,
  }) = _EventComplete;

  factory EventComplete.fromJson(Map<String, dynamic> json) =>
      _$EventCompleteFromJson(json);
}

@freezed
class Organizer with _$Organizer {
  const factory Organizer({
    String? organizerId,
    String? title,
    int? numFollowers,
    String? description,
    String? websiteUrl,
  }) = _Organizer;

  factory Organizer.fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    String? id,
    String? organizerId,
    String? url,
    String? venueId,
    String? name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}

@freezed
class Venue with _$Venue {
  const factory Venue({
    Address? address,
    String? venueId,
    String? title,
    LatLng? latLng,
  }) = _Venue;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? city,
    String? country,
    double? latitude,
    String? localizedAddressDisplay,
    double? longitude,
    String? postalCode,
    String? region,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
