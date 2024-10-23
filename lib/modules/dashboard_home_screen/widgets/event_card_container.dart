import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/extensions/string_color_extension.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EventCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final EventAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  const EventCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
  });

  factory EventCardContainer.big({
    required EventAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return EventCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
    );
  }

  // Factory constructor for small tall cards
  factory EventCardContainer.medium({
    required EventAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return EventCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory EventCardContainer.small({
    required EventAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return EventCardContainer._(
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

  @override
  Widget build(BuildContext context) {
    final heroTag = hero ?? DateTime.now().toString() + Random().nextInt(200).toString();
    final color = context.colorTheme.secondary;
    final bannerColor = data.eventType.toColor();
    final child = Stack(
      children: [
        Positioned(
          right: -30,
          top: 30,
          child: Transform.rotate(
            angle: 45 * pi / 180,
            child: Container(
              height: 20,
              width: 150,
              color: bannerColor,
              child: Center(
                child: Text(
                  data.eventType,
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
              style: context.typographyTheme.subtitleMedium.textStyle,
            ),
          ),
        ),
      ],
    );

    return RepaintBoundary(
      child: InkWell(
        borderRadius: kSmallBorderRadius,
        onTap: onTap,
        child: Material(
          borderRadius: kSmallBorderRadius,
          elevation: kMediumElevation,
          child: ClipRRect(
            borderRadius: kSmallBorderRadius,
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
      ),
    );
  }
}
