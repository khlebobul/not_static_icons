import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ethernet Port Icon - Pins blink sequentially
class EthernetPortIcon extends AnimatedSVGIcon {
  const EthernetPortIcon({
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
  String get animationDescription => 'Pins blink sequentially';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EthernetPortPainter(color, animationValue, strokeWidth);
}

class _EthernetPortPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EthernetPortPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final body = Path()
      ..moveTo(15 * s, 20 * s)
      ..lineTo(18 * s, 17 * s)
      ..lineTo(20 * s, 17 * s)
      ..arcToPoint(Offset(22 * s, 15 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(22 * s, 6 * s)
      ..arcToPoint(Offset(20 * s, 4 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(4 * s, 4 * s)
      ..arcToPoint(Offset(2 * s, 6 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(2 * s, 15 * s)
      ..arcToPoint(Offset(4 * s, 17 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(6 * s, 17 * s)
      ..lineTo(9 * s, 20 * s)
      ..close();
    canvas.drawPath(body, paint);

    final pinX = [6.0, 10.0, 14.0, 18.0];
    for (int i = 0; i < pinX.length; i++) {
      final phase = (t - i * 0.15).clamp(0.0, 1.0);
      final pulse = math.sin(math.pi * phase).clamp(0.0, 1.0);
      final extra = pulse * 1.5;
      canvas.drawLine(
        Offset(pinX[i] * s, 8 * s),
        Offset(pinX[i] * s, (9 + extra) * s),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EthernetPortPainter old) =>
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
