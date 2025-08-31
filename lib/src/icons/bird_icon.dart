import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bird Icon - wing movement animation
class BirdIcon extends AnimatedSVGIcon {
  const BirdIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = true,
    super.resetToStartOnComplete = false,
  });

  @override
  String get animationDescription => 'Bird: gentle jumping animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BirdPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BirdPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BirdPainter({
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

    // Calculate jumping animation
    final jumpProgress = animationValue;
    final jumpHeight = 0.8 * scale * math.sin(jumpProgress * math.pi);

    // Apply jumping transformation
    canvas.save();
    canvas.translate(0, -jumpHeight);

    // Draw complete static icon with jump movement
    _drawCompleteIcon(canvas, paint, scale);

    canvas.restore();
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Eye: M16 7h.01
    canvas.drawLine(
        Offset(16 * scale, 7 * scale), Offset(16.01 * scale, 7 * scale), paint);

    // Main body: M3.4 18H12a8 8 0 0 0 8-8V7a4 4 0 0 0-7.28-2.3L2 20
    final bodyPath = Path()
      ..moveTo(3.4 * scale, 18 * scale)
      ..lineTo(12 * scale, 18 * scale)
      ..arcToPoint(Offset(20 * scale, 10 * scale),
          radius: Radius.circular(8 * scale), clockwise: false)
      ..lineTo(20 * scale, 7 * scale)
      ..arcToPoint(Offset(12.72 * scale, 4.7 * scale),
          radius: Radius.circular(4 * scale), clockwise: false)
      ..lineTo(2 * scale, 20 * scale);
    canvas.drawPath(bodyPath, paint);

    // Beak: m20 7 2 .5-2 .5
    canvas.drawLine(
        Offset(20 * scale, 7 * scale), Offset(22 * scale, 7.5 * scale), paint);
    canvas.drawLine(
        Offset(22 * scale, 7.5 * scale), Offset(20 * scale, 8 * scale), paint);

    // Legs and tail
    // M10 18v3
    canvas.drawLine(
        Offset(10 * scale, 18 * scale), Offset(10 * scale, 21 * scale), paint);

    // M14 17.75V21
    canvas.drawLine(Offset(14 * scale, 17.75 * scale),
        Offset(14 * scale, 21 * scale), paint);

    // M7 18a6 6 0 0 0 3.84-10.61
    final tailPath = Path()
      ..moveTo(7 * scale, 18 * scale)
      ..arcToPoint(Offset(10.84 * scale, 7.39 * scale),
          radius: Radius.circular(6 * scale), clockwise: false);
    canvas.drawPath(tailPath, paint);
  }

  @override
  bool shouldRepaint(_BirdPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
