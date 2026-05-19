import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Equal Approximately Icon - Wavy lines wiggle
class EqualApproximatelyIcon extends AnimatedSVGIcon {
  const EqualApproximatelyIcon({
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
  String get animationDescription => 'Wavy lines shift side to side';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EqualApproximatelyPainter(color, animationValue, strokeWidth);
}

class _EqualApproximatelyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EqualApproximatelyPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final shift = math.sin(t * math.pi * 2) * 0.8;

    _wave(canvas, paint, s, 9 + shift);
    _wave(canvas, paint, s, 15 - shift);
  }

  void _wave(Canvas canvas, Paint paint, double s, double y) {
    final p = Path()
      ..moveTo(5 * s, y * s)
      ..arcToPoint(Offset(12 * s, y * s),
          radius: Radius.circular(6.5 * s), clockwise: true)
      ..arcToPoint(Offset(19 * s, y * s),
          radius: Radius.circular(6.5 * s), clockwise: false);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(_EqualApproximatelyPainter old) =>
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
