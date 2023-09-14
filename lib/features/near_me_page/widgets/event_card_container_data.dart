import 'package:latlong2/latlong.dart';

import 'package:recive/features/near_me_page/models/nearby_event.dart';

class EventCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final LatLng latLng;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;

  EventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latLng,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });

  static EventCardContainerData fromFeaturedEvent(NearbyEvent e) {
    return EventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      organizers: e.organizers,
      participants: e.participants,
      imageUrl: e.imageUrl,
      latLng: e.latLng,
    );
  }
}
