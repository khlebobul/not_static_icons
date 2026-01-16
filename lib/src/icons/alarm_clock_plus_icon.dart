import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Alarm Clock Plus Icon - Shaking alarm clock with plus
class AlarmClockPlusIcon extends AnimatedSVGIcon {
  const AlarmClockPlusIcon({
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
  String get animationDescription => "Shaking alarm clock with plus";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlarmClockPlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Alarm Clock Plus icon
class AlarmClockPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlarmClockPlusPainter({
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
    final shakeY = cos(animationValue * 6 * 2 * pi) *
        shakeIntensity *
        0.5 *
        animationValue;

    canvas.save();
    canvas.translate(shakeX, shakeY);

    // Main clock circle (circle cx="12" cy="13" r="8")
    canvas.drawCircle(p(12, 13), 8 * scale, paint);

    // Vertical line of plus (M12 10v6)
    canvas.drawLine(p(12, 10), p(12, 16), paint);

    // Horizontal line of plus (M9 13h6)
    canvas.drawLine(p(9, 13), p(15, 13), paint);

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
  bool shouldRepaint(AlarmClockPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
