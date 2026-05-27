import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Broccoli Icon - sways gently around its base
class BroccoliIcon extends AnimatedSVGIcon {
  const BroccoliIcon({
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
  String get animationDescription => 'Broccoli sways gently';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BroccoliPainter(color, animationValue, strokeWidth);
}

class _BroccoliPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BroccoliPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Sway around base of stalk (6, 22)
    final pivot = Offset(6 * s, 22 * s);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(math.sin(math.pi * t) * 0.12);
    canvas.translate(-pivot.dx, -pivot.dy);

    // Stem connection: M10 13a3 3 0 0 1-2.121-5.121
    final stem = Path()
      ..moveTo(10 * s, 13 * s)
      ..arcToPoint(Offset(7.879 * s, 7.879 * s),
          radius: Radius.circular(3 * s), clockwise: true);
    canvas.drawPath(stem, paint);

    // Stalk: M15.606 14.204c...A1 1 0 0 1 6 22c-2 0-4-2-4-4...
    final stalk = Path()
      ..moveTo(15.606 * s, 14.204 * s)
      ..cubicTo(
          12.106 * s, 15.704 * s, 9.707 * s, 18.707 * s, 6.707 * s, 21.707 * s)
      ..arcToPoint(Offset(6 * s, 22 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..cubicTo(4 * s, 22 * s, 2 * s, 20 * s, 2 * s, 18 * s)
      ..arcToPoint(Offset(2.293 * s, 17.293 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..cubicTo(
          4.204 * s, 15.382 * s, 6.116 * s, 13.715 * s, 7.64 * s, 11.852 * s);
    canvas.drawPath(stalk, paint);

    // Right floret arm: M16.573 14.737A4 4 0 0 1 14 11
    final rightArm = Path()
      ..moveTo(16.573 * s, 14.737 * s)
      ..arcToPoint(Offset(14 * s, 11 * s),
          radius: Radius.circular(4 * s), clockwise: true);
    canvas.drawPath(rightArm, paint);

    // Main floret cluster from the original SVG. The second 4x4 arc is not a
    // large arc; using one makes the crown loop around the wrong side.
    final floret = Path()
      ..moveTo(7.14 * s, 10.907 * s)
      ..arcToPoint(Offset(9.896 * s, 3.477 * s),
          radius: Radius.circular(4 * s), largeArc: true, clockwise: true)
      ..arcToPoint(Offset(16.7 * s, 4.48 * s),
          radius: Radius.circular(4 * s), clockwise: true)
      ..arcToPoint(Offset(19.52 * s, 7.3 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..arcToPoint(Offset(20.522 * s, 14.105 * s),
          radius: Radius.circular(4 * s), clockwise: true)
      ..arcToPoint(Offset(13 * s, 16 * s),
          radius: Radius.circular(4 * s), largeArc: true, clockwise: true);
    canvas.drawPath(floret, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BroccoliPainter old) =>
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
