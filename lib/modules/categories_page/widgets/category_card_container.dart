import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/modules/categories_page/categories_screen.dart';
import 'package:recive/modules/categories_page/category_detail_screen.dart';
import 'package:recive/modules/categories_page/widgets/category_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';

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
            style: context.textTheme.titleTiny.onSecondaryContainer.style,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.textTheme.subtitleLarge.onSecondaryContainer.style,
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

    return RepaintBoundary(
      child: InkWell(
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
            imageBuilder: (context, imageProvider) =>
                _buildCategoryCard(imageProvider, color, child),
            placeholder: (context, url) => _buildCategoryLoading(color),
            errorWidget: (context, url, error) =>
                _buildCategoryCard(null, color, child),
          ),
        ),
      ),
    );
  }

  Container _buildCategoryLoading(Color color) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: kSmallBorderRadius,
        color: color,
      ),
      child: kSkeletonLoadingBox,
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
        borderRadius: kSmallBorderRadius,
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
