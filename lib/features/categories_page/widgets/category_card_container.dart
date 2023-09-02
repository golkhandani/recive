import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/features/home_page/sections/category_section.dart';
import 'package:recive/layout/context_ui_extension.dart';

class CategoryExpandedCardContainer extends StatelessWidget {
  const CategoryExpandedCardContainer({
    super.key,
    required this.data,
  });
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.colorScheme.background,
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: data.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandablePanel(
                header: Text(
                  data.title,
                  style: context.textTheme.titleMedium,
                ),
                collapsed: Text(
                  data.subtitle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium,
                ),
                expanded: Text(
                  data.description,
                  softWrap: true,
                ),
                theme: ExpandableThemeData(
                  iconSize: 20,
                  iconPadding: const EdgeInsets.only(bottom: 12),
                  iconColor: context.theme.colorScheme.onBackground,
                  animationDuration: const Duration(milliseconds: 200),
                  useInkWell: true,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
