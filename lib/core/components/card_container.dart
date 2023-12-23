import 'package:flutter/material.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color,
    this.borderRadius = BorderRadius.zero,
    this.hasShadow = false,
    this.constraints = const BoxConstraints(),
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final BorderRadius borderRadius;
  final bool hasShadow;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        constraints: constraints,
        decoration: BoxDecoration(
          color: color ?? context.colorTheme.tertiaryContainer,
          boxShadow: hasShadow
              ? <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(.2, .2),
                    blurRadius: 2,
                    color: context.colorTheme.tertiaryContainer,
                  )
                ]
              : null,
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: color ?? context.colorTheme.tertiaryContainer,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(2.2, 2.2),
                        blurRadius: 10,
                        color: Colors.black,
                      )
                    ],
                    borderRadius: borderRadius,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
