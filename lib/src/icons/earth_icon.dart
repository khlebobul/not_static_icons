import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Earth Icon - Globe wobbles like spinning
class EarthIcon extends AnimatedSVGIcon {
  const EarthIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Earth wobbles like spinning';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EarthPainter(color, animationValue, strokeWidth);
}

class _EarthPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EarthPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final wobble = math.sin(t * math.pi * 2) * 0.12;
    final center = Offset(12 * s, 12 * s);

    canvas.drawCircle(center, 10 * s, paint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(wobble);
    canvas.translate(-center.dx, -center.dy);

    final p1 = Path()
      ..moveTo(21.54 * s, 15 * s)
      ..lineTo(17 * s, 15 * s)
      ..arcToPoint(Offset(15 * s, 17 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(15 * s, 21.54 * s);
    final p2 = Path()
      ..moveTo(7 * s, 3.34 * s)
      ..lineTo(7 * s, 5 * s)
      ..arcToPoint(Offset(10 * s, 8 * s),
          radius: Radius.circular(3 * s), clockwise: false)
      ..arcToPoint(Offset(12 * s, 10 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..cubicTo(12 * s, 11.1 * s, 12.9 * s, 12 * s, 14 * s, 12 * s)
      ..arcToPoint(Offset(16 * s, 10 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..cubicTo(16 * s, 8.9 * s, 16.9 * s, 8 * s, 18 * s, 8 * s)
      ..lineTo(21.17 * s, 8 * s);
    final p3 = Path()
      ..moveTo(11 * s, 21.95 * s)
      ..lineTo(11 * s, 18 * s)
      ..arcToPoint(Offset(9 * s, 16 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..arcToPoint(Offset(7 * s, 14 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(7 * s, 13 * s)
      ..arcToPoint(Offset(5 * s, 11 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(2.05 * s, 11 * s);

    canvas.drawPath(p1, paint);
    canvas.drawPath(p2, paint);
    canvas.drawPath(p3, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EarthPainter old) =>
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
