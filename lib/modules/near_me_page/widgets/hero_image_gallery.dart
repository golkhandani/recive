import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/colored_network_image.dart';
import 'package:recive/modules/featured_page/models/art_model.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class HeroImageGallery extends StatelessWidget {
  const HeroImageGallery({
    super.key,
    required this.heroTag,
    required this.heroImage,
    required this.images,
  });

  final String heroTag;
  final String? heroImage;
  final List<ImageModel> images;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      borderRadius: kMediumBorderRadius,
      padding: kTinyPadding,
      color: context.colorTheme.cardBackground,
      child: LayoutBuilder(builder: (context, box) {
        if ((heroImage ?? images.firstOrNull?.imageUrl) == null) {
          return const SizedBox();
        }

        // Warning: To stop rebuild issue
        // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
        final imageUrls = images.map((e) => e.imageUrl).toList();
        final list = [
          heroImage ?? images.first.imageUrl,
          ...(imageUrls.isEmpty
              ? [
                  // TO FIX THE ISSUE WITH SAME HERO TAG
                  heroImage ?? images.first.imageUrl,
                  heroImage ?? images.first.imageUrl,
                ]
              : imageUrls)
        ].whereNotNull().mapIndexed((index, data) {
          final item = ColoredNetworkImage(
            imageUrl: data,
            constraints: const BoxConstraints.expand(height: 240),
            color: Colors.blueGrey,
          );
          if (index == 0) {
            return Hero(
              tag: heroTag,
              child: item,
            );
          }
          return item;
        }).toList();

        return CarouselSlider(
          items: list,
          options: CarouselOptions(
            height: 360,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.24,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }
}
