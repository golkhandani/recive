import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NewsCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final NewsAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  const NewsCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
  });

  factory NewsCardContainer.big({
    required NewsAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return NewsCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
    );
  }

  // Factory constructor for small tall cards
  factory NewsCardContainer.medium({
    required NewsAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return NewsCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory NewsCardContainer.small({
    required NewsAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return NewsCardContainer._(
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
  ) {
    return Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = hero ?? DateTime.now().toString() + Random().nextInt(200).toString();
    final color = context.colorTheme.secondary;
    // final child = Stack(
    //   children: [
    //     Positioned(
    //       left: 0,
    //       right: 0,
    //       top: kExtraTinyPadding.top,
    //     ),
    //   ],
    // );

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: kSmallBorderRadius,
        child: Container(
          constraints: constraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Material(
                  borderRadius: kSmallBorderRadius,
                  elevation: kMediumElevation,
                  child: Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: data.imageUrl,
                      imageBuilder: (context, imageProvider) => _buildCard(imageProvider),
                      placeholder: (context, url) => _buildLoading(color),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kExtraTinyPadding.bottom),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: constraints.maxWidth, height: 32),
                child: Text(
                  data.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: context.typographyTheme.onBackground.subtitleMedium.textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
