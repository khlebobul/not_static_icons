import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Low Icon - draws case, terminal, then a single low bar with a trembling hint
class BatteryLowIcon extends AnimatedSVGIcon {
  const BatteryLowIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Battery low: solid frame (no cutouts); low bar blinks';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryLowPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryLowPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryLowPainter({
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

    // Static original at rest
    if (animationValue == 0.0) {
      _drawComplete(canvas, scale, paint);
      return;
    }

    // Solid frame and terminal always visible
    _drawFrameAndTerminal(canvas, scale, paint);

    // Blink the single low bar with triangle-wave alpha
    final t = animationValue.clamp(0.0, 1.0);
    final alpha = t < 0.5 ? (t / 0.5) : (1 - (t - 0.5) / 0.5);
    final barPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(6 * scale, 14 * scale), Offset(6 * scale, 10 * scale), barPaint);
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    _drawFrameAndTerminal(canvas, scale, paint);
    canvas.drawLine(
        Offset(6 * scale, 14 * scale), Offset(6 * scale, 10 * scale), paint);
  }

  // Solid frame + terminal helper (no cutouts)
  void _drawFrameAndTerminal(Canvas canvas, double scale, Paint paint) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 16 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);
    canvas.drawLine(
        Offset(22 * scale, 14 * scale), Offset(22 * scale, 10 * scale), paint);
  }

  @override
  bool shouldRepaint(_BatteryLowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
