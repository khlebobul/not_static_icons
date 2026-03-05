import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock 10 Icon - Clock hands rotate
class Clock10Icon extends AnimatedSVGIcon {
  const Clock10Icon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Clock hands rotate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Clock10Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Clock10Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Clock10Painter({
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
    final center = Offset(12 * scale, 12 * scale);

    canvas.drawCircle(center, 10 * scale, paint);

    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(8 * scale, 10 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(Clock10Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
