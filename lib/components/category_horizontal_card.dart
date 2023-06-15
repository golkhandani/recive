import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/models/recive_category.model.dart';

typedef CategoryCardData = ReciveCategory;

class CategoryHorizontalCard extends HookWidget {
  const CategoryHorizontalCard({
    super.key,
    required this.data,
  });
  final CategoryCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        border: kBoxBorder,
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kRadius),
        child: CachedNetworkImage(
          imageUrl: data.image,
          fit: BoxFit.cover,
          imageBuilder: (_, imageProvider) => Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: kStandardBlur,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          kStandardBlurColor,
                          BlendMode.colorBurn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    data.name,
                    style: context.textTheme.titleSmall,
                  ),
                ),
              )
            ],
          ),
          placeholder: (context, url) => kLoadingBox,
          errorWidget: (context, url, error) => kErrorIcon,
        ),
      ),
    );
  }
}
