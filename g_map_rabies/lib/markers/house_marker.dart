import 'package:flutter/material.dart';

class HouseMarkerPainter extends CustomPainter {
  Color color;

  HouseMarkerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.white;
    final bgPaint = Paint()..color = color;

    const double circleBlackRadius = 25;
    const double circleWhiteRadius = 5;

    // Circle black
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleBlackRadius,
        bgPaint);
    // Circle white
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleWhiteRadius,
        whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
