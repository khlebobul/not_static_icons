import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Disc 2 Icon - inner ring pulses while disc rotates
class Disc2Icon extends AnimatedSVGIcon {
  const Disc2Icon({
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
  String get animationDescription => 'Inner ring pulses while disc rotates';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _Disc2Painter(color, animationValue, strokeWidth);
}

class _Disc2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _Disc2Painter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);
    canvas.drawCircle(center, 10 * s, paint);
    final radius = (t == 0.0 ? 4.0 : 4.0 + math.sin(math.pi * t) * 1.0) * s;
    canvas.drawCircle(center, radius, paint);
    canvas.drawLine(center, Offset((12.01) * s, 12 * s), paint);
  }

  @override
  bool shouldRepaint(_Disc2Painter old) =>
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
