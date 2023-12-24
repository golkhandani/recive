import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:recive/shared/extensions/context_ui_extension.dart';

class LottieSafeLoading extends StatelessWidget {
  const LottieSafeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(
          "assets/app_splash_animated.gif",
          height: 125.0,
          width: 125.0,
        ),
      ),
    );
    // return Center(
    //   child: Lottie.network(
    //     'https://lottie.host/6b454c63-6a06-40cc-b859-5c78d32b9e07/r7gCnFCsf2.json',
    //     width: context.vWidth / 2,
    //     height: context.vHeight / 3,
    //     reverse: false,
    //     frameRate: FrameRate(23),
    //     errorBuilder: (context, error, stackTrace) {
    //       return const CircularProgressIndicator();
    //     },
    //   ),
    // );
  }
}

class LottieLoadingIndicator extends StatelessWidget {
  const LottieLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          "assets/app_splash_animated.gif",
          height: 25.0,
          width: 25.0,
        ),
      ),
    );
    // return Center(
    //   child: Lottie.network(
    //     'https://lottie.host/6b454c63-6a06-40cc-b859-5c78d32b9e07/r7gCnFCsf2.json',
    //     width: context.vWidth / 4,
    //     height: context.vHeight / 5,
    //     reverse: false,
    //     frameRate: FrameRate(23),
    //     errorBuilder: (context, error, stackTrace) {
    //       return const CircularProgressIndicator();
    //     },
    //   ),
    // );
  }
}
