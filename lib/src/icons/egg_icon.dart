import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Egg Icon - Egg wobbles side to side
class EggIcon extends AnimatedSVGIcon {
  const EggIcon({
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
  String get animationDescription => 'Egg wobbles side to side';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EggPainter(color, animationValue, strokeWidth);
}

class _EggPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EggPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pivot = Offset(12 * s, 22 * s);
    final tilt = math.sin(t * math.pi * 2) * 0.18;

    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(tilt);
    canvas.translate(-pivot.dx, -pivot.dy);

    final p = Path()
      ..moveTo(12 * s, 2 * s)
      ..cubicTo(8 * s, 2 * s, 4 * s, 8 * s, 4 * s, 14 * s)
      ..arcToPoint(Offset(20 * s, 14 * s),
          radius: Radius.circular(8 * s), clockwise: false)
      ..cubicTo(20 * s, 8 * s, 16 * s, 2 * s, 12 * s, 2 * s);
    canvas.drawPath(p, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EggPainter old) =>
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
