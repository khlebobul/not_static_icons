import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drum Icon - drumsticks strike the drum
class DrumIcon extends AnimatedSVGIcon {
  const DrumIcon({
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
  String get animationDescription => 'Drumsticks tap the drum';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DrumPainter(color, animationValue, strokeWidth);
}

class _DrumPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DrumPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final strike = t == 0 ? 0.0 : math.sin(math.pi * t);

    final leftPivot = Offset(10 * s, 10 * s);
    canvas.save();
    canvas.translate(leftPivot.dx, leftPivot.dy);
    canvas.rotate(0.35 * strike);
    canvas.translate(-leftPivot.dx, -leftPivot.dy);
    canvas.drawLine(Offset(2 * s, 2 * s), Offset(10 * s, 10 * s), paint);
    canvas.restore();

    final rightPivot = Offset(14 * s, 10 * s);
    canvas.save();
    canvas.translate(rightPivot.dx, rightPivot.dy);
    canvas.rotate(-0.35 * strike);
    canvas.translate(-rightPivot.dx, -rightPivot.dy);
    canvas.drawLine(Offset(22 * s, 2 * s), Offset(14 * s, 10 * s), paint);
    canvas.restore();

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(12 * s, 9 * s), width: 20 * s, height: 10 * s),
        paint);
    canvas.drawLine(Offset(7 * s, 13.4 * s), Offset(7 * s, 21.3 * s), paint);
    canvas.drawLine(Offset(12 * s, 14 * s), Offset(12 * s, 22 * s), paint);
    canvas.drawLine(Offset(17 * s, 13.4 * s), Offset(17 * s, 21.3 * s), paint);
    final body = Path()
      ..moveTo(2 * s, 9 * s)
      ..lineTo(2 * s, 17 * s)
      ..arcToPoint(Offset(22 * s, 17 * s),
          radius: Radius.elliptical(10 * s, 5 * s), clockwise: false)
      ..lineTo(22 * s, 9 * s);
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(_DrumPainter old) =>
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
