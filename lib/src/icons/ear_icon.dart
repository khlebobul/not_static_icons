import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ear Icon - Inner spiral pulses outward
class EarIcon extends AnimatedSVGIcon {
  const EarIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
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
  String get animationDescription => 'Ear listens with a soft pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EarPainter(color, animationValue, strokeWidth);
}

class _EarPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EarPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = math.sin(math.pi * t);

    // Outer ear path: M6 8.5a6.5 6.5 0 1 1 13 0 c0 6 -6 6 -6 10 a3.5 3.5 0 1 1 -7 0
    final outer = Path()
      ..moveTo(6 * s, 8.5 * s)
      ..arcToPoint(Offset(19 * s, 8.5 * s),
          radius: Radius.circular(6.5 * s), clockwise: true)
      ..cubicTo(19 * s, 14.5 * s, 13 * s, 14.5 * s, 13 * s, 18.5 * s)
      ..arcToPoint(Offset(6 * s, 18.5 * s),
          radius: Radius.circular(3.5 * s), clockwise: true);
    canvas.drawPath(outer, paint);

    // Inner spiral pulses
    final scaleAnim = 1.0 + pulse * 0.12;
    final pivot = Offset(12.5 * s, 11 * s);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-pivot.dx, -pivot.dy);

    final inner = Path()
      ..moveTo(15 * s, 8.5 * s)
      ..arcToPoint(Offset(10 * s, 8.5 * s),
          radius: Radius.circular(2.5 * s), clockwise: false)
      ..lineTo(10 * s, 9.5 * s)
      ..arcToPoint(Offset(10 * s, 13.5 * s),
          radius: Radius.circular(2 * s), clockwise: true);
    canvas.drawPath(inner, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EarPainter old) =>
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
