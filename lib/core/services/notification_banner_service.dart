import 'dart:async';

import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/theme/typography_extensions.dart';
import 'package:flutter/material.dart';

class NotificationBannerService {
  final GlobalKey<NavigatorState> navigatorKey;
  NotificationBannerService(this.navigatorKey) {
    // assert(navigatorKey.currentContext == null, 'NavigatorState Context is not initialized!');
  }

  BuildContext get context => navigatorKey.currentContext!;

  Timer? _debounce;

  closeBanner() {
    final sf = ScaffoldMessenger.of(context);
    _debounce?.cancel();
    sf.hideCurrentMaterialBanner();
  }

  showErrorBanner(String message) {
    final sf = ScaffoldMessenger.of(context);
    final foregroundStyle = context.typographyTheme.onErrorContainer.textStyle;
    final backgroundColor = context.colorTheme.errorContainer;

    sf.showMaterialBanner(
      NotificationBanner(
        message: message,
        foregroundStyle: foregroundStyle,
        backgroundColor: backgroundColor,
        closePressed: closeBanner,
      ),
    );
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 3000), () {
      closeBanner();
    });
  }

  showSuccessBanner(String message) {
    final sf = ScaffoldMessenger.of(context);
    final foregroundStyle = context.typographyTheme.onSuccessContainer.textStyle;
    final backgroundColor = context.colorTheme.successContainer;

    sf.showMaterialBanner(
      NotificationBanner(
        message: message,
        foregroundStyle: foregroundStyle,
        backgroundColor: backgroundColor,
        closePressed: closeBanner,
      ),
    );
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 3000), () {
      closeBanner();
    });
  }
}

class NotificationBanner extends MaterialBanner {
  NotificationBanner({
    super.key,
    required String message,
    required TextStyle foregroundStyle,
    required Color backgroundColor,
    VoidCallback? closePressed,
  }) : super(
          content: Text(
            message,
            style: foregroundStyle,
          ),
          backgroundColor: backgroundColor,
          actions: [
            if (closePressed != null)
              TextButton(
                onPressed: closePressed,
                child: Text(
                  'DISMISS',
                  style: foregroundStyle,
                ),
              ),
          ],
        );
}
