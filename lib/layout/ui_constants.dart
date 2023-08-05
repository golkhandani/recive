import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recive/utils/theme.dart';

const Widget kLoadingBox = Center(
  child: SizedBox(
    height: 32.0,
    width: 32.0,
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  ),
);
const Widget kErrorIcon = Icon(Icons.error);

final kStandardBlur = ImageFilter.blur(
  tileMode: TileMode.clamp,
  sigmaX: 10.0,
  sigmaY: 10.0,
);

final kBoxBorder = Border.all(
  color: primaryShadow,
  width: 1,
  style: BorderStyle.solid,
);

final kStandardBlurColor =
    const Color.fromARGB(255, 40, 40, 40).withOpacity(0.6);

const double kRadius = 10;
