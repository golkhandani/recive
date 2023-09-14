import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:recive/features/login_page/widgets/lottie_safe_loading.dart';

// const kSliverFillLoading = SliverFillRemaining(
//   child: Center(
//     child: CircularProgressIndicator(),
//   ),
// );
const kImagePlaceholder =
    'https://unsplash.com/photos/MzCeUhY3Xy0/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Nnx8dmFuY291dmVyfGVufDB8fHx8MTY5NDczMTM0MXww&force=true&w=640';
const kSliverFillLoading = SliverFillRemaining(
  child: Center(
    child: LottieLoadingIndicator(),
  ),
);

const kMediumPadding = EdgeInsets.all(16);
const kSmallPadding = EdgeInsets.all(12);
const kTinyPadding = EdgeInsets.all(8);

const kLoadingBox = Center(
  child: SizedBox(
    height: 32.0,
    width: 32.0,
    child: Center(
      child: LottieLoadingIndicator(),

      // CircularProgressIndicator(
      //   color: Colors.white,
      // ),
    ),
  ),
);
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

final kStandardBlurColor =
    const Color.fromARGB(255, 40, 40, 40).withOpacity(0.6);

const double kRadius = 10;

const Duration kLoadingDuration = Duration(seconds: 2);
