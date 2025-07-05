import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Alarm Clock Off Icon - Shaking disabled alarm clock
class AlarmClockOffIcon extends AnimatedSVGIcon {
  const AlarmClockOffIcon({
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
  String get animationDescription => "Shaking disabled alarm clock";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlarmClockOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Alarm Clock Off icon
class AlarmClockOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlarmClockOffPainter({
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

    // First arc: M6.87 6.87a8 8 0 1 0 11.26 11.26
    final path1 = Path();
    path1.moveTo(6.87 * scale, 6.87 * scale);
    path1.arcToPoint(
      p(18.13, 18.13), // 6.87 + 11.26 = 18.13
      radius: Radius.circular(8 * scale),
      largeArc: true,
      clockwise: false,
    );
    canvas.drawPath(path1, paint);

    // Second arc: M19.9 14.25a8 8 0 0 0-9.15-9.15
    final path2 = Path();
    path2.moveTo(19.9 * scale, 14.25 * scale);
    path2.arcToPoint(
      p(10.75, 5.1), // 19.9 - 9.15 = 10.75, 14.25 - 9.15 = 5.1
      radius: Radius.circular(8 * scale),
      largeArc: false,
      clockwise: false,
    );
    canvas.drawPath(path2, paint);

    // Right top leg: m22 6-3-3 (from 22,6 to 19,3)
    canvas.drawLine(p(22, 6), p(19, 3), paint);

    // Left bottom leg: M6.26 18.67 4 21
    canvas.drawLine(p(6.26, 18.67), p(4, 21), paint);

    // Left top leg: M4 4 2 6
    canvas.drawLine(p(4, 4), p(2, 6), paint);

    // Diagonal strike-through line: m2 2 20 20 (from 2,2 to 22,22)
    canvas.drawLine(p(2, 2), p(22, 22), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AlarmClockOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
