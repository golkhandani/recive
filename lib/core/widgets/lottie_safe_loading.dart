import 'package:flutter/material.dart';

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
  }
}
