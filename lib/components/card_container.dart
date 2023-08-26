import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color = Colors.white,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
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
    );
  }
}
