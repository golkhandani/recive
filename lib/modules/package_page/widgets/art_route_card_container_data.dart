import 'package:recive/modules/package_page/models/art_route_model.dart';

class ArtRouteContainerData {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  ArtRouteContainerData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  static ArtRouteContainerData fromAbstract(ArtRouteAbstractModel c) =>
      ArtRouteContainerData(
        id: c.id,
        title: c.title,
        subtitle: c.subtitle,
        description: c.description,
        imageUrl: c.imageUrl,
      );
}
