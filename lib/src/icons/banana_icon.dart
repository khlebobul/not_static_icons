import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Banana Icon - First draws the outline, then the inner line appears
class BananaIcon extends AnimatedSVGIcon {
  const BananaIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      "Banana icon that first draws the outline, then the inner line appears.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BananaPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Banana icon
class BananaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BananaPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    // Always draw the banana outline
    _drawBananaOutline(canvas, paint, scale);

    // Draw inner line after 50% of animation
    if (animationValue > 0.5) {
      final innerLineProgress = (animationValue - 0.5) / 0.5;
      _drawBananaInnerLine(canvas, paint, scale, innerLineProgress);
    }
  }

  void _drawBananaOutline(Canvas canvas, Paint paint, double scale) {
    // Original path: M5.15 17.89c5.52-1.52 8.65-6.89 7-12C11.55 4 11.5 2 13 2c3.22 0 5 5.5 5 8 0 6.5-4.2 12-10.49 12C5.11 22 2 22 2 20c0-1.5 1.14-1.55 3.15-2.11Z

    final outlinePath = Path();
    outlinePath.moveTo(5.15 * scale, 17.89 * scale);

    // First curve: c5.52-1.52 8.65-6.89 7-12
    outlinePath.relativeCubicTo(5.52 * scale, -1.52 * scale, 8.65 * scale,
        -6.89 * scale, 7 * scale, -12 * scale);

    // Second curve: C11.55 4 11.5 2 13 2
    outlinePath.cubicTo(11.55 * scale, 4 * scale, 11.5 * scale, 2 * scale,
        13 * scale, 2 * scale);

    // Third curve: c3.22 0 5 5.5 5 8
    outlinePath.relativeCubicTo(
        3.22 * scale, 0, 5 * scale, 5.5 * scale, 5 * scale, 8 * scale);

    // Fourth curve: c0 6.5-4.2 12-10.49 12
    outlinePath.relativeCubicTo(
        0, 6.5 * scale, -4.2 * scale, 12 * scale, -10.49 * scale, 12 * scale);

    // Fifth curve: C5.11 22 2 22 2 20
    outlinePath.cubicTo(
        5.11 * scale, 22 * scale, 2 * scale, 22 * scale, 2 * scale, 20 * scale);

    // Final curve: c0-1.5 1.14-1.55 3.15-2.11
    outlinePath.relativeCubicTo(0, -1.5 * scale, 1.14 * scale, -1.55 * scale,
        3.15 * scale, -2.11 * scale);

    canvas.drawPath(outlinePath, paint);
  }

  void _drawBananaInnerLine(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Inner line path: M4 13c3.5-2 8-2 10 2a5.5 5.5 0 0 1 8 5

    final innerPath = Path();
    innerPath.moveTo(4 * scale, 13 * scale);

    // First curve: c3.5-2 8-2 10 2
    innerPath.relativeCubicTo(
        3.5 * scale, -2 * scale, 8 * scale, -2 * scale, 10 * scale, 2 * scale);

    // Second curve: a5.5 5.5 0 0 1 8 5
    innerPath.arcToPoint(
      Offset((14 + 8) * scale, (15 + 5) * scale),
      radius: Radius.circular(5.5 * scale),
      largeArc: false,
      clockwise: true,
    );

    // Apply opacity based on progress
    final innerPaint = Paint()
      ..color = color.withValues(alpha: progress)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
