import 'package:flutter/material.dart';

class SliverGap extends StatelessWidget {
  const SliverGap({
    super.key,
    this.height = 0.0,
    this.width = 0.0,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height, width: width),
    );
  }
}
