import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated EV Charger Icon - Lightning bolt flashes
class EvChargerIcon extends AnimatedSVGIcon {
  const EvChargerIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
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
  String get animationDescription => 'Lightning bolt blinks';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EvChargerPainter(color, animationValue, strokeWidth);
}

class _EvChargerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EvChargerPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final p1 = Path()
      ..moveTo(14 * s, 13 * s)
      ..lineTo(16 * s, 13 * s)
      ..arcToPoint(Offset(18 * s, 15 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(18 * s, 17 * s)
      ..arcToPoint(Offset(22 * s, 17 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(22 * s, 10.002 * s)
      ..arcToPoint(Offset(21.41 * s, 8.582 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(18 * s, 5 * s);
    final p2 = Path()
      ..moveTo(14 * s, 21 * s)
      ..lineTo(14 * s, 5 * s)
      ..arcToPoint(Offset(12 * s, 3 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(5 * s, 3 * s)
      ..arcToPoint(Offset(3 * s, 5 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(3 * s, 21 * s);
    final p3 = Path()
      ..moveTo(2 * s, 21 * s)
      ..lineTo(15 * s, 21 * s);
    final p4 = Path()
      ..moveTo(3 * s, 7 * s)
      ..lineTo(14 * s, 7 * s);

    canvas.drawPath(p1, paint);
    canvas.drawPath(p2, paint);
    canvas.drawPath(p3, paint);
    canvas.drawPath(p4, paint);

    final bolt = Path()
      ..moveTo(9 * s, 11 * s)
      ..lineTo(7 * s, 14 * s)
      ..lineTo(10 * s, 14 * s)
      ..lineTo(8 * s, 17 * s);
    final alpha = math.cos(t * math.pi * 2).abs();
    final boltPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(bolt, boltPaint);
  }

  @override
  bool shouldRepaint(_EvChargerPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
