import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Banana Icon - Initially displays full icon, on hover animates redrawing
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
      "Banana icon that initially displays all lines, then on hover animates redrawing them.";

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

    // When not animating (animationValue = 0), show the full icon
    if (animationValue == 0) {
      _drawFullBanana(canvas, paint, scale);
      return;
    }

    // During animation, redraw the outline and inner line progressively
    if (animationValue <= 0.5) {
      // First half of animation: draw outline progressively
      final outlineProgress = animationValue * 2; // 0->0.5 becomes 0->1
      _drawBananaOutlineAnimated(canvas, paint, scale, outlineProgress);
    } else {
      // Outline is fully drawn after 50%
      _drawBananaOutline(canvas, paint, scale);

      // Second half of animation: draw inner line progressively
      final innerLineProgress =
          (animationValue - 0.5) * 2; // 0.5->1 becomes 0->1
      _drawBananaInnerLineAnimated(canvas, paint, scale, innerLineProgress);
    }
  }

  void _drawFullBanana(Canvas canvas, Paint paint, double scale) {
    // Draw complete banana (both outline and inner line) when not animating
    _drawBananaOutline(canvas, paint, scale);
    _drawBananaInnerLine(canvas, paint, scale);
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

  void _drawBananaOutlineAnimated(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Draw the outline with path animation
    final outlinePath = Path();
    outlinePath.moveTo(5.15 * scale, 17.89 * scale);

    // Create a PathMetric to animate the path
    final fullPath = Path();
    fullPath.moveTo(5.15 * scale, 17.89 * scale);

    // First curve: c5.52-1.52 8.65-6.89 7-12
    fullPath.relativeCubicTo(5.52 * scale, -1.52 * scale, 8.65 * scale,
        -6.89 * scale, 7 * scale, -12 * scale);

    // Second curve: C11.55 4 11.5 2 13 2
    fullPath.cubicTo(11.55 * scale, 4 * scale, 11.5 * scale, 2 * scale,
        13 * scale, 2 * scale);

    // Third curve: c3.22 0 5 5.5 5 8
    fullPath.relativeCubicTo(
        3.22 * scale, 0, 5 * scale, 5.5 * scale, 5 * scale, 8 * scale);

    // Fourth curve: c0 6.5-4.2 12-10.49 12
    fullPath.relativeCubicTo(
        0, 6.5 * scale, -4.2 * scale, 12 * scale, -10.49 * scale, 12 * scale);

    // Fifth curve: C5.11 22 2 22 2 20
    fullPath.cubicTo(
        5.11 * scale, 22 * scale, 2 * scale, 22 * scale, 2 * scale, 20 * scale);

    // Final curve: c0-1.5 1.14-1.55 3.15-2.11
    fullPath.relativeCubicTo(0, -1.5 * scale, 1.14 * scale, -1.55 * scale,
        3.15 * scale, -2.11 * scale);

    // Extract a portion of the path based on progress
    final pathMetrics = fullPath.computeMetrics().toList();
    if (pathMetrics.isNotEmpty) {
      final extractPath = pathMetrics.first.extractPath(
        0,
        pathMetrics.first.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  void _drawBananaInnerLine(Canvas canvas, Paint paint, double scale) {
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

    canvas.drawPath(innerPath, paint);
  }

  void _drawBananaInnerLineAnimated(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Inner line path with animation
    final innerPath = Path();
    innerPath.moveTo(4 * scale, 13 * scale);

    // Create a full path for metrics
    final fullPath = Path();
    fullPath.moveTo(4 * scale, 13 * scale);

    // First curve: c3.5-2 8-2 10 2
    fullPath.relativeCubicTo(
        3.5 * scale, -2 * scale, 8 * scale, -2 * scale, 10 * scale, 2 * scale);

    // Second curve: a5.5 5.5 0 0 1 8 5
    fullPath.arcToPoint(
      Offset((14 + 8) * scale, (15 + 5) * scale),
      radius: Radius.circular(5.5 * scale),
      largeArc: false,
      clockwise: true,
    );

    // Extract a portion of the path based on progress
    final pathMetrics = fullPath.computeMetrics().toList();
    if (pathMetrics.isNotEmpty) {
      final extractPath = pathMetrics.first.extractPath(
        0,
        pathMetrics.first.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
