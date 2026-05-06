import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dog Icon - eyes blink and nose sniffs on hover/tap
class DogIcon extends AnimatedSVGIcon {
  const DogIcon({
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
  String get animationDescription => 'Dog blinks and nose sniffs';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DogPainter(color, animationValue, strokeWidth);
}

class _DogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DogPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final sniff = t == 0.0 ? 0.0 : -math.sin(math.pi * t) * 0.8 * s;
    final eyeLength =
        t == 0.0 ? 0.5 * s : (0.08 + 0.42 * (1 - math.sin(math.pi * t))) * s;

    final nose = Path()
      ..moveTo(11.25 * s, 16.25 * s + sniff)
      ..lineTo(12.75 * s, 16.25 * s + sniff)
      ..lineTo(12 * s, 17 * s + sniff)
      ..close();
    canvas.drawPath(nose, paint);
    canvas.drawLine(
        Offset(16 * s, 14 * s), Offset(16 * s, 14 * s + eyeLength), paint);
    canvas.drawLine(
        Offset(8 * s, 14 * s), Offset(8 * s, 14 * s + eyeLength), paint);

    final head = Path()
      ..moveTo(4.42 * s, 11.247 * s)
      ..cubicTo(4.14 * s, 12.3 * s, 4 * s, 13.4 * s, 4 * s, 14.556 * s)
      ..cubicTo(4 * s, 18.728 * s, 7.582 * s, 21 * s, 12 * s, 21 * s)
      ..cubicTo(16.418 * s, 21 * s, 20 * s, 18.728 * s, 20 * s, 14.556 * s)
      ..cubicTo(
          20 * s, 13.36 * s, 19.836 * s, 12.24 * s, 19.507 * s, 11.247 * s);
    canvas.drawPath(head, paint);

    final ears = Path()
      ..moveTo(8.5 * s, 8.5 * s)
      ..cubicTo(
        8.116 * s,
        9.55 * s,
        7.417 * s,
        10.528 * s,
        6.156 * s,
        11 * s,
      )
      ..cubicTo(4.225 * s, 11.722 * s, 2.58 * s, 10.703 * s, 2.5 * s, 10 * s)
      ..cubicTo(2.387 * s, 9.006 * s, 3.677 * s, 3.47 * s, 6.5 * s, 3 * s)
      ..cubicTo(
          8.423 * s, 2.679 * s, 10.151 * s, 3.845 * s, 10.151 * s, 5.235 * s)
      ..cubicTo(11.4 * s, 4.98 * s, 12.7 * s, 4.99 * s, 14 * s, 5.277 * s)
      ..cubicTo(14 * s, 3.887 * s, 15.844 * s, 2.679 * s, 17.767 * s, 3 * s)
      ..cubicTo(20.59 * s, 3.47 * s, 21.88 * s, 9.006 * s, 21.767 * s, 10 * s)
      ..cubicTo(
          21.687 * s, 10.703 * s, 20.042 * s, 11.722 * s, 18.111 * s, 11 * s)
      ..cubicTo(
        16.85 * s,
        10.528 * s,
        16.256 * s,
        9.55 * s,
        15.872 * s,
        8.5 * s,
      );
    canvas.drawPath(ears, paint);
  }

  @override
  bool shouldRepaint(_DogPainter old) =>
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
