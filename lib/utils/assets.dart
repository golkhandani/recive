import 'package:flutter/widgets.dart';

class AssetsLoader {
  static final background = Image.asset(
    'assets/app_background.jpg',
    fit: BoxFit.cover,
  );

  static Future<void> load(BuildContext context) async {
    await precacheImage(background.image, context);
  }
}
