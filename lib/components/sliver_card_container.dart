import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverCardContainer extends StatelessWidget {
  const SliverCardContainer({
    super.key,
    required this.sliver,
    this.padding = const EdgeInsets.all(24),
    this.color = Colors.white,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget sliver;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: false, // defaults to false
      children: <Widget>[
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(.2, .2),
                  blurRadius: 2,
                  color: Colors.black26,
                )
              ],
              borderRadius: borderRadius,
            ),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: DecoratedSliver(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            sliver: SliverClip(child: sliver),
          ),
        )
      ],
    );
  }
}
