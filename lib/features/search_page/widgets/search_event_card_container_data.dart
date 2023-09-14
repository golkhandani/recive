import 'package:latlong2/latlong.dart';

import 'package:recive/features/near_me_page/models/event_complete.dart';

class SearchEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final LatLng latlng;

  SearchEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
    required this.latlng,
  });

  static SearchEventCardContainerData fromEventComplete(EventComplete e) {
    return SearchEventCardContainerData(
      id: e.id!,
      title: e.title ?? '',
      description: e.description ?? '',
      startDate: e.startDate!,
      endDate: e.endDate!,
      location: e.venue?.address?.localizedAddressDisplay ?? '',
      organizers: [e.organizer?.title ?? ''],
      participants: [],
      imageUrl: e.imageUrl!,
      latlng: e.venue?.latLng ?? const LatLng(0, 0),
    );
  }
}
