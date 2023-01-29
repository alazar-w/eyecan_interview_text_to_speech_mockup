import 'package:flutter/material.dart';

class CustomPainterHelper {
  CustomPainterHelper._();

  static void createCircleWithBlur(
    Canvas canvas, {
    required Color color,
    required Offset origin,
    required double radius,
    double circleOpacity = 0.4,
    double colorOpacity = 0.5,
  }) {
    // Paint paint = Paint()..style = PaintingStyle.fill;
    // paint.color = color.withOpacity(circleOpacity);
    // canvas.drawCircle(origin, radius, paint);

    Paint paintBlurred = Paint()..style = PaintingStyle.fill;
    paintBlurred.color = color.withOpacity(colorOpacity);
    paintBlurred.maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawCircle(origin, radius, paintBlurred);
  }
}
