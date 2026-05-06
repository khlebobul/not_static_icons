import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Disc 3 Icon - groove arcs orbit around the center
class Disc3Icon extends AnimatedSVGIcon {
  const Disc3Icon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
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
  String get animationDescription => 'Groove arcs orbit around the center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _Disc3Painter(color, animationValue, strokeWidth);
}

class _Disc3Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _Disc3Painter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);
    canvas.drawCircle(center, 10 * s, paint);
    canvas.drawCircle(center, 2 * s, paint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * math.pi * t);
    canvas.translate(-center.dx, -center.dy);
    final left = Path()
      ..moveTo(6 * s, 12 * s)
      ..cubicTo(6 * s, 10.3 * s, 6.7 * s, 8.8 * s, 7.8 * s, 7.8 * s);
    final right = Path()
      ..moveTo(18 * s, 12 * s)
      ..cubicTo(18 * s, 13.7 * s, 17.3 * s, 15.2 * s, 16.2 * s, 16.2 * s);
    canvas.drawPath(left, paint);
    canvas.drawPath(right, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_Disc3Painter old) =>
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
