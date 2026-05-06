import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dam Icon - water waves ripple on hover/tap
class DamIcon extends AnimatedSVGIcon {
  const DamIcon({
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
  String get animationDescription => 'Water waves ripple';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DamPainter(color, animationValue, strokeWidth);
}

class _DamPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DamPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    for (final y in [6.0, 10.0, 14.0, 18.0]) {
      canvas.drawLine(
        Offset(2 * s, y * s),
        Offset(6 * s, y * s),
        paint,
      );
    }

    final wall = Path()
      ..moveTo(7 * s, 3 * s)
      ..arcToPoint(
        Offset(6 * s, 4 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(6 * s, 20 * s)
      ..arcToPoint(
        Offset(7 * s, 21 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(11 * s, 21 * s)
      ..arcToPoint(
        Offset(12 * s, 20 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..lineTo(10 * s, 4 * s)
      ..arcToPoint(
        Offset(9 * s, 3 * s),
        radius: Radius.circular(1 * s),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(wall, paint);

    final ripple = t == 0.0 ? 0.0 : math.sin(2 * math.pi * t) * 0.7 * s;
    final wave1 = Path()
      ..moveTo(11 * s, 11.31 * s)
      ..cubicTo(
        12.17 * s,
        11.87 * s + ripple,
        12.54 * s,
        13 * s + ripple,
        14.5 * s,
        13 * s + ripple,
      )
      ..cubicTo(
        17 * s,
        13 * s + ripple,
        17 * s,
        11 * s - ripple,
        19.5 * s,
        11 * s - ripple,
      )
      ..cubicTo(
        20.8 * s,
        11 * s - ripple,
        21.4 * s,
        11.5 * s,
        22 * s,
        12 * s,
      );
    final wave2 = Path()
      ..moveTo(11.75 * s, 18 * s)
      ..cubicTo(
        12.1 * s,
        18.5 * s - ripple,
        13.2 * s,
        19 * s - ripple,
        14.5 * s,
        19 * s - ripple,
      )
      ..cubicTo(
        17 * s,
        19 * s - ripple,
        17 * s,
        17 * s + ripple,
        19.5 * s,
        17 * s + ripple,
      )
      ..cubicTo(
        20.8 * s,
        17 * s + ripple,
        21.4 * s,
        17.5 * s,
        22 * s,
        18 * s,
      );
    canvas.drawPath(wave1, paint);
    canvas.drawPath(wave2, paint);
  }

  @override
  bool shouldRepaint(_DamPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _strokePaint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
