import 'dart:async';

import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/theme/typography_extensions.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationBannerService {
  final GlobalKey<NavigatorState> navigatorKey;
  NotificationBannerService(this.navigatorKey);

  BuildContext get context => navigatorKey.currentState!.context;

  Timer? _debounce;

  closeBanner(AnimationController localAnimationController) {
    _debounce?.cancel();
    localAnimationController.reverse();
  }

  showErrorBanner(String message) {
    final foregroundStyle = context.typographyTheme.onError.textStyle;
    final backgroundColor = context.colorTheme.error;

    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          icon: const SizedBox(),
          backgroundColor: backgroundColor,
          textStyle: foregroundStyle,
          message: message,
        ), onAnimationControllerInit: (c) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 3000), () {
        closeBanner(c);
      });
    });
  }

  showSuccessBanner(String message) {
    final foregroundStyle = context.typographyTheme.onSuccessContainer.textStyle;
    final backgroundColor = context.colorTheme.successContainer;
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          backgroundColor: backgroundColor,
          icon: const SizedBox(),
          textStyle: foregroundStyle,
          message: message,
        ), onAnimationControllerInit: (c) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 3000), () {
        closeBanner(c);
      });
    });
  }
}
