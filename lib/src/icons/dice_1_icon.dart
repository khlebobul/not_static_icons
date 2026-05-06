import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dice 1 Icon - die rocks and pip pulses on hover/tap
class Dice1Icon extends AnimatedSVGIcon {
  const Dice1Icon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 750),
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
  String get animationDescription => 'Die rocks and center pip pulses';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _Dice1Painter(color, animationValue, strokeWidth);
}

class _Dice1Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _Dice1Painter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    _drawDie(canvas, s, paint, t, [Offset(12, 12)]);
  }

  @override
  bool shouldRepaint(_Dice1Painter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

void _drawDie(
    Canvas canvas, double s, Paint paint, double t, List<Offset> pips) {
  final center = Offset(12 * s, 12 * s);
  final angle = t == 0.0 ? 0.0 : 0.16 * math.sin(math.pi * t);
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(angle);
  canvas.translate(-center.dx, -center.dy);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * s, 3 * s, 18 * s, 18 * s),
      Radius.circular(2 * s),
    ),
    paint,
  );
  final pipScale = t == 0.0 ? 1.0 : 0.75 + 0.3 * math.sin(math.pi * t);
  for (final pip in pips) {
    canvas.drawLine(
      Offset(pip.dx * s, pip.dy * s),
      Offset((pip.dx + 0.01 * pipScale) * s, pip.dy * s),
      paint,
    );
  }
  canvas.restore();
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
