import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Icon - Clock hands rotate
class ClockIcon extends AnimatedSVGIcon {
  const ClockIcon({
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
    return ClockPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockPainter({
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

    // Clock hands with rotation animation: M12 6v6l4 2
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6; // 30 degrees

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Hour hand: M12 6v6
    canvas.drawLine(
      Offset(12 * scale, 6 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );

    // Minute hand: l4 2
    canvas.drawLine(
      Offset(12 * scale, 12 * scale),
      Offset(16 * scale, 14 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
