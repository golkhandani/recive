import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/models/recive.model.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

final List<String> images = [
  'https://source.unsplash.com/random/?city,night',
  'https://source.unsplash.com/random/?nature,forest',
  'https://source.unsplash.com/random/?technology,code',
  'https://source.unsplash.com/random/?food,dish',
  'https://source.unsplash.com/random/?architecture,building',
  'https://source.unsplash.com/random/?travel,adventure',
  'https://source.unsplash.com/random/?fashion,clothing',
  'https://source.unsplash.com/random/?art,painting',
  'https://source.unsplash.com/random/?sports,fitness',
  'https://source.unsplash.com/random/?music,instrument',
  // Add more image URLs here...
];

List<CategoryCardContainerData> mockCategoriesData = [
  CategoryCardContainerData(
    id: 'c7e4db9e-9377-4e52-9b26-3b03d2fb4d81',
    title: 'Technology',
    subtitle: 'Latest gadgets and innovations',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: '0d6d8c3e-6f61-4c9a-9a79-1d7eb77aa2ec',
    title: 'Health & Fitness',
    subtitle: 'Tips for a healthier lifestyle',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: 'b72e0c4b-82d2-4e90-9e68-2656cc7b1c1c',
    title: 'Travel',
    subtitle: 'Exploring the world, one destination at a time',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: 'f7a15f98-8904-42fc-82b2-76a6b53ec9f1',
    title: 'Food & Cooking',
    subtitle: 'Delicious recipes and culinary adventures',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: 'de7549b6-6c91-4b0b-b81c-60b7e43a31d8',
    title: 'Fashion',
    subtitle: 'Trends, styles, and outfit inspiration',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: 'fe9b7644-1706-4cb5-9652-4e4331d81c84',
    title: 'Home Decor',
    subtitle: 'Ideas for decorating and organizing your space',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: '142e0290-2c52-4a79-9e44-4488953c1557',
    title: 'Finance',
    subtitle: 'Managing money and achieving financial goals',
    description: article,
    imageUrl: categoryImage,
  ),
  CategoryCardContainerData(
    id: 'a0858c8c-ef9e-4ebc-a762-eb4eb0b1263f',
    title: 'Parenting',
    subtitle: 'Guidance and support for parents',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: '5788b31a-0a50-4a4f-9d6b-30b0a7ff0d8f',
    title: 'Art & Culture',
    subtitle: 'Exploring creativity in various forms',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
  CategoryCardContainerData(
    id: '48f55a08-8e75-48f7-a8da-39c14732f9e6',
    title: 'Science',
    subtitle: 'Discoveries and advancements in the scientific world',
    description: article,
    imageUrl: images[Random().nextInt(images.length)],
  ),
];

class HomePageCategoriesSection extends StatefulHookWidget {
  const HomePageCategoriesSection({
    super.key,
  });

  @override
  State<HomePageCategoriesSection> createState() =>
      _HomePageCategoriesSectionState();
}

class _HomePageCategoriesSectionState extends State<HomePageCategoriesSection> {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Event Categories",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              return SizedBox(
                height: 76,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategoriesData.length + 1,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      if (index == mockCategoriesData.length) {
                        return SeeMoreButton(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 2,
                          ),
                          onTap: () => navigationService.navigateTo(
                            CategoriesScreen.name,
                          ),
                        );
                      }
                      final data = mockCategoriesData[index];
                      return CategoryCardContainer(
                        constraints: BoxConstraints.expand(
                          width: box.maxWidth / 2,
                        ),
                        data: data,
                      );
                    }),
              );
            }),
          ),
        ),
      ],
    );
  }
}

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
    final color = Color((Random().nextDouble() * 0xFFFF).toInt())
        .withOpacity(1.0)
        .withAlpha(255);
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: context.textTheme.titleLarge!.copyWith(
            color: context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.textTheme.labelSmall!.copyWith(
            color: context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () => navigationService.navigateTo(
        DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.category.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.category.name + data.id,
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
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
