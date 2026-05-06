import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Donut Icon - bite edge wiggles and hole pulses
class DonutIcon extends AnimatedSVGIcon {
  const DonutIcon({
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
  String get animationDescription => 'Bite edge wiggles and hole pulses';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DonutPainter(color, animationValue, strokeWidth);
}

class _DonutPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DonutPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);
    final chew = t == 0.0 ? 0.0 : math.sin(2 * math.pi * t) * 0.55 * s;

    final path = Path()
      ..moveTo(20.5 * s, 10 * s + chew)
      ..arcToPoint(
        Offset(18.1 * s, 7 * s - chew),
        radius: Radius.circular(2.5 * s),
        clockwise: true,
      )
      ..lineTo(18 * s, 7 * s)
      ..arcToPoint(
        Offset(15.4 * s, 2.6 * s),
        radius: Radius.circular(2.95 * s),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(21.7 * s, 9.7 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
        largeArc: true,
      )
      ..relativeCubicTo(
        -0.3 * s,
        0.2 * s + chew,
        -0.8 * s,
        0.3 * s + chew,
        -1.2 * s,
        0.3 * s + chew,
      );
    canvas.drawPath(path, paint);
    final holeRadius =
        (t == 0.0 ? 3.0 : 3.0 + 0.55 * math.sin(math.pi * t)) * s;
    canvas.drawCircle(center, holeRadius, paint);
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
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
