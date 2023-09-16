import 'package:latlong2/latlong.dart';

import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';

class SearchEventCardContainerData {
  final String id;
  final String title;
  final String description;

  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final LatLng latlng;

  SearchEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
    required this.latlng,
  });

  static SearchEventCardContainerData fromEventComplete(ArtModel e) {
    return SearchEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location.venue.address.localizedAddressDisplay,
      organizers: [],
      participants: [],
      imageUrl: e.images.first.imageUrl,
      latlng: e.location.latLng,
    );
  }

  static SearchEventCardContainerData fromFeaturedEvent(ArtAbstractModel e) {
    return SearchEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      organizers: [],
      participants: [],
      imageUrl: e.imageUrl,
      latlng: const LatLng(0, 0),
    );
  }
}
