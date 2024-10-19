import 'dart:math';
import 'dart:ui';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ArtistCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final ArtistCardContainerData data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  const ArtistCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
  });

  factory ArtistCardContainer.big({
    required ArtistCardContainerData data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return ArtistCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
    );
  }

  // Factory constructor for small tall cards
  factory ArtistCardContainer.medium({
    required ArtistCardContainerData data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return ArtistCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory ArtistCardContainer.small({
    required ArtistCardContainerData data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return ArtistCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.small,
    );
  }

  Widget _buildLoading(Color color) {
    return const Center(
      child: SizedBox(
        height: 48,
        width: 48,
        child: CircularProgressIndicator(),
      ),
    );
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

  Widget _buildBigCard(BuildContext context, Color color, Color fontColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: kSmallBorderRadius,
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data.name,
                  maxLines: 1,
                  style: context.typographyTheme.titleSmall.textStyle.withColor(fontColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediumCard(BuildContext context, Color color, Color fontColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: kSmallBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              width: constraints.maxWidth,
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
                data.name,
                maxLines: 2,
                style: context.typographyTheme.subtitleLarge.textStyle.withColor(fontColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(BuildContext context, Color color, Color fontColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: kSmallBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              width: constraints.maxWidth,
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
                data.name,
                maxLines: 2,
                style: context.typographyTheme.subtitleLarge.textStyle.withColor(fontColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChild(BuildContext context, Color color, Color fontColor) {
    Widget child = const SizedBox();

    switch (size) {
      case CardSize.big:
        child = _buildBigCard(context, color, fontColor);
        break;
      case CardSize.medium:
        child = _buildMediumCard(context, color, fontColor);
        break;
      case CardSize.small:
        child = _buildSmallCard(context, color, fontColor);
        break;
      default:
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = hero ?? DateTime.now().toString() + Random().nextInt(200).toString();
    final color = context.colorTheme.secondary;
    final fontColor = context.colorTheme.onSecondary;
    final child = _buildChild(context, color, fontColor);

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
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
}
