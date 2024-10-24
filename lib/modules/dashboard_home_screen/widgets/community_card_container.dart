import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommunityCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final CommunityAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  const CommunityCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
  });

  factory CommunityCardContainer.big({
    required CommunityAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CommunityCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
    );
  }

  // Factory constructor for small tall cards
  factory CommunityCardContainer.medium({
    required CommunityAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CommunityCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory CommunityCardContainer.small({
    required CommunityAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CommunityCardContainer._(
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
        const ShimmerEffect(duration: kShimmerDuration),
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
      elevation: 2,
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
    final heroTag = hero ?? DateTime.now().toString() + Random().nextInt(200).toString();
    final color = context.colorTheme.secondary;
    final child = Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            margin: kExtraTinyPadding,
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
          child: Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              imageBuilder: (context, imageProvider) =>
                  _buildCard(imageProvider, color, child),
              placeholder: (context, url) => _buildLoading(color),
              errorWidget: (context, url, error) => _buildCard(null, color, child),
            ),
          ),
        ),
      ),
    );
  }
}
