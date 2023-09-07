import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/package_page/package_detail_screen.dart';
import 'package:recive/features/package_page/widgets/package_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class PackageCardContainer extends HookWidget {
  const PackageCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final PackageCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.secondaryContainer;
    final fontColor = context.colorScheme.onSecondaryContainer;

    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleLargeOnPrimaryContainer.withColor(fontColor),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.labelSmallOnPrimaryContainer.withColor(fontColor),
        ),
      ],
    );
    final heroTag = PackageDetailScreen.name + data.id;
    final extra = ExtraData<PackageSummaryData>(
      summary: PackageSummaryData(
        id: data.id,
        imageUrl: data.imageUrl,
        title: data.title,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());

    return InkWell(
      onTap: () => navigationService.pushTo(
        HomeScreen.name + PackageDetailScreen.name,
        pathParameters: {
          PackageDetailScreen.pathParamId: data.id,
        },
        extra: extra,
      ),
      child: Hero(
        tag: heroTag,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildPackageCard(imageProvider, color, child),
          placeholder: (context, url) => _buildPackageLoading(color),
          errorWidget: (context, url, error) =>
              _buildPackageCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildPackageLoading(Color color) {
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

  Container _buildPackageCard(
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
