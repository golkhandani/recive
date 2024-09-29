import 'dart:math';
import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtOnMapCard extends StatelessWidget {
  const ArtOnMapCard({
    super.key,
    required this.data,
    this.parentPathParams = const {},
  });
  final Map<String, String> parentPathParams;
  final ArtAbstractModel data;

  Widget _buildLoading() {
    return const Center(
        child: SizedBox(height: 48, width: 48, child: CircularProgressIndicator()));
  }

  Widget _buildCard(
    ImageProvider<Object>? imageProvider,
    Widget child,
  ) {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.secondary;
    final fontColor = context.colorTheme.onSecondary;
    final heroTag = DateTime.now().toString() + Random().nextInt(200).toString();

    final child = Column(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  style: context.typographyTheme.titleSmall.textStyle.withColor(fontColor),
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
                        maxLines: 1,
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
    return RepaintBoundary(
      child: InkWell(
        child: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: data.imageUrl,
            imageBuilder: (context, imageProvider) => _buildCard(imageProvider, child),
            placeholder: (context, url) => _buildLoading(),
            errorWidget: (context, url, error) => _buildLoading(),
          ),
        ),
      ),
    );
  }
}
