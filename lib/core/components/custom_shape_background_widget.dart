import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';

class CustomShapeBackgroundWidget extends HookWidget {
  const CustomShapeBackgroundWidget({
    super.key,
    required this.child,
    this.handleTopSafePadding = true,
  });

  final Widget child;
  final bool handleTopSafePadding;

  @override
  Widget build(BuildContext context) {
    final sensorX = useState(0.0);
    final sensorY = useState(0.0);
    useEffect(() {
      accelerometerEvents.listen((e) {
        sensorX.value = e.x;
        sensorY.value = -e.y * 3;
      });
      return;
    }, []);
    return Container(
      color: Colors.green,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: context.colorTheme.primary,
            ),
          ),
          buildCustomShape(
            offset: Offset(sensorX.value, sensorY.value),
            shadow: context.colorTheme.shadow,
            color: context.colorTheme.primary,
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 2.4,
            ),
          ),
          Positioned.fill(
            top: handleTopSafePadding
                ? MediaQuery.of(context).padding.top == 0
                    ? 16
                    : MediaQuery.of(context).padding.top
                : 0,
            child: child,
          ),
        ],
      ),
    );
  }
}

class ClipperShadowPainter extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipperShadowPainter({
    super.key,
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipperShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipperShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipperShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

ClipperShadowPainter buildCustomShape({
  Offset offset = Offset.zero,
  Color color = Colors.black,
  Color shadow = Colors.black,
  Size size = const Size(0.0, 0.0),
}) {
  return ClipperShadowPainter(
    shadow: Shadow(
      color: shadow,
      offset: offset,
      blurRadius: 16,
    ),
    clipper: CustomShapeClipper(),
    child: Container(
      width: size.width,
      height: size.height,
      color: color,
    ),
  );
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 36);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
