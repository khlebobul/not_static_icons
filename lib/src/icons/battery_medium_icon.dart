import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Medium Icon - two bars fill after case and terminal
class BatteryMediumIcon extends AnimatedSVGIcon {
  const BatteryMediumIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Battery medium: solid frame; two bars blink';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryMediumPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryMediumPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryMediumPainter({
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

    // Draw solid frame + terminal always visible
    _drawFrameAndTerminal(canvas, scale, paint);

    // Blink two bars: triangle-wave alpha over the duration
    final t = animationValue.clamp(0.0, 1.0);
    double alpha1;
    double alpha2;
    // Bar 1 blinks opposite phase to Bar 2 for interest
    alpha1 = t < 0.5 ? (t / 0.5) : (1 - (t - 0.5) / 0.5);
    final t2 = (t + 0.5) % 1.0;
    alpha2 = t2 < 0.5 ? (t2 / 0.5) : (1 - (t2 - 0.5) / 0.5);

    final bar1Paint = Paint()
      ..color = color.withValues(alpha: alpha1)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final bar2Paint = Paint()
      ..color = color.withValues(alpha: alpha2)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw bars with alpha
    canvas.drawLine(Offset(6 * scale, 14 * scale),
        Offset(6 * scale, 10 * scale), bar1Paint);
    canvas.drawLine(Offset(10 * scale, 14 * scale),
        Offset(10 * scale, 10 * scale), bar2Paint);
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    _drawFrameAndTerminal(canvas, scale, paint);
    canvas.drawLine(
        Offset(6 * scale, 14 * scale), Offset(6 * scale, 10 * scale), paint);
    canvas.drawLine(
        Offset(10 * scale, 14 * scale), Offset(10 * scale, 10 * scale), paint);
  }

  // Removed unused case animation helper

  // Removed unused progressive terminal animation helper

  void _drawFrameAndTerminal(Canvas canvas, double scale, Paint paint) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 16 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);
    canvas.drawLine(
        Offset(22 * scale, 14 * scale), Offset(22 * scale, 10 * scale), paint);
  }

  // Removed unused progressive bar helper

  @override
  bool shouldRepaint(_BatteryMediumPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
