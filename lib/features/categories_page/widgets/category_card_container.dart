import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/features/categories_page/category_detail_screen.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

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

class CategoryCardContainer extends HookWidget {
  const CategoryCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.secondaryContainer;
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleLargeOnPrimaryContainer,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.labelSmallOnPrimaryContainer,
        ),
      ],
    );
    final heroTag = CategoryDetailScreen.name + data.id;
    final extra = ExtraData<CategorySummaryData>(
      summary: CategorySummaryData(
        id: data.id,
        imageUrl: data.imageUrl,
        title: data.title,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());

    return InkWell(
      onTap: () => navigationService.navigateTo(
        HomeScreen.name + CategoryDetailScreen.name,
        pathParameters: {
          CategoryDetailScreen.pathParamId: data.id,
        },
        extra: extra,
      ),
      child: Hero(
        tag: heroTag,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildCategoryCard(imageProvider, color, child),
          placeholder: (context, url) => _buildCategoryLoading(color),
          errorWidget: (context, url, error) =>
              _buildCategoryCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildCategoryLoading(Color color) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildCategoryCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Column child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.2),
            color.darken(),
          ],
        ),
      ),
      padding: kTinyPadding,
      child: child,
    );
  }
}
