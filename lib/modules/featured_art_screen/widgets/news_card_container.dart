import 'dart:math';
import 'dart:ui';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/detail_art_screen/detail_art_page.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_page.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class NewsCardContainer extends StatelessWidget {
  const NewsCardContainer({
    super.key,
    required this.data,
    required this.constraints,
    this.hero,
    this.parentPathParams = const {},
  });

  final BoxConstraints constraints;
  final NewsCardContainerData data;
  final String? hero;
  final Map<String, String> parentPathParams;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorTheme.secondary;
    final fontColor = context.colorTheme.onSecondary;
    final heroTag = hero ?? DateTime.now().toString() + Random().nextInt(200).toString();

    final extraJson = ExtraData(
      summary: ArtDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());

    final child = LayoutBuilder(builder: (context, box) {
      final isBig = MediaQuery.sizeOf(context).width / 2 < box.maxWidth;
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < box.maxHeight / 1;

      if (isBig && !isSmallTall) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: kSmallBorderRadius,
              child: Container(
                // color: color,
                padding: const EdgeInsets.all(8).copyWith(top: 32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      color,
                      color.withOpacity(0.9),
                      color.withOpacity(0.7),
                      color.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      style:
                          context.typographyTheme.titleSmall.textStyle.withColor(fontColor),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.abc,
                          color: fontColor,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            data.location,
                            maxLines: isSmallTall ? 3 : 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.typographyTheme.subtitleSmall.textStyle
                                .withColor(fontColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      if (isSmallTall && !isSmall) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: kSmallBorderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        color,
                        color.withOpacity(0.9),
                        color.withOpacity(0.7),
                        color.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8).copyWith(top: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style:
                            context.typographyTheme.titleTiny.textStyle.withColor(fontColor),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.abc,
                            color: fontColor,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              data.location,
                              maxLines: isSmallTall ? 3 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographyTheme.subtitleTiny.textStyle
                                  .withColor(fontColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: kSmallBorderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                width: box.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color,
                      color.withOpacity(0.9),
                      color.withOpacity(0.7),
                      color.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8).copyWith(bottom: 32),
                child: Text(
                  data.title,
                  maxLines: 2,
                  style: context.typographyTheme.subtitleLarge.textStyle.withColor(fontColor),
                ),
              ),
            ),
          ),
        ],
      );
    });

    return RepaintBoundary(
      child: InkWell(
        onTap: () => {
          navigationService.pushTo(
            NearMeScreen.name + ArtDetailScreen.name,
            pathParameters: {
              ...parentPathParams,
              ArtDetailScreen.pathParamId: data.id,
            },
            extra: extraJson,
          ),
        },
        child: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: data.imageUrl,
            imageBuilder: (context, imageProvider) => _buildCard(imageProvider, color, child),
            placeholder: (context, url) => _buildLoading(color),
            errorWidget: (context, url, error) => _buildCard(null, color, child),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(Color color) {
    return const Center(
        child: SizedBox(height: 48, width: 48, child: CircularProgressIndicator()));
  }

  Widget _buildCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Material(
      elevation: 1,
      borderRadius: kSmallBorderRadius,
      child: Container(
        constraints: constraints,
        decoration: BoxDecoration(
          image: imageProvider == null
              ? null
              : DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  opacity: 0.9,
                ),
          borderRadius: kSmallBorderRadius,
          color: Colors.black,
        ),
        child: child,
      ),
    );
  }
}

class NewsCardContainerData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;

  NewsCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  static NewsCardContainerData fromAbstractArt(NewsAbstractModel e) {
    return NewsCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      location: e.location,
      imageUrl: e.imageUrl,
    );
  }
}
