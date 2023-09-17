import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/package_page/models/package.dart';

class SearchEventCardContainerData {
  final String id;
  final String title;
  final String description;

  final String imageUrl;

  SearchEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  static SearchEventCardContainerData fromEventComplete(ArtModel e) {
    return SearchEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.images.first.imageUrl,
    );
  }

  static SearchEventCardContainerData fromPackageAbstract(PackageAbstract e) {
    return SearchEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.imageUrl,
    );
  }

  static SearchEventCardContainerData fromFeaturedEvent(ArtAbstractModel e) {
    return SearchEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      imageUrl: e.imageUrl,
    );
  }
}
