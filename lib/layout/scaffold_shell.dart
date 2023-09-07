import 'package:flutter/material.dart';

import 'package:recive/layout/context_ui_extension.dart';

class ScaffoldShell extends StatelessWidget {
  const ScaffoldShell({
    super.key,
    required this.child,
    this.handleTopSafePadding = false,
    this.handleBottomSafePadding = false,
    this.bottomNavigationBar,
    this.backgroundColor = Colors.transparent,
    this.safeAreaColor = Colors.transparent,
  });
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool handleTopSafePadding;
  final bool handleBottomSafePadding;
  final Color backgroundColor;
  final Color safeAreaColor;

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = context.viewTopPaddingHeight;
    final safeBottomPadding = context.viewBottomPaddingHeight;
    return Scaffold(
      backgroundColor: safeAreaColor,
      body: Container(
        color: safeAreaColor,
        padding: EdgeInsets.only(
          top: handleTopSafePadding ? safeTopPadding : 0,
          bottom: handleBottomSafePadding ? safeBottomPadding : 0,
        ),
        child: Container(color: backgroundColor, child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
