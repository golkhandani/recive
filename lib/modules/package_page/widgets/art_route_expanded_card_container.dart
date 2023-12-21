import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/modules/package_page/package_detail_screen.dart';
import 'package:recive/modules/package_page/packages_screen.dart';
import 'package:recive/modules/package_page/widgets/art_route_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';

class ArtRouteExpandedCardContainer extends HookWidget {
  const ArtRouteExpandedCardContainer({
    super.key,
    required this.data,
  });
  final ArtRouteContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.secondary;
    final fontColor = context.colorScheme.onSecondary;

    final heroTag = PackageDetailScreen.name + data.id;
    final extra = ExtraData<PackageSummaryData>(
      summary: PackageSummaryData(
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
                  PackagesScreen.name + PackageDetailScreen.name,
                  pathParameters: {
                    PackageDetailScreen.pathParamId: data.id,
                  },
                  extra: extra,
                ),
                child: Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: data.imageUrl,
                    placeholder: (context, _) => SizedBox(
                      height: 280,
                      child: kSkeletonLoadingBox,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 280,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text(
                    data.title,
                    style: context.textTheme.title3.withColor(fontColor).style,
                  ),
                  collapsed: Text(
                    data.subtitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.body2.withColor(fontColor).style,
                  ),
                  expanded: Text(
                    data.description,
                    softWrap: true,
                    style: context.textTheme.body2.withColor(fontColor).style,
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
