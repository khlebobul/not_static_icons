import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignEndHorizontalIcon extends AnimatedSVGIcon {
  const AlignEndHorizontalIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlignEndHorizontalPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Rectangles bounce towards the bottom horizontal line several times';
}

class AlignEndHorizontalPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlignEndHorizontalPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
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

    // First rectangle: move towards the line (y=4) and back to origin (y=2)
    final rect1Y =
        (2.0 + animationProgress * 2.0 + bounce).clamp(2.0, 4.0) * scale;

    // Second rectangle: move towards the line (y=11) and back to origin (y=9)
    final rect2Y =
        (9.0 + animationProgress * 2.0 + bounce).clamp(9.0, 11.0) * scale;

    // Draw first rectangle (bounces towards bottom line)
    final rect1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect1X, rect1Y, 6 * scale, 16 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect1, paint);

    // Draw second rectangle (bounces towards bottom line)
    final rect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect2X, rect2Y, 6 * scale, 9 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect2, paint);

    // Draw horizontal line at bottom
    canvas.drawLine(
      Offset(2 * scale, 22 * scale),
      Offset(22 * scale, 22 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
