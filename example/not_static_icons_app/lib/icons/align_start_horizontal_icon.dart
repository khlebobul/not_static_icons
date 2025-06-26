import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignStartHorizontalIcon extends AnimatedSVGIcon {
  const AlignStartHorizontalIcon({super.key, required super.size});

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlignStartHorizontalPainter(
      color: color,
      animationValue: animationValue,
    );
  }

  @override
  String get animationDescription =>
      'Rectangles bounce towards the top horizontal line several times';
}

class AlignStartHorizontalPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlignStartHorizontalPainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24;

    // Animate towards the line and back using sin(pi*x)
    final animationProgress = sin(animationValue * pi);
    // Bouncing effect that happens during the main animation
    final bounce = sin(animationValue * pi * 3.0) * 0.3;

    // Both rectangles stay at their original X positions
    final rect1X = 4.0 * scale;
    final rect2X = 14.0 * scale;

    // Move towards the line (y=4) and back to origin (y=6), with bounce
    final rect1Y =
        (6.0 - animationProgress * 2.0 - bounce).clamp(4.0, 6.0) * scale;
    final rect2Y =
        (6.0 - animationProgress * 2.0 - bounce).clamp(4.0, 6.0) * scale;

    // Draw first rectangle (bounces towards top line)
    final rect1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1X, rect1Y, 6 * scale, 16 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect1, paint);

    // Draw second rectangle (bounces towards top line)
    final rect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2X, rect2Y, 6 * scale, 9 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect2, paint);

    // Draw horizontal line at top
    canvas.drawLine(
      Offset(2 * scale, 2 * scale),
      Offset(22 * scale, 2 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
