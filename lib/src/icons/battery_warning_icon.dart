import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Warning Icon - frame with cutouts + terminal static; exclamation blinks
class BatteryWarningIcon extends AnimatedSVGIcon {
  const BatteryWarningIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1100),
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
      'Battery warning: cutout frame + terminal static; exclamation blinks (never fully disappears)';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryWarningPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryWarningPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryWarningPainter({
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

    // Static frame and terminal; exclamation blinks by alpha
    if (animationValue == 0.0) {
      _drawComplete(canvas, scale, paint);
      return;
    }

    _drawFrameAndTerminal(canvas, scale, paint);

    final t = animationValue.clamp(0.0, 1.0);
    final tri = t < 0.5 ? (t / 0.5) : (1 - (t - 0.5) / 0.5);
    const double minAlpha = 0.35;
    final exPaint = Paint()
      ..color = color.withValues(alpha: minAlpha + (1.0 - minAlpha) * tri)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(10 * scale, 17 * scale),
        Offset(10.01 * scale, 17 * scale), exPaint);
    canvas.drawLine(
        Offset(10 * scale, 7 * scale), Offset(10 * scale, 13 * scale), exPaint);
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    _drawFrameAndTerminal(canvas, scale, paint);
    canvas.drawLine(Offset(10 * scale, 17 * scale),
        Offset(10.01 * scale, 17 * scale), paint);
    canvas.drawLine(
        Offset(10 * scale, 7 * scale), Offset(10 * scale, 13 * scale), paint);
  }

  void _drawFrameAndTerminal(Canvas canvas, double scale, Paint paint) {
    // Right half
    final right = Path()
      ..moveTo(14 * scale, 6 * scale)
      ..lineTo(16 * scale, 6 * scale)
      ..arcToPoint(Offset(18 * scale, 8 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(18 * scale, 16 * scale)
      ..arcToPoint(Offset(16 * scale, 18 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(14 * scale, 18 * scale);
    canvas.drawPath(right, paint);

    // Left half
    final left = Path()
      ..moveTo(6 * scale, 18 * scale)
      ..lineTo(4 * scale, 18 * scale)
      ..arcToPoint(Offset(2 * scale, 16 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(2 * scale, 8 * scale)
      ..arcToPoint(Offset(4 * scale, 6 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(6 * scale, 6 * scale);
    canvas.drawPath(left, paint);

    // Terminal
    canvas.drawLine(
        Offset(22 * scale, 14 * scale), Offset(22 * scale, 10 * scale), paint);
  }

  @override
  bool shouldRepaint(_BatteryWarningPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
