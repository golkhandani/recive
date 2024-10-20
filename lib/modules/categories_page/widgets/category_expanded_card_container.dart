import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/modules/categories_page/categories_screen.dart';
import 'package:recive/modules/categories_page/category_detail_screen.dart';
import 'package:recive/modules/categories_page/widgets/category_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';

class CategoryExpandedCardContainer extends HookWidget {
  const CategoryExpandedCardContainer({
    super.key,
    required this.data,
  });
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorTheme.secondary;
    final fontColor = context.colorTheme.onSecondary;
    final heroTag = CategoryDetailScreen.name + data.id;
    final extra = ExtraData<CategorySummaryData>(
      summary: CategorySummaryData(
        id: data.id,
        imageUrl: data.imageUrl,
        title: data.title,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
    return RepaintBoundary(
      child: CardContainer(
        borderRadius: kMediumBorderRadius,
        padding: kTinyPadding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: kSmallBorderRadius,
            color: color,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => navigationService.pushTo(
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
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          opacity: 0.9,
                        ),
                        borderRadius: kSmallBorderRadius,
                        color: color,
                      ),
                    ),
                    placeholder: (context, url) => kSkeletonLoadingBox,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text(
                    data.title,
                    style:
                        context.textTheme.titleSmall.withColor(fontColor).style,
                  ),
                  collapsed: Text(
                    data.subtitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        context.textTheme.bodyMedium.withColor(fontColor).style,
                  ),
                  expanded: Text(
                    data.description,
                    softWrap: true,
                    style:
                        context.textTheme.bodyMedium.withColor(fontColor).style,
                  ),
                  theme: ExpandableThemeData(
                    iconSize: 20,
                    iconPadding: const EdgeInsets.only(bottom: 12),
                    iconColor: fontColor,
                    animationDuration: const Duration(milliseconds: 200),
                    useInkWell: true,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
