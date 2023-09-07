import 'package:recive/features/package_page/models/package.dart';

class PackageCardContainerData {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  PackageCardContainerData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  static PackageCardContainerData fromPackage(Package c) =>
      PackageCardContainerData(
        id: c.id,
        title: c.title,
        subtitle: c.subtitle,
        description: c.description,
        imageUrl: c.imageUrl,
      );
}
