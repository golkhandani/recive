import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/package_page/package_detail_screen.dart';
import 'package:recive/features/package_page/packages_screen.dart';
import 'package:recive/features/package_page/widgets/art_route_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class ArtRouteExpandedCardContainer extends HookWidget {
  const ArtRouteExpandedCardContainer({
    super.key,
    required this.data,
  });
  final ArtRouteContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.surface;
    final fontColor = context.colorScheme.onSurface;

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
        borderRadius: BorderRadius.circular(16),
        padding: kTinyPadding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
                    placeholder: (context, _) => const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          opacity: 0.9,
                        ),
                        borderRadius: BorderRadius.circular(8),
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
                    style: context.textTheme.titleMedium?.withColor(fontColor),
                  ),
                  collapsed: Text(
                    data.subtitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.withColor(fontColor),
                  ),
                  expanded: Text(
                    data.description,
                    softWrap: true,
                    style: context.textTheme.bodyMedium?.withColor(fontColor),
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