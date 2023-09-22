import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';

class PackageEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final List<String> roadInstructions;

  PackageEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.roadInstructions,
  });

  static PackageEventCardContainerData fromNearbyEvent(
      ArtAbstractModel e, List<String>? instructions) {
    return PackageEventCardContainerData(
        id: e.id,
        title: e.title,
        description: e.description,
        location: e.location,
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
      imageUrl: e.images.first.imageUrl,
      roadInstructions: instructions ?? [],
    );
  }
}
