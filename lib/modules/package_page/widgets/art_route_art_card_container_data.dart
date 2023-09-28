import 'package:recive/modules/featured_page/models/art_abstract_model.dart';
import 'package:recive/modules/featured_page/models/art_model.dart';

class ArtRouteArtCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final List<String> roadInstructions;

  ArtRouteArtCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.roadInstructions,
  });

  static ArtRouteArtCardContainerData fromArtAbstract(
    ArtAbstractModel e,
    List<String>? instructions,
  ) {
    return ArtRouteArtCardContainerData(
        id: e.id,
        title: e.title,
        description: e.description,
        location: e.location,
        imageUrl: e.imageUrl,
        roadInstructions: instructions ?? []);
  }

  static ArtRouteArtCardContainerData fromArt(
    ArtModel e,
    List<String>? instructions,
  ) {
    return ArtRouteArtCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location.venue.address.localizedAddressDisplay,
      imageUrl: e.images.first.imageUrl,
      roadInstructions: instructions ?? [],
    );
  }
}
