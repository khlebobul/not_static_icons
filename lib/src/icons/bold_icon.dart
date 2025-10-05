import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bold Icon - text weight animation
class BoldIcon extends AnimatedSVGIcon {
  const BoldIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 1.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Bold: text weight animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BoldPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoldPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BoldPainter({
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

    // Draw complete bold icon
    _drawCompleteIcon(canvas, paint, scale);

    // Draw animated bold effect
    _drawBoldAnimation(canvas, paint, scale);
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Draw the bold "B" shape: M6 12h9a4 4 0 0 1 0 8H7a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1h7a4 4 0 0 1 0 8
    final boldPath = Path();

    // Start at M6 12 (middle left)
    boldPath.moveTo(6 * scale, 12 * scale);

    // Line to h9 (horizontal line to x=15)
    boldPath.lineTo(15 * scale, 12 * scale);

    // Arc a4 4 0 0 1 0 8 (bottom right curve)
    boldPath.arcToPoint(
      Offset(15 * scale, 20 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    // Line to H7 (horizontal to x=7)
    boldPath.lineTo(7 * scale, 20 * scale);

    // Arc a1 1 0 0 1-1-1 (bottom left corner) - relative arc -1,-1
    boldPath.arcToPoint(
      Offset(6 * scale, 19 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // Vertical line to V5
    boldPath.lineTo(6 * scale, 5 * scale);

    // Arc a1 1 0 0 1 1-1 (top left corner)
    boldPath.arcToPoint(
      Offset(7 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // Line to h7 (horizontal to x=14)
    boldPath.lineTo(14 * scale, 4 * scale);

    // Arc a4 4 0 0 1 0 8 (top right curve)
    boldPath.arcToPoint(
      Offset(14 * scale, 12 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    canvas.drawPath(boldPath, paint);
  }

  void _drawBoldAnimation(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Create bold effect by drawing thicker strokes with animation
    final pulse = math.sin(progress * math.pi * 3) * 0.5 + 0.5;
    final boldStroke = strokeWidth + pulse * 3;
    final alpha = 0.3 + pulse * 0.7;

    final boldPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = boldStroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw the same path with animated bold effect
    final animatedPath = Path();

    // Start at M6 12 (middle left)
    animatedPath.moveTo(6 * scale, 12 * scale);

    // Line to h9 (horizontal line to x=15)
    animatedPath.lineTo(15 * scale, 12 * scale);

    // Arc a4 4 0 0 1 0 8 (bottom right curve)
    animatedPath.arcToPoint(
      Offset(15 * scale, 20 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    // Line to H7 (horizontal to x=7)
    animatedPath.lineTo(7 * scale, 20 * scale);

    // Arc a1 1 0 0 1-1-1 (bottom left corner) - relative arc -1,-1
    animatedPath.arcToPoint(
      Offset(6 * scale, 19 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // Vertical line to V5
    animatedPath.lineTo(6 * scale, 5 * scale);

    // Arc a1 1 0 0 1 1-1 (top left corner)
    animatedPath.arcToPoint(
      Offset(7 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // Line to h7 (horizontal to x=14)
    animatedPath.lineTo(14 * scale, 4 * scale);

    // Arc a4 4 0 0 1 0 8 (top right curve)
    animatedPath.arcToPoint(
      Offset(14 * scale, 12 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    canvas.drawPath(animatedPath, boldPaint);
  }

  @override
  bool shouldRepaint(_BoldPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
