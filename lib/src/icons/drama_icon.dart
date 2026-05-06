import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drama Icon - masks swap emphasis on hover/tap
class DramaIcon extends AnimatedSVGIcon {
  const DramaIcon({
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
  String get animationDescription => 'Drama masks bob in opposite directions';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DramaPainter(color, animationValue, strokeWidth);
}

class _DramaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DramaPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final bob = t == 0 ? 0.0 : math.sin(math.pi * t) * 1.2 * s;

    canvas.save();
    canvas.translate(0, -bob);
    final happy = Path()
      ..moveTo(22 * s, 5 * s)
      ..cubicTo(22 * s, 14 * s, 18 * s, 17 * s, 16 * s, 17 * s)
      ..cubicTo(14 * s, 17 * s, 10 * s, 14 * s, 10 * s, 5 * s)
      ..cubicTo(10 * s, 3 * s, 12 * s, 2 * s, 16 * s, 2 * s)
      ..cubicTo(20 * s, 2 * s, 22 * s, 3 * s, 22 * s, 5 * s);
    canvas.drawPath(happy, paint);
    for (final p in [Offset(14, 6), Offset(18, 6)]) {
      canvas.drawLine(Offset(p.dx * s, p.dy * s),
          Offset((p.dx + .01) * s, p.dy * s), paint);
    }
    final smile = Path()
      ..moveTo(17.4 * s, 9.9 * s)
      ..cubicTo(16.6 * s, 10.7 * s, 15.4 * s, 10.7 * s, 14.6 * s, 9.9 * s);
    canvas.drawPath(smile, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(0, bob);
    final sad = Path()
      ..moveTo(10.1 * s, 7.1 * s)
      ..cubicTo(9 * s, 7.2 * s, 7.7 * s, 7.7 * s, 6 * s, 8.6 * s)
      ..cubicTo(2.5 * s, 10.6 * s, 1.3 * s, 12.5 * s, 2.3 * s, 14.2 * s)
      ..cubicTo(6.8 * s, 22 * s, 11.8 * s, 22.6 * s, 13.5 * s, 21.6 * s)
      ..cubicTo(14.4 * s, 21.1 * s, 15.4 * s, 19.5 * s, 15.4 * s, 16.9 * s);
    canvas.drawPath(sad, paint);
    canvas.drawLine(Offset(10 * s, 11 * s), Offset(10.01 * s, 11 * s), paint);
    canvas.drawLine(
        Offset(6.5 * s, 13.1 * s), Offset(6.51 * s, 13.1 * s), paint);
    final frown = Path()
      ..moveTo(9.1 * s, 16.5 * s)
      ..cubicTo(9.4 * s, 15.4 * s, 10.5 * s, 14.8 * s, 11.5 * s, 15.1 * s);
    canvas.drawPath(frown, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DramaPainter old) =>
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
