import 'package:flutter/material.dart';

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
    final safeTopPadding = MediaQuery.of(context).padding.top;
    final safeBottomPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.amber ?? safeAreaColor,
      body: Container(
        color: Colors.pink ?? safeAreaColor,
        padding: EdgeInsets.only(
          top: 0, //?? handleTopSafePadding ? safeTopPadding : 0,
          bottom: handleBottomSafePadding ? safeBottomPadding : 0,
        ),
        child: Container(color: backgroundColor, child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
