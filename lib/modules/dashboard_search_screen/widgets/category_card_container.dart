import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/card_size.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';

import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoryCardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final CategoryAbstractModel data;
  final String? hero;
  final VoidCallback onTap;
  final CardSize size;
  const CategoryCardContainer._({
    required this.data,
    required this.constraints,
    this.hero,
    required this.onTap,
    required this.size,
  });

  factory CategoryCardContainer.big({
    required CategoryAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CategoryCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.big,
    );
  }

  // Factory constructor for small tall cards
  factory CategoryCardContainer.medium({
    required CategoryAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CategoryCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.medium,
    );
  }

  // Factory constructor for small cards
  factory CategoryCardContainer.small({
    required CategoryAbstractModel data,
    required BoxConstraints constraints,
    String? hero,
    required VoidCallback onTap,
  }) {
    return CategoryCardContainer._(
      data: data,
      constraints: constraints,
      hero: hero,
      onTap: onTap,
      size: CardSize.small,
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

  Widget _buildBigCard(BuildContext context, Color color, Color fontColor) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: kExtraTinyPadding,
        padding: kTinyPadding,
        decoration: BoxDecoration(
          color: context.colorTheme.primaryContainer.withOpacity(kTinyOpacity),
          borderRadius: kSmallBorderRadius,
        ),
        child: Text(
          data.title,
          style: context.typographyTheme.subtitleMedium.textStyle,
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context, Color color, Color fontColor) {
    Widget child = const SizedBox();

    switch (size) {
      case CardSize.big:
      case CardSize.medium:
      case CardSize.small:
        child = _buildBigCard(context, color, fontColor);
        break;
      default:
    }
    return child;
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

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.secondary;
    final fontColor = context.colorTheme.onSecondary;
    final child = _buildChild(context, color, fontColor);

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: kSmallBorderRadius,
        child: Material(
          elevation: kMediumElevation,
          borderRadius: kSmallBorderRadius,
          child: Hero(
            tag: data.heroTag,
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              fadeOutDuration: const Duration(milliseconds: 3000),
              imageBuilder: (context, imageProvider) =>
                  _buildCard(imageProvider, color, child),
              placeholder: (context, url) => _buildLoading(color),
              filterQuality: FilterQuality.high,
              errorWidget: (context, url, error) => _buildCard(null, color, child),
            ),
          ),
        ),
      ),
    );
  }
}
