import 'package:recive/modules/featured_page/models/art_abstract_model.dart';

class ArtCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;

  ArtCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  static ArtCardContainerData fromAbstractArt(ArtAbstractModel e) {
    return ArtCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      imageUrl: e.imageUrl,
    );
  }
}
