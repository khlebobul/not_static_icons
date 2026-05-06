import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Droplets Icon - original drops rise and settle
class DropletsIcon extends AnimatedSVGIcon {
  const DropletsIcon({
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
  String get animationDescription => 'Droplets rise and settle';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DropletsPainter(color, animationValue, strokeWidth);
}

class _DropletsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DropletsPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final small = t == 0 ? 0.0 : math.sin(math.pi * t) * 0.45 * s;
    final large = t == 0 ? 0.0 : math.sin(math.pi * t) * 0.35 * s;

    canvas.save();
    canvas.translate(0, -small);
    final p1 = Path()
      ..moveTo(7 * s, 16.3 * s)
      ..cubicTo(9.2 * s, 16.3 * s, 11 * s, 14.47 * s, 11 * s, 12.25 * s)
      ..cubicTo(11 * s, 11.09 * s, 10.43 * s, 9.99 * s, 9.29 * s, 9.06 * s)
      ..cubicTo(8.14 * s, 8.14 * s, 7.29 * s, 6.75 * s, 7 * s, 5.3 * s)
      ..cubicTo(6.71 * s, 6.75 * s, 5.86 * s, 8.14 * s, 4.71 * s, 9.06 * s)
      ..cubicTo(3.57 * s, 9.98 * s, 3 * s, 11.1 * s, 3 * s, 12.25 * s)
      ..cubicTo(3 * s, 14.47 * s, 4.8 * s, 16.3 * s, 7 * s, 16.3 * s)
      ..close();
    canvas.drawPath(p1, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(0, large);
    final p2 = Path()
      ..moveTo(12.56 * s, 6.6 * s)
      ..arcToPoint(Offset(14 * s, 3.02 * s),
          radius: Radius.circular(10.97 * s), clockwise: false)
      ..cubicTo(14.5 * s, 5.52 * s, 16 * s, 7.92 * s, 18 * s, 9.52 * s)
      ..cubicTo(20 * s, 11.12 * s, 21 * s, 13.02 * s, 21 * s, 15.02 * s)
      ..arcToPoint(Offset(9.09 * s, 19.99 * s),
          radius: Radius.circular(6.98 * s), clockwise: true);
    canvas.drawPath(p2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DropletsPainter old) =>
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
