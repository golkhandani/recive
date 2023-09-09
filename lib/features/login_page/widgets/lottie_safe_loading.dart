import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:recive/layout/context_ui_extension.dart';

class LottieSafeLoading extends StatelessWidget {
  const LottieSafeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        'https://lottie.host/6b454c63-6a06-40cc-b859-5c78d32b9e07/r7gCnFCsf2.json',
        width: context.vWidth / 2,
        height: context.vHeight / 3,
        reverse: false,
        frameRate: FrameRate(23),
        errorBuilder: (context, error, stackTrace) {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
