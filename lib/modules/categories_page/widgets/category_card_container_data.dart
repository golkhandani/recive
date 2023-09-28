import 'package:recive/modules/categories_page/models/category.dart';

class CategoryCardContainerData {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  CategoryCardContainerData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  static CategoryCardContainerData fromCategory(Category c) =>
      CategoryCardContainerData(
        id: c.id,
        title: c.title,
        subtitle: c.subtitle,
        description: c.description,
        imageUrl: c.imageUrl,
      );
}
