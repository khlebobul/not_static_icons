import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Crosshair Icon - tick lines spread outward on hover/tap (targeting lock)
class CrosshairIcon extends AnimatedSVGIcon {
  const CrosshairIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Tick lines spread outward like targeting';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CrosshairPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CrosshairPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    // Circle (always static)
    canvas.drawCircle(Offset(12 * s, 12 * s), 10 * s, paint);

    // Spread amount: ticks move outward then back
    final double spread = math.sin(math.pi * t) * 2.0 * s;

    // Right tick: x1=22 x2=18 y1=12 y2=12 → moves right
    canvas.drawLine(
      Offset((22 + spread) * s, 12 * s),
      Offset((18 + spread) * s, 12 * s),
      paint,
    );

    // Left tick: x1=6 x2=2 y1=12 y2=12 → moves left
    canvas.drawLine(
      Offset((6 - spread) * s, 12 * s),
      Offset((2 - spread) * s, 12 * s),
      paint,
    );

    // Top tick: x1=12 x2=12 y1=6 y2=2 → moves up
    canvas.drawLine(
      Offset(12 * s, (6 - spread) * s),
      Offset(12 * s, (2 - spread) * s),
      paint,
    );

    // Bottom tick: x1=12 x2=12 y1=22 y2=18 → moves down
    canvas.drawLine(
      Offset(12 * s, (22 + spread) * s),
      Offset(12 * s, (18 + spread) * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CrosshairPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
