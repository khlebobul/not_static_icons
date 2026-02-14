import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Star Icon - Star rotates and pulses
class CircleStarIcon extends AnimatedSVGIcon {
  const CircleStarIcon({
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
  String get animationDescription => "Star rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleStarPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Star icon
class CircleStarPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleStarPainter({
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

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Animated star with rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 5;
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Draw a 5-pointed star
    final starPath = Path();
    final outerRadius = 4.5 * scale;
    final innerRadius = 2.0 * scale;

    for (int i = 0; i < 5; i++) {
      final outerAngle = (i * 72 - 90) * math.pi / 180;
      final innerAngle = ((i * 72) + 36 - 90) * math.pi / 180;

      final outerX = center.dx + outerRadius * math.cos(outerAngle);
      final outerY = center.dy + outerRadius * math.sin(outerAngle);
      final innerX = center.dx + innerRadius * math.cos(innerAngle);
      final innerY = center.dy + innerRadius * math.sin(innerAngle);

      if (i == 0) {
        starPath.moveTo(outerX, outerY);
      } else {
        starPath.lineTo(outerX, outerY);
      }
      starPath.lineTo(innerX, innerY);
    }
    starPath.close();

    canvas.drawPath(starPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleStarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
