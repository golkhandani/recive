import 'dart:ui';

import 'package:flutter/material.dart';

const Duration kLoadingDuration = Duration(milliseconds: 200);
const Duration kDebounceDuration = Duration(milliseconds: 1000);
const Duration kShimmerDuration = Duration(milliseconds: 800);
const kLargePadding = EdgeInsets.all(24);
const kMediumPadding = EdgeInsets.all(16);
const kSmallPadding = EdgeInsets.all(12);
const kTinyPadding = EdgeInsets.all(8);
const kExtraTinyPadding = EdgeInsets.all(4);

const kErrorIcon = Icon(Icons.error);

const kTinyBorder = BorderSide(width: 0.2);
const kExtraTinyBorder = BorderSide(width: 0.1);

const kTinyElevation = 2.0;
const kMediumElevation = 4.0;

const kTinyOpacity = 0.96;
const kMediumOpacity = 0.4;
const kExtraOpacity = 0.2;

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
final kSmallBorderRadius = BorderRadius.circular(8);
