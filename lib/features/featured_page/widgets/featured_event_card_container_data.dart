import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';

class FeaturedArtCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;

  FeaturedArtCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  static FeaturedArtCardContainerData fromFeaturedEvent(ArtAbstractModel e) {
    return FeaturedArtCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      imageUrl: e.imageUrl,
    );
  }

  static FeaturedArtCardContainerData fromEventComplete(ArtModel e) {
    return FeaturedArtCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location.venue.address.localizedAddressDisplay,
      imageUrl: e.images.first.imageUrl,
    );
  }
}
