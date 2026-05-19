import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Eye Icon - Pupil scales as if blinking
class EyeIcon extends AnimatedSVGIcon {
  const EyeIcon({
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
  String get animationDescription => 'Pupil pulses as the eye watches';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EyePainter(color, animationValue, strokeWidth);
}

class _EyePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EyePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = math.sin(math.pi * t);

    final outline = Path()
      ..moveTo(2.062 * s, 12.348 * s)
      ..arcToPoint(Offset(2.062 * s, 11.652 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..arcToPoint(Offset(21.938 * s, 11.652 * s),
          radius: Radius.circular(10.75 * s), clockwise: true)
      ..arcToPoint(Offset(21.938 * s, 12.348 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..arcToPoint(Offset(2.062 * s, 12.348 * s),
          radius: Radius.circular(10.75 * s), clockwise: true);
    canvas.drawPath(outline, paint);

    final r = (3 - pulse * 1.0) * s;
    canvas.drawCircle(Offset(12 * s, 12 * s), r.clamp(1.0 * s, 3.0 * s), paint);
  }

  @override
  bool shouldRepaint(_EyePainter old) =>
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
