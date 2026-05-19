import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Egg Fried Icon - Yolk pulses
class EggFriedIcon extends AnimatedSVGIcon {
  const EggFriedIcon({
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
  String get animationDescription => 'Yolk pulses inside the white';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EggFriedPainter(color, animationValue, strokeWidth);
}

class _EggFriedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EggFriedPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = math.sin(math.pi * t) * 0.15;

    final white = Path()
      ..moveTo(3 * s, 8 * s)
      ..cubicTo(3 * s, 4.5 * s, 5.5 * s, 2 * s, 9.5 * s, 2 * s)
      ..cubicTo(14.5 * s, 2 * s, 14.33 * s, 5 * s, 17 * s, 7 * s)
      ..cubicTo(19.67 * s, 9 * s, 22 * s, 9 * s, 22 * s, 13 * s)
      ..cubicTo(22 * s, 17.5 * s, 19.5 * s, 19.5 * s, 15 * s, 19.5 * s)
      ..cubicTo(12.5 * s, 19.5 * s, 12.5 * s, 22 * s, 9 * s, 22 * s)
      ..cubicTo(5.5 * s, 22 * s, 2 * s, 20 * s, 2 * s, 16.5 * s)
      ..cubicTo(2 * s, 13.5 * s, 3.5 * s, 13.5 * s, 3.5 * s, 11.5 * s)
      ..cubicTo(3.5 * s, 10 * s, 3 * s, 9 * s, 3 * s, 8 * s)
      ..close();
    canvas.drawPath(white, paint);

    final yolkCenter = Offset(11.5 * s, 12.5 * s);
    canvas.drawCircle(yolkCenter, 3.5 * s * (1.0 + pulse), paint);
  }

  @override
  bool shouldRepaint(_EggFriedPainter old) =>
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
