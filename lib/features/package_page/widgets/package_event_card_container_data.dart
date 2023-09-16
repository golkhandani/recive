import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';

class PackageEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final List<String> roadInstructions;

  PackageEventCardContainerData(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.organizers,
      required this.participants,
      required this.imageUrl,
      required this.roadInstructions});

  static PackageEventCardContainerData fromNearbyEvent(
      NearbyEvent e, List<String>? instructions) {
    return PackageEventCardContainerData(
        id: e.id,
        title: e.title,
        description: e.description,
        location: e.location,
        organizers: e.organizers,
        participants: e.participants,
        imageUrl: e.imageUrl,
        roadInstructions: instructions ?? []);
  }

  static PackageEventCardContainerData fromEventComplete(
    ArtModel e,
    List<String>? instructions,
  ) {
    return PackageEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location.venue.address.localizedAddressDisplay,
      organizers: [],
      participants: [],
      imageUrl: e.images.first.imageUrl,
      roadInstructions: instructions ?? [],
    );
  }
}
