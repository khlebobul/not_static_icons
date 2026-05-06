import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Droplet Icon - water drop gently squishes
class DropletIcon extends AnimatedSVGIcon {
  const DropletIcon({
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
  String get animationDescription => 'Droplet gently squishes';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DropletPainter(color, animationValue, strokeWidth);
}

class _DropletPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DropletPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 13 * s);
    final sx = 1 + 0.08 * math.sin(math.pi * t);
    final sy = 1 - 0.08 * math.sin(math.pi * t);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(sx, sy);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(_dropPath(s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DropletPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Path _dropPath(double s) {
  return Path()
    ..moveTo(12 * s, 22 * s)
    ..arcToPoint(Offset(19 * s, 15 * s),
        radius: Radius.circular(7 * s), clockwise: false)
    ..cubicTo(19 * s, 13 * s, 18 * s, 11.1 * s, 16 * s, 9.5 * s)
    ..cubicTo(14 * s, 7.9 * s, 12.5 * s, 5.5 * s, 12 * s, 3 * s)
    ..cubicTo(11.5 * s, 5.5 * s, 10 * s, 7.9 * s, 8 * s, 9.5 * s)
    ..cubicTo(6 * s, 11.1 * s, 5 * s, 13 * s, 5 * s, 15 * s)
    ..arcToPoint(Offset(12 * s, 22 * s),
        radius: Radius.circular(7 * s), clockwise: false)
    ..close();
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
