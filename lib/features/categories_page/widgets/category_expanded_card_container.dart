import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/categories_page/category_detail_screen.dart';
import 'package:recive/features/categories_page/widgets/category_card_container.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class CategoryExpandedCardContainer extends HookWidget {
  const CategoryExpandedCardContainer({
    super.key,
    required this.data,
  });
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final heroTag = CategoryDetailScreen.name + data.id;
    final extra = ExtraData<CategorySummaryData>(
      summary: CategorySummaryData(
        id: data.id,
        imageUrl: data.imageUrl,
        title: data.title,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
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
            InkWell(
              onTap: () => navigationService.navigateTo(
                CategoriesScreen.name + CategoryDetailScreen.name,
                pathParameters: {
                  CategoryDetailScreen.pathParamId: data.id,
                },
                extra: extra,
              ),
              child: Hero(
                tag: heroTag,
                child: CachedNetworkImage(
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
