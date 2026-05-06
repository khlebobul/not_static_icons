import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dessert Icon - cherry bounces gently on hover/tap
class DessertIcon extends AnimatedSVGIcon {
  const DessertIcon({
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
  String get animationDescription => 'Cherry bounces on top';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DessertPainter(color, animationValue, strokeWidth);
}

class _DessertPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DessertPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final top = Path()
      ..moveTo(10.162 * s, 3.167 * s)
      ..arcToPoint(
        Offset(2 * s, 13 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(6 * s, 13 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(6 * s, 12 * s)
      ..arcToPoint(
        Offset(10 * s, 12 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(10 * s, 16 * s)
      ..arcToPoint(
        Offset(14 * s, 16 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(14 * s, 12 * s)
      ..arcToPoint(
        Offset(18 * s, 12 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..lineTo(18 * s, 13 * s)
      ..arcToPoint(
        Offset(22 * s, 12.994 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(13.839 * s, 3.168 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
      );
    canvas.drawPath(top, paint);

    final bottom = Path()
      ..moveTo(20.804 * s, 14.869 * s)
      ..arcToPoint(
        Offset(3.196 * s, 14.869 * s),
        radius: Radius.circular(9 * s),
        clockwise: true,
      );
    canvas.drawPath(bottom, paint);

    final bounce = -math.sin(math.pi * t) * 1.4 * s;
    canvas.drawCircle(Offset(12 * s, 4 * s + bounce), 2 * s, paint);
  }

  @override
  bool shouldRepaint(_DessertPainter old) =>
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
