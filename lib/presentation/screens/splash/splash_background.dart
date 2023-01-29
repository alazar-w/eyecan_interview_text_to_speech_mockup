import 'package:interview_mockup/presentation/widgets/custom_painter_helper.dart';
import 'package:flutter/material.dart';

class SplashBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    CustomPainterHelper.createCircleWithBlur(
      canvas,
      color: const Color(0xffD9E2FF),
      origin: Offset(size.width * 0.3098320, size.height * 0.7055327),
      radius: size.width * 0.2040000,
    );

    CustomPainterHelper.createCircleWithBlur(
      canvas,
      color: const Color(0xffD9E2FF),
      origin: Offset(size.width * 0.5294133, size.height * 0.5111356),
      radius: size.width * 0.1933333,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
