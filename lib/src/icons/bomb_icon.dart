import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bomb Icon - rotation animation
class BombIcon extends AnimatedSVGIcon {
  const BombIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
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
  String get animationDescription => 'Bomb: accelerating fuse spark animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BombPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BombPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BombPainter({
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

    // Draw complete bomb icon with accelerating blink
    _drawAcceleratingBomb(canvas, paint, scale);
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw main bomb circle: circle cx="11" cy="13" r="9"
    canvas.drawCircle(
      Offset(11 * scale, 13 * scale),
      9 * scale,
      paint,
    );

    // Draw fuse path: M14.35 4.65 L16.3 2.7a2.41 2.41 0 0 1 3.4 0l1.6 1.6a2.4 2.4 0 0 1 0 3.4l-1.95 1.95
    final fusePath = Path();

    // Start at M14.35 4.65
    fusePath.moveTo(14.35 * scale, 4.65 * scale);

    // Line to L16.3 2.7
    fusePath.lineTo(16.3 * scale, 2.7 * scale);

    // Arc a2.41 2.41 0 0 1 3.4 0 - this means relative arc ending at +3.4, +0
    fusePath.arcToPoint(
      Offset((16.3 + 3.4) * scale, 2.7 * scale),
      radius: Radius.circular(2.41 * scale),
      clockwise: true,
    );

    // Line l1.6 1.6 - relative line +1.6, +1.6
    fusePath.relativeLineTo(1.6 * scale, 1.6 * scale);

    // Arc a2.4 2.4 0 0 1 0 3.4 - relative arc ending at +0, +3.4
    fusePath.arcToPoint(
      Offset((16.3 + 3.4 + 1.6) * scale, (2.7 + 1.6 + 3.4) * scale),
      radius: Radius.circular(2.4 * scale),
      clockwise: true,
    );

    // Line l-1.95 1.95 - relative line -1.95, +1.95
    fusePath.relativeLineTo(-1.95 * scale, 1.95 * scale);

    canvas.drawPath(fusePath, paint);

    // Draw spark: m22 2-1.5 1.5
    canvas.drawLine(
      Offset(22 * scale, 2 * scale),
      Offset(20.5 * scale, 3.5 * scale),
      paint,
    );
  }

  void _drawAcceleratingBomb(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Accelerating blink effect for entire bomb - starts slow, gets faster, then fades out
    double blinkFrequency;
    double alpha;

    if (progress < 0.7) {
      // First 70% - accelerating blink
      final accelerationProgress = progress / 0.7;
      // Frequency increases from 3 to 12 over time (more blinks)
      blinkFrequency = 3 + (accelerationProgress * accelerationProgress * 9);
      final pulse = math.sin(progress * math.pi * blinkFrequency) * 0.5 + 0.5;
      alpha = 0.4 + pulse * 0.6;
    } else {
      // Last 30% - entire bomb fades out
      final fadeProgress = (progress - 0.7) / 0.3;
      alpha = (1.0 - fadeProgress) * 0.2; // Fade out to invisible
    }

    final bombPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw the complete bomb with animated alpha
    _drawCompleteIcon(canvas, bombPaint, scale);
  }

  @override
  bool shouldRepaint(_BombPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
