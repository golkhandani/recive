import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/extensions/string_color_extension.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ArtCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final ArtAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final void Function(bool)? onLikeClicked;
  final void Function(bool)? onSaveClicked;
  final CardSize size;
  final bool showBanner;
  const ArtCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
    this.showBanner = false,
    this.onLikeClicked,
    this.onSaveClicked,
  });

  factory ArtCardContainer.big({
    required ArtAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
    void Function(bool)? onLikeClicked,
    void Function(bool)? onSaveClicked,
  }) {
    return ArtCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
      showBanner: true,
      onLikeClicked: onLikeClicked,
      onSaveClicked: onSaveClicked,
    );
  }

  // Factory constructor for small tall cards
  factory ArtCardContainer.medium({
    required ArtAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
    void Function(bool)? onLikeClicked,
    void Function(bool)? onSaveClicked,
  }) {
    return ArtCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
      onLikeClicked: onLikeClicked,
      onSaveClicked: onSaveClicked,
    );
  }

  // Factory constructor for small cards
  factory ArtCardContainer.small({
    required ArtAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
    void Function(bool)? onLikeClicked,
    void Function(bool)? onSaveClicked,
  }) {
    return ArtCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.small,
      onLikeClicked: onLikeClicked,
      onSaveClicked: onSaveClicked,
    );
  }

  Widget _buildLoading(Color color) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        color: color,
        borderRadius: kSmallBorderRadius,
      ),
    ).animate(
      effects: [
        const ShimmerEffect(
          duration: kShimmerDuration,
          padding: 0,
        ),
      ],
      onPlay: (controller) => controller.repeat(),
    );
  }

  Widget _buildCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Material(
      elevation: kTinyElevation,
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

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.secondary;
    final bannerColor = data.artType.toColor();
    final actions = [
      if (onLikeClicked != null) ...[
        GestureDetector(
          onTap: () {
            onLikeClicked?.call(!data.userInteraction.isLiked);
          },
          child: Icon(
            data.userInteraction.isLiked ? Icons.favorite : Icons.favorite_outline,
            color: context.colorTheme.error,
            size: kToolbarHeight / 2,
            shadows: [
              Shadow(
                color: context.colorTheme.error,
                blurRadius: kTinyPadding.bottom,
              ),
            ],
          ),
        ),
      ],
      if (onSaveClicked != null) ...[
        SizedBox(width: kTinyPadding.right),
        InkWell(
          onTap: () {
            onSaveClicked?.call(!data.userInteraction.isSaved);
          },
          child: Icon(
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: kTinyPadding.bottom,
              ),
            ],
            data.userInteraction.isSaved ? Icons.bookmark : Icons.bookmark_outline,
            color: Colors.white,
            size: kToolbarHeight / 2,
          ),
        ),
      ]
    ];

    final child = Stack(
      children: [
        Positioned(
          top: kTinyPadding.top,
          right: kTinyPadding.right,
          child: Row(
            children: actions,
          ),
        ),
        if (showBanner)
          Positioned(
            left: -36,
            top: 36,
            child: Transform.rotate(
              angle: -45 * pi / 180,
              child: Container(
                height: 20,
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: kLargePadding.left),
                color: bannerColor,
                child: Center(
                  child: Text(
                    data.artType,
                    overflow: TextOverflow.ellipsis,
                    style: context.typographyTheme.subtitleMedium
                        .copyWithColor(color: bannerColor.fontColor())
                        .textStyle,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: kExtraTinyPadding.left,
                  right: kExtraTinyPadding.right,
                  bottom: kExtraTinyPadding.bottom,
                ),
                padding: kTinyPadding,
                decoration: BoxDecoration(
                  color: context.colorTheme.primaryContainer.withOpacity(kTinyOpacity),
                  borderRadius: kSmallBorderRadius,
                ),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typographyTheme.onPrimaryContainer.subtitleMedium.textStyle,
                ),
              ),
              if (size != CardSize.small)
                Container(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  margin: EdgeInsets.only(
                    left: kExtraTinyPadding.left,
                    right: kExtraTinyPadding.right,
                    bottom: kExtraTinyPadding.bottom,
                  ),
                  padding: kTinyPadding,
                  decoration: BoxDecoration(
                    color: context.colorTheme.primaryContainer.withOpacity(kTinyOpacity),
                    borderRadius: kSmallBorderRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: context.colorTheme.onPrimaryContainer,
                      ),
                      SizedBox(
                        width: kExtraTinyPadding.right,
                      ),
                      LimitedBox(
                        maxWidth: constraints.maxWidth - 108,
                        child: Text(
                          data.location,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context
                              .typographyTheme.subtitleMedium.onPrimaryContainer.textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: kSmallBorderRadius,
        child: Material(
          borderRadius: kSmallBorderRadius,
          elevation: kMediumElevation,
          shadowColor: context.themeData.shadowColor,
          child: CachedNetworkImage(
            imageUrl: data.thumbnail.url,
            imageBuilder: (context, imageProvider) => _buildCard(imageProvider, color, child),
            placeholder: (context, url) => _buildLoading(color),
            errorWidget: (context, url, error) => _buildCard(null, color, child),
          ),
        ),
      ),
    );
  }
}

class SearchableOnMapCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final SearchableAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  final bool showBanner;
  const SearchableOnMapCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
    this.showBanner = false,
  });

  factory SearchableOnMapCardContainer.big({
    required SearchableAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return SearchableOnMapCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
      showBanner: true,
    );
  }

  // Factory constructor for small tall cards
  factory SearchableOnMapCardContainer.medium({
    required SearchableAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return SearchableOnMapCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory SearchableOnMapCardContainer.small({
    required SearchableAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return SearchableOnMapCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.small,
    );
  }

  Widget _buildLoading(Color color) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        color: color,
        borderRadius: kSmallBorderRadius,
      ),
    ).animate(
      effects: [
        const ShimmerEffect(
          duration: kShimmerDuration,
          padding: 0,
        ),
      ],
      onPlay: (controller) => controller.repeat(),
    );
  }

  Widget _buildCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Material(
      elevation: kTinyElevation,
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

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.secondary;
    final bannerColor = data.entityType.name.toColor();
    final child = Stack(
      children: [
        if (showBanner)
          Positioned(
            right: -36,
            top: 36,
            child: Transform.rotate(
              angle: 45 * pi / 180,
              child: Container(
                height: 20,
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: kLargePadding.left),
                color: bannerColor,
                child: Center(
                  child: Text(
                    data.entityType.name.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: context.typographyTheme.subtitleMedium
                        .copyWithColor(color: bannerColor.fontColor())
                        .textStyle,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: kExtraTinyPadding.left,
                  right: kExtraTinyPadding.right,
                  bottom: kExtraTinyPadding.bottom,
                ),
                padding: kTinyPadding,
                decoration: BoxDecoration(
                  color: context.colorTheme.primaryContainer.withOpacity(kTinyOpacity),
                  borderRadius: kSmallBorderRadius,
                ),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typographyTheme.onPrimaryContainer.subtitleMedium.textStyle,
                ),
              ),
              if (size != CardSize.small)
                Container(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  margin: EdgeInsets.only(
                    left: kExtraTinyPadding.left,
                    right: kExtraTinyPadding.right,
                    bottom: kExtraTinyPadding.bottom,
                  ),
                  padding: kTinyPadding,
                  decoration: BoxDecoration(
                    color: context.colorTheme.primaryContainer.withOpacity(kTinyOpacity),
                    borderRadius: kSmallBorderRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: context.colorTheme.onPrimaryContainer,
                      ),
                      SizedBox(
                        width: kExtraTinyPadding.right,
                      ),
                      LimitedBox(
                        maxWidth: constraints.maxWidth - 54,
                        child: Text(
                          data.geoLocation.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context
                              .typographyTheme.subtitleMedium.onPrimaryContainer.textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: kSmallBorderRadius,
        child: Material(
          borderRadius: kSmallBorderRadius,
          elevation: kMediumElevation,
          shadowColor: context.themeData.shadowColor,
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
}
