import 'package:flutter/widgets.dart';

class AssetsLoader {
  static final background = Image.asset(
    'assets/app_background.jpg',
    fit: BoxFit.cover,
  );

  static final appSplash = Image.asset(
    'assets/app_splash.png',
    fit: BoxFit.cover,
  );

  static Future<void> load(BuildContext context) async {
    await Future.wait([
      precacheImage(background.image, context),
      precacheImage(appSplash.image, context),
    ]);
  }
}
