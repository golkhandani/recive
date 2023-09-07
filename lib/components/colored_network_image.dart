import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ColoredNetworkImage extends StatelessWidget {
  const ColoredNetworkImage({
    super.key,
    required this.imageUrl,
    this.constraints,
    this.color,
    this.opacity = 1,
  });

  final String imageUrl;
  final BoxConstraints? constraints;
  final Color? color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        constraints: constraints ?? const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            opacity: opacity,
          ),
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
      ),
    );
  }
}
