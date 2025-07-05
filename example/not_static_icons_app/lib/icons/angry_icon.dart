import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Angry Icon - Shaking angry face
class AngryIcon extends AnimatedSVGIcon {
  const AngryIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Shaking angry face";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AngryPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Angry icon
class AngryPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AngryPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // Calculate shake offset
    final shakeIntensity = 1.0 * scale;
    final shakeX =
        sin(animationValue * 4 * 2 * pi) * shakeIntensity * animationValue;
    final shakeY =
        cos(animationValue * 6 * 2 * pi) *
        shakeIntensity *
        0.5 *
        animationValue;

    canvas.save();
    canvas.translate(shakeX, shakeY);

    // Main face circle (circle cx="12" cy="12" r="10")
    canvas.drawCircle(p(12, 12), 10 * scale, paint);

    // Angry mouth (path d="M16 16s-1.5-2-4-2-4 2-4 2")
    final mouthPath = Path();
    mouthPath.moveTo(16 * scale, 16 * scale);
    mouthPath.cubicTo(
      14.5 * scale,
      14 * scale,
      13.5 * scale,
      14 * scale,
      12 * scale,
      14 * scale,
    );
    mouthPath.cubicTo(
      10.5 * scale,
      14 * scale,
      9.5 * scale,
      14 * scale,
      8 * scale,
      16 * scale,
    );
    canvas.drawPath(mouthPath, paint);

    // Left eyebrow (path d="M7.5 8 10 9")
    canvas.drawLine(p(7.5, 8), p(10, 9), paint);

    // Right eyebrow (path d="m14 9 2.5-1")
    canvas.drawLine(p(14, 9), p(16.5, 8), paint);

    // Left eye (path d="M9 10h.01")
    canvas.drawLine(p(9, 10), p(9.01, 10), paint);

    // Right eye (path d="M15 10h.01")
    canvas.drawLine(p(15, 10), p(15.01, 10), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AngryPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
