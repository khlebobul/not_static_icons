import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Alarm Clock Check Icon - Shaking alarm clock with check
class AlarmClockCheckIcon extends AnimatedSVGIcon {
  const AlarmClockCheckIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  String get animationDescription => "Shaking alarm clock with check";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlarmClockCheckPainter(color: color, animationValue: animationValue);
  }
}

/// Painter for Alarm Clock Check icon
class AlarmClockCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlarmClockCheckPainter({required this.color, required this.animationValue});

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

    // Check mark (m9 13 2 2 4-4)
    final checkPath = Path()
      ..moveTo(9 * scale, 13 * scale)
      ..lineTo(11 * scale, 15 * scale)
      ..lineTo(15 * scale, 11 * scale);
    canvas.drawPath(checkPath, paint);

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
  bool shouldRepaint(AlarmClockCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
