import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Charging Icon - draws case, terminal, then lightning zig-zag and sweeps
class BatteryChargingIcon extends AnimatedSVGIcon {
  const BatteryChargingIcon({
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
      'Battery charging: static frame with cutouts; bolt blinks';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryChargingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryChargingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryChargingPainter({
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

    // Static frame and terminal always visible
    _drawComplete(canvas, scale, paint);

    // Bolt blinking
    double alpha;
    if (animationValue == 0.0) {
      alpha = 1.0; // original state
    } else {
      final t = animationValue.clamp(0.0, 1.0);
      if (t < 0.25) {
        alpha = 1.0 - (t / 0.25);
      } else if (t < 0.5) {
        alpha = (t - 0.25) / 0.25;
      } else if (t < 0.75) {
        alpha = 1.0 - ((t - 0.5) / 0.25);
      } else {
        alpha = (t - 0.75) / 0.25;
      }
    }

    final boltPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    _drawBolt(canvas, scale, boltPaint);
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    // Right frame half: M14.856 6 H16 a2 2 0 0 1 2 2 v8 a2 2 0 0 1 -2 2 h-2.935
    final right = Path()
      ..moveTo(14.856 * scale, 6 * scale)
      ..lineTo(16 * scale, 6 * scale)
      ..arcToPoint(
        Offset(18 * scale, 8 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(18 * scale, 16 * scale)
      ..arcToPoint(
        Offset(16 * scale, 18 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(13.065 * scale, 18 * scale);
    canvas.drawPath(right, paint);

    // Left frame half: M5.14 18 H4 a2 2 0 0 1 -2 -2 V8 a2 2 0 0 1 2 -2 h2.936
    final left = Path()
      ..moveTo(5.14 * scale, 18 * scale)
      ..lineTo(4 * scale, 18 * scale)
      ..arcToPoint(
        Offset(2 * scale, 16 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(2 * scale, 8 * scale)
      ..arcToPoint(
        Offset(4 * scale, 6 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(6.936 * scale, 6 * scale);
    canvas.drawPath(left, paint);

    // Terminal: M22 14 v-4
    canvas.drawLine(
        Offset(22 * scale, 14 * scale), Offset(22 * scale, 10 * scale), paint);
  }

  void _drawBolt(Canvas canvas, double scale, Paint paint) {
    final p = Path();
    p.moveTo(11 * scale, 7 * scale);
    p.relativeLineTo(-3 * scale, 5 * scale);
    p.relativeLineTo(4 * scale, 0);
    p.relativeLineTo(-3 * scale, 5 * scale);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(_BatteryChargingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
