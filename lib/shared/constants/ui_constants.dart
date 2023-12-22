import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import 'package:recive/modules/login_page/widgets/lottie_safe_loading.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

const kSliverFillSimpleLoading = SliverFillRemaining(
  child: Center(
    child: CircularProgressIndicator(),
  ),
);

const kSimpleLoading = Center(
  child: CircularProgressIndicator(),
);

const kSliverFillAnimatedLoading = SliverFillRemaining(
  child: Center(
    child: LottieLoadingIndicator(),
  ),
);

const kSliverBoxAnimatedLoading = SliverToBoxAdapter(
  child: Align(alignment: Alignment.topCenter, child: LottieLoadingIndicator()),
);

const kAnimatedLoadingBox = Center(
  child: SizedBox(
    height: 32.0,
    width: 32.0,
    child: Center(
      child: LottieLoadingIndicator(),
    ),
  ),
);

final kSkeletonLoadingBox = LayoutBuilder(builder: (context, box) {
  return ClipRRect(
      borderRadius: kSmallBorderRadius,
      child: Shimmer.fromColors(
        baseColor: context.colorTheme.brightness == Brightness.light
            ? Colors.grey[200]!
            : Colors.grey[800]!,
        highlightColor: context.colorTheme.brightness == Brightness.light
            ? Colors.grey[400]!
            : Colors.grey[600]!,
        child: Column(
          children: [
            Container(
              constraints: box,
              color: context.colorTheme.brightness == Brightness.light
                  ? Colors.grey[200]!
                  : Colors.grey[800]!,
            ),
          ],
        ),
      ));
});

final kSkeletonSectionLoadingBox = LayoutBuilder(builder: (context, box) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: kSmallBorderRadius,
        child: Container(
          constraints: box.copyWith(
            maxHeight: 32,
            maxWidth: box.maxWidth / 2,
            minWidth: 0,
          ),
          color: Colors.grey,
        )
            .animate(
              autoPlay: true,
              onComplete: (c) => c.repeat(),
            )
            .shimmer(
              delay: Random().nextDouble().seconds,
              duration: 1.seconds,
              color: context.colorTheme.secondary,
            ),
      ),
      const SizedBox(height: 12),
      ClipRRect(
        borderRadius: kSmallBorderRadius,
        child: Container(
          constraints: box.copyWith(
            minWidth: double.infinity,
            maxWidth: double.infinity,
            minHeight: 400,
          ),
          color: Colors.grey,
        ),
      )
          .animate(
            autoPlay: true,
            onComplete: (c) => c.repeat(),
          )
          .shimmer(
            delay: Random().nextDouble().seconds,
            duration: 1.seconds,
            color: context.colorTheme.secondary,
          ),
    ],
  );
});

const kErrorIcon = Icon(Icons.error);

final kStandardBlur = ImageFilter.blur(
  tileMode: TileMode.clamp,
  sigmaX: 10.0,
  sigmaY: 10.0,
);

final kBoxBorder = Border.all(
  color: Colors.black45,
  width: 1,
  style: BorderStyle.solid,
);

final kMediumBorderRadius = BorderRadius.circular(16);
final kSmallBorderRadius = BorderRadius.circular(16);

const double kRadius = 10;

const Duration kLoadingDuration = Duration(seconds: 2);

const kMediumPadding = EdgeInsets.all(16);
const kSmallPadding = EdgeInsets.all(12);
const kTinyPadding = EdgeInsets.all(8);
