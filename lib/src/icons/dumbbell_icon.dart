import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dumbbell Icon - dumbbell lifts upward on hover/tap
class DumbbellIcon extends AnimatedSVGIcon {
  const DumbbellIcon({
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
  String get animationDescription => 'Dumbbell lifts upward';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DumbbellPainter(color, animationValue, strokeWidth);
}

class _DumbbellPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DumbbellPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final lift = -math.sin(math.pi * t) * 1.8 * s;

    canvas.save();
    canvas.translate(0, lift);
    canvas.drawLine(
        Offset(9.6 * s, 14.4 * s), Offset(14.4 * s, 9.6 * s), paint);
    canvas.drawLine(
        Offset(2.5 * s, 21.5 * s), Offset(3.9 * s, 20.1 * s), paint);
    canvas.drawLine(
        Offset(20.1 * s, 3.9 * s), Offset(21.5 * s, 2.5 * s), paint);
    _drawPlate(canvas, s, paint, topRight: true);
    _drawPlate(canvas, s, paint, topRight: false);
    canvas.restore();
  }

  void _drawPlate(Canvas canvas, double s, Paint paint,
      {required bool topRight}) {
    final path = Path();
    if (topRight) {
      path
        ..moveTo(17.596 * s, 12.768 * s)
        ..arcToPoint(Offset(20.425 * s, 9.939 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(18.657 * s, 8.172 * s)
        ..arcToPoint(Offset(21.485 * s, 5.343 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(18.657 * s, 2.515 * s)
        ..arcToPoint(Offset(15.828 * s, 5.343 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(14.061 * s, 3.575 * s)
        ..arcToPoint(Offset(11.232 * s, 6.404 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..close();
    } else {
      path
        ..moveTo(5.343 * s, 21.485 * s)
        ..arcToPoint(Offset(8.172 * s, 18.657 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(9.939 * s, 20.425 * s)
        ..arcToPoint(Offset(12.768 * s, 17.596 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(6.404 * s, 11.232 * s)
        ..arcToPoint(Offset(3.575 * s, 14.061 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(5.343 * s, 15.828 * s)
        ..arcToPoint(Offset(2.515 * s, 18.657 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DumbbellPainter old) =>
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
