import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dices Icon - rear die tumbles while front die stays readable
class DicesIcon extends AnimatedSVGIcon {
  const DicesIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 850),
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
  String get animationDescription => 'Rear die tumbles behind the front die';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DicesPainter(color, animationValue, strokeWidth);
}

class _DicesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DicesPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final rearPivot = Offset(15.7 * s, 8.6 * s);
    final angle = t == 0.0 ? 0.0 : 0.22 * math.sin(math.pi * t);
    canvas.save();
    canvas.translate(rearPivot.dx, rearPivot.dy);
    canvas.rotate(angle);
    canvas.translate(-rearPivot.dx, -rearPivot.dy);
    final rear = Path()
      ..moveTo(17.92 * s, 14 * s)
      ..lineTo(21.42 * s, 10.5 * s)
      ..arcToPoint(
        Offset(21.42 * s, 7.5 * s),
        radius: Radius.circular(2.24 * s),
        clockwise: false,
      )
      ..lineTo(16.42 * s, 2.58 * s)
      ..arcToPoint(
        Offset(13.42 * s, 2.58 * s),
        radius: Radius.circular(2.24 * s),
        clockwise: false,
      )
      ..lineTo(10 * s, 6 * s);
    canvas.drawPath(rear, paint);
    _drawPip(canvas, s, paint, 15, 6);
    _drawPip(canvas, s, paint, 18, 9);
    canvas.restore();

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * s, 10 * s, 12 * s, 12 * s),
        Radius.circular(2 * s),
      ),
      paint,
    );
    _drawPip(canvas, s, paint, 6, 18);
    _drawPip(canvas, s, paint, 10, 14);
  }

  @override
  bool shouldRepaint(_DicesPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

void _drawPip(Canvas canvas, double s, Paint paint, double x, double y) {
  canvas.drawLine(Offset(x * s, y * s), Offset((x + 0.01) * s, y * s), paint);
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
