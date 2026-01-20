import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Plus Icon - frame with cutouts + terminal always visible; plus blinks
class BatteryPlusIcon extends AnimatedSVGIcon {
  const BatteryPlusIcon({
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
      'Battery plus: cutout frame + terminal static; plus blinks (never fully disappears)';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryPlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryPlusPainter({
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

    // If idle (no animation), draw full original (bright plus)
    if (animationValue == 0.0) {
      _drawFrameAndTerminal(canvas, scale, paint);
      canvas.drawLine(
          Offset(10 * scale, 9 * scale), Offset(10 * scale, 15 * scale), paint);
      canvas.drawLine(
          Offset(7 * scale, 12 * scale), Offset(13 * scale, 12 * scale), paint);
      return;
    }

    // Static frame and terminal always visible
    _drawFrameAndTerminal(canvas, scale, paint);

    // Blink plus with min alpha so it never disappears
    final t = animationValue.clamp(0.0, 1.0);
    final tri = t < 0.5 ? (t / 0.5) : (1 - (t - 0.5) / 0.5);
    const double minAlpha = 0.35;
    final plusPaint = Paint()
      ..color = color.withValues(alpha: minAlpha + (1.0 - minAlpha) * tri)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(10 * scale, 9 * scale),
        Offset(10 * scale, 15 * scale), plusPaint);
    canvas.drawLine(Offset(7 * scale, 12 * scale),
        Offset(13 * scale, 12 * scale), plusPaint);
  }

  // Removed unused _drawComplete

  void _drawFrameAndTerminal(Canvas canvas, double scale, Paint paint) {
    // Right and left halves (cutouts)
    final right = Path()
      ..moveTo(12.543 * scale, 6 * scale)
      ..lineTo(16 * scale, 6 * scale)
      ..arcToPoint(Offset(18 * scale, 8 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(18 * scale, 16 * scale)
      ..arcToPoint(Offset(16 * scale, 18 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(12.395 * scale, 18 * scale);
    canvas.drawPath(right, paint);

    final left = Path()
      ..moveTo(7.606 * scale, 18 * scale)
      ..lineTo(4 * scale, 18 * scale)
      ..arcToPoint(Offset(2 * scale, 16 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(2 * scale, 8 * scale)
      ..arcToPoint(Offset(4 * scale, 6 * scale),
          radius: Radius.circular(2 * scale), clockwise: true)
      ..lineTo(7.606 * scale, 6 * scale);
    canvas.drawPath(left, paint);

    canvas.drawLine(
        Offset(22 * scale, 14 * scale), Offset(22 * scale, 10 * scale), paint);
  }

  @override
  bool shouldRepaint(_BatteryPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
