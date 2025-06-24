import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Alarm Clock Icon - Shaking alarm clock
class AlarmClockIcon extends AnimatedSVGIcon {
  const AlarmClockIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  String get animationDescription => "Shaking alarm clock";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlarmClockPainter(color: color, animationValue: animationValue);
  }
}

/// Painter for Alarm Clock icon
class AlarmClockPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlarmClockPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
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

    // Main clock circle (circle cx="12" cy="13" r="8")
    canvas.drawCircle(p(12, 13), 8 * scale, paint);

    // Clock hands (M12 9v4l2 2)
    canvas.drawLine(p(12, 9), p(12, 13), paint);
    canvas.drawLine(p(12, 13), p(14, 15), paint);

    // Left top leg (M5 3 2 6)
    canvas.drawLine(p(5, 3), p(2, 6), paint);

    // Right top leg (m22 6-3-3)
    canvas.drawLine(p(22, 6), p(19, 3), paint);

    // Left bottom leg (M6.38 18.7 4 21)
    canvas.drawLine(p(6.38, 18.7), p(4, 21), paint);

    // Right bottom leg (M17.64 18.67 20 21)
    canvas.drawLine(p(17.64, 18.67), p(20, 21), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AlarmClockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
