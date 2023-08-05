
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'dart:math' as math;

import 'package:recive/models/recive.model.dart';

typedef BigSquareCardData = Recive;

class BigSquareCard extends HookWidget {
  const BigSquareCard({
    super.key,
    required this.data,
  });

  final BigSquareCardData data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          border: kBoxBorder,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        width: constraints.maxWidth,
        height: constraints.maxWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kRadius),
          child: CachedNetworkImage(
            imageUrl: data.imageUrls.first,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
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
                                context.schema.secondary.withOpacity(0.6),
                                BlendMode.colorBurn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildThumbnailWidget(constraints, imageProvider),
                    Positioned(
                        top: 0,
                        left: constraints.maxWidth / 1.5,
                        height: constraints.maxWidth / 1.5,
                        width:
                            constraints.maxWidth - constraints.maxWidth / 1.5,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Serving Size: The number of servings the recipe yields, such as "4 servings" or "8-10 cookies."
                                ReciveFactItem(
                                  icon: Ic.people,
                                  text: data.serving,
                                ),

                                // Cooking Time: The estimated time required for cooking or baking the recipe, like "20 minutes" or "45 minutes."
                                ReciveFactItem(
                                  icon: Ic.timer,
                                  text:
                                      '${data.cookingTimeMinute + data.preparationTimeMinute} minutes',
                                ),
                                // Difficulty Level: A rating or label indicating the difficulty level of the recipe, such as "Easy," "Intermediate," or "Advanced."
                                ReciveFactItem(
                                  icon: Ic.label,
                                  text: data.difficultyLevel.name,
                                ),
                                // Calories: The approximate number of calories per serving in the recipe. This information can provide users with an understanding of the recipe's nutritional value and help them make informed choices about their dietary needs.
                                ReciveFactItem(
                                  icon: Mdi.calculator,
                                  text: '${data.calories}k Calories',
                                ),
                                const SizedBox(height: 32)
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                        top: constraints.maxWidth / 1.5,
                        left: 0,
                        height:
                            constraints.maxWidth - constraints.maxWidth / 1.5,
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child:
                              _buildJourneyCardMainInfo(constraints, context),
                        )),
                  ],
                );
              },
            ),
            placeholder: (context, url) => kLoadingBox,
            errorWidget: (context, url, error) => kErrorIcon,
          ),
        ),
      );
    });
  }

  Positioned _buildThumbnailWidget(
      BoxConstraints constraints, ImageProvider<Object> imageProvider) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThumbnailImage(
                    constraints,
                    imageProvider,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  SizedBox _buildJourneyCardMainInfo(
    BoxConstraints constraints,
    BuildContext context,
  ) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.title,
            maxLines: 1,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.schema.onSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Iconify(
                Mdi.food_fork_drink,
                color: context.schema.onSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Created by ${data.creatorSummary.firstName} ${data.creatorSummary.lastName}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: context.schema.onSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Iconify(
                Mdi.food,
                color: context.schema.onSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${data.origin.title} ${data.cuisineType}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: context.schema.onSecondary,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildThumbnailImage(
    BoxConstraints constraints,
    ImageProvider<Object> imageProvider,
  ) {
    return Container(
      width: constraints.maxWidth / 1.5,
      height: constraints.maxWidth / 1.5,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            blurRadius: 0,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0xFFEEEEEE),
            blurRadius: 0,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(100)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ReciveFactItem extends StatelessWidget {
  const ReciveFactItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.hardLight,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.1),
        border: kBoxBorder,
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 8,
              bottom: 8,
              right: 4,
            ),
            child: Iconify(
              icon,
              color: context.schema.onSecondary,
              size: 16,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: context.schema.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
