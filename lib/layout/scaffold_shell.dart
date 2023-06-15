import 'package:flutter/material.dart';

class ScaffoldShell extends StatelessWidget {
  const ScaffoldShell({
    super.key,
    required this.child,
    this.handleTopSafePadding = false,
    this.handleBottomSafePadding = false,
    this.bottomNavigationBar,
  });
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool handleTopSafePadding;
  final bool handleBottomSafePadding;

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.top;
    final safeBottomPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(
          top: handleTopSafePadding ? safeTopPadding : 0,
          bottom: handleBottomSafePadding ? safeBottomPadding : 0,
        ),
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
