import 'package:flutter/material.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverCardContainer extends StatelessWidget {
  const SliverCardContainer({
    super.key,
    required this.sliver,
    this.padding = const EdgeInsets.all(24),
    this.color,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget sliver;
  final EdgeInsets padding;
  final Color? color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: false, // defaults to false
      children: <Widget>[
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: color ?? context.colorScheme.tertiaryContainer,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(.2, .2),
                  blurRadius: 2,
                  color: context.colorScheme.tertiaryContainer,
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
