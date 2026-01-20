import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Biohazard Icon - exact geometry; progressive drawing of curved lines
class BiohazardIcon extends AnimatedSVGIcon {
  const BiohazardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
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
  String get animationDescription =>
      'Biohazard: static icon, then progressive redrawing';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BiohazardPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BiohazardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BiohazardPainter({
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

    // If animation is at 0, draw complete static icon
    if (animationValue == 0.0) {
      _drawCompleteIcon(canvas, paint, scale);
      return;
    }

    // Animation: stroke-reveal drawing
    final double t = animationValue.clamp(0.0, 1.0);
    if (t == 0.0) {
      // Initial: full icon matches SVG
      _drawCompleteIcon(canvas, paint, scale);
      return;
    }

    Path extractPortion(Path path, double fraction) {
      fraction = fraction.clamp(0.0, 1.0);
      final Path out = Path();
      for (final metric in path.computeMetrics(forceClosed: false)) {
        final double len = metric.length;
        if (len <= 0) continue;
        final double end = len * fraction;
        if (end > 0) {
          out.addPath(metric.extractPath(0, end), Offset.zero);
        }
      }
      return out;
    }

    double mapSegment(double x, double a, double b) {
      if (x <= a) return 0.0;
      if (x >= b) return 1.0;
      return (x - a) / (b - a);
    }

    // Create paths for animation
    // Center circle: cx="12" cy="11.9" r="2"
    final centerCirclePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(12 * scale, 11.9 * scale), radius: 2 * scale));

    // Top left curved line: M6.7 3.4c-.9 2.5 0 5.2 2.2 6.7C6.5 9 3.7 9.6 2 11.6
    final topLeftPath = Path()
      ..moveTo(6.7 * scale, 3.4 * scale)
      ..relativeCubicTo(
          -0.9 * scale, 2.5 * scale, 0, 5.2 * scale, 2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(-1.5 * scale, -1.7 * scale, -4.3 * scale, -1.1 * scale,
          -6.0 * scale, 0.9 * scale);

    // Top right curved line: M17.3 3.4c.9 2.5 0 5.2-2.2 6.7 2.4-1.2 5.2-.6 6.9 1.5
    final topRightPath = Path()
      ..moveTo(17.3 * scale, 3.4 * scale)
      ..relativeCubicTo(
          0.9 * scale, 2.5 * scale, 0, 5.2 * scale, -2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(2.4 * scale, -1.2 * scale, 5.2 * scale, -0.6 * scale,
          6.9 * scale, 1.5 * scale);

    // Bottom curved line: M16.7 20.8c-2.6-.4-4.6-2.6-4.7-5.3-.2 2.6-2.1 4.8-4.7 5.2
    final bottomPath = Path()
      ..moveTo(16.7 * scale, 20.8 * scale)
      ..relativeCubicTo(-2.6 * scale, -0.4 * scale, -4.6 * scale, -2.6 * scale,
          -4.7 * scale, -5.3 * scale)
      ..relativeCubicTo(-0.2 * scale, 2.6 * scale, -2.1 * scale, 4.8 * scale,
          -4.7 * scale, 5.2 * scale);

    // Small connecting lines
    final smallLinesPath = Path()
      ..moveTo(8.9 * scale, 10.1 * scale)
      ..lineTo(10.3 * scale, 10.9 * scale)
      ..moveTo(15.1 * scale, 10.1 * scale)
      ..lineTo(13.7 * scale, 10.9 * scale)
      ..moveTo(12 * scale, 13.9 * scale)
      ..lineTo(12 * scale, 15.5 * scale);

    // Top curve: M13.5 5.4c-1-.2-2-.2-3 0
    final topCurvePath = Path()
      ..moveTo(13.5 * scale, 5.4 * scale)
      ..relativeCubicTo(
          -1 * scale, -0.2 * scale, -2 * scale, -0.2 * scale, -3 * scale, 0);

    // Right curve: M17 16.4c.7-.7 1.2-1.6 1.5-2.5
    final rightCurvePath = Path()
      ..moveTo(17 * scale, 16.4 * scale)
      ..relativeCubicTo(0.7 * scale, -0.7 * scale, 1.2 * scale, -1.6 * scale,
          1.5 * scale, -2.5 * scale);

    // Left curve: M5.5 13.9c.3.9.8 1.8 1.5 2.5
    final leftCurvePath = Path()
      ..moveTo(5.5 * scale, 13.9 * scale)
      ..relativeCubicTo(0.3 * scale, 0.9 * scale, 0.8 * scale, 1.8 * scale,
          1.5 * scale, 2.5 * scale);

    // Timeline: main curves (0..0.6), small lines (0.6..0.8), details (0.8..1)
    final double f1 = mapSegment(t, 0.0, 0.6);
    final double f2 = mapSegment(t, 0.6, 0.8);
    final double f3 = mapSegment(t, 0.8, 1.0);

    // Draw main curves
    if (f1 > 0) {
      canvas.drawPath(
          f1 < 1.0 ? extractPortion(topLeftPath, f1) : topLeftPath, paint);
      canvas.drawPath(
          f1 < 1.0 ? extractPortion(topRightPath, f1) : topRightPath, paint);
      canvas.drawPath(
          f1 < 1.0 ? extractPortion(bottomPath, f1) : bottomPath, paint);
    }

    // Draw small lines
    if (f2 > 0) {
      canvas.drawPath(
          f2 < 1.0 ? extractPortion(smallLinesPath, f2) : smallLinesPath,
          paint);
    }

    // Draw details
    if (f3 > 0) {
      canvas.drawPath(
          f3 < 1.0 ? extractPortion(topCurvePath, f3) : topCurvePath, paint);
      canvas.drawPath(
          f3 < 1.0 ? extractPortion(rightCurvePath, f3) : rightCurvePath,
          paint);
      canvas.drawPath(
          f3 < 1.0 ? extractPortion(leftCurvePath, f3) : leftCurvePath, paint);
      canvas.drawPath(
          f3 < 1.0 ? extractPortion(centerCirclePath, f3) : centerCirclePath,
          paint);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Center circle: cx="12" cy="11.9" r="2"
    final centerCircle = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(12 * scale, 11.9 * scale), radius: 2 * scale));
    canvas.drawPath(centerCircle, paint);

    // Top left curved line: M6.7 3.4c-.9 2.5 0 5.2 2.2 6.7C6.5 9 3.7 9.6 2 11.6
    final topLeftPath = Path()
      ..moveTo(6.7 * scale, 3.4 * scale)
      ..relativeCubicTo(
          -0.9 * scale, 2.5 * scale, 0, 5.2 * scale, 2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(-1.5 * scale, -1.7 * scale, -4.3 * scale, -1.1 * scale,
          -6.0 * scale, 0.9 * scale);
    canvas.drawPath(topLeftPath, paint);

    // Top right curved line: M17.3 3.4c.9 2.5 0 5.2-2.2 6.7 2.4-1.2 5.2-.6 6.9 1.5
    final topRightPath = Path()
      ..moveTo(17.3 * scale, 3.4 * scale)
      ..relativeCubicTo(
          0.9 * scale, 2.5 * scale, 0, 5.2 * scale, -2.2 * scale, 6.7 * scale)
      ..relativeCubicTo(2.4 * scale, -1.2 * scale, 5.2 * scale, -0.6 * scale,
          6.9 * scale, 1.5 * scale);
    canvas.drawPath(topRightPath, paint);

    // Bottom curved line: M16.7 20.8c-2.6-.4-4.6-2.6-4.7-5.3-.2 2.6-2.1 4.8-4.7 5.2
    final bottomPath = Path()
      ..moveTo(16.7 * scale, 20.8 * scale)
      ..relativeCubicTo(-2.6 * scale, -0.4 * scale, -4.6 * scale, -2.6 * scale,
          -4.7 * scale, -5.3 * scale)
      ..relativeCubicTo(-0.2 * scale, 2.6 * scale, -2.1 * scale, 4.8 * scale,
          -4.7 * scale, 5.2 * scale);
    canvas.drawPath(bottomPath, paint);

    // Small connecting lines
    // m8.9 10.1 1.4.8
    canvas.drawLine(Offset(8.9 * scale, 10.1 * scale),
        Offset(10.3 * scale, 10.9 * scale), paint);

    // m15.1 10.1-1.4.8
    canvas.drawLine(Offset(15.1 * scale, 10.1 * scale),
        Offset(13.7 * scale, 10.9 * scale), paint);

    // M12 13.9v1.6
    canvas.drawLine(Offset(12 * scale, 13.9 * scale),
        Offset(12 * scale, 15.5 * scale), paint);

    // M13.5 5.4c-1-.2-2-.2-3 0
    final topCurve = Path()
      ..moveTo(13.5 * scale, 5.4 * scale)
      ..relativeCubicTo(
          -1 * scale, -0.2 * scale, -2 * scale, -0.2 * scale, -3 * scale, 0);
    canvas.drawPath(topCurve, paint);

    // M17 16.4c.7-.7 1.2-1.6 1.5-2.5
    final rightCurve = Path()
      ..moveTo(17 * scale, 16.4 * scale)
      ..relativeCubicTo(0.7 * scale, -0.7 * scale, 1.2 * scale, -1.6 * scale,
          1.5 * scale, -2.5 * scale);
    canvas.drawPath(rightCurve, paint);

    // M5.5 13.9c.3.9.8 1.8 1.5 2.5
    final leftCurve = Path()
      ..moveTo(5.5 * scale, 13.9 * scale)
      ..relativeCubicTo(0.3 * scale, 0.9 * scale, 0.8 * scale, 1.8 * scale,
          1.5 * scale, 2.5 * scale);
    canvas.drawPath(leftCurve, paint);
  }

  @override
  bool shouldRepaint(_BiohazardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
