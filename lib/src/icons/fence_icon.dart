import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fence Icon - fence posts spring up slightly
class FenceIcon extends AnimatedSVGIcon {
  const FenceIcon({
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
  String get animationDescription => 'Fence posts spring up';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FencePainter(color, animationValue, strokeWidth);
}

class _FencePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FencePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final dy = -math.sin(math.pi * t) * 1.5 * s;
    canvas.save();
    canvas.translate(0, dy);

    // Left post: M4 3 2 5v15c0 .6.4 1 1 1h2c.6 0 1-.4 1-1V5Z
    final leftPost = Path()
      ..moveTo(4 * s, 3 * s)
      ..lineTo(2 * s, 5 * s)
      ..lineTo(2 * s, 20 * s)
      ..cubicTo(2 * s, 20.6 * s, 2.4 * s, 21 * s, 3 * s, 21 * s)
      ..lineTo(5 * s, 21 * s)
      ..cubicTo(5.6 * s, 21 * s, 6 * s, 20.6 * s, 6 * s, 20 * s)
      ..lineTo(6 * s, 5 * s)
      ..close();
    canvas.drawPath(leftPost, paint);

    // Middle post: m12 3-2 2v15c0 .6.4 1 1 1h2c.6 0 1-.4 1-1V5Z
    final midPost = Path()
      ..moveTo(12 * s, 3 * s)
      ..lineTo(10 * s, 5 * s)
      ..lineTo(10 * s, 20 * s)
      ..cubicTo(10 * s, 20.6 * s, 10.4 * s, 21 * s, 11 * s, 21 * s)
      ..lineTo(13 * s, 21 * s)
      ..cubicTo(13.6 * s, 21 * s, 14 * s, 20.6 * s, 14 * s, 20 * s)
      ..lineTo(14 * s, 5 * s)
      ..close();
    canvas.drawPath(midPost, paint);

    // Right post: m20 3-2 2v15c0 .6.4 1 1 1h2c.6 0 1-.4 1-1V5Z
    final rightPost = Path()
      ..moveTo(20 * s, 3 * s)
      ..lineTo(18 * s, 5 * s)
      ..lineTo(18 * s, 20 * s)
      ..cubicTo(18 * s, 20.6 * s, 18.4 * s, 21 * s, 19 * s, 21 * s)
      ..lineTo(21 * s, 21 * s)
      ..cubicTo(21.6 * s, 21 * s, 22 * s, 20.6 * s, 22 * s, 20 * s)
      ..lineTo(22 * s, 5 * s)
      ..close();
    canvas.drawPath(rightPost, paint);

    // Rails: M6 8h4, M6 18h4, M14 8h4, M14 18h4
    canvas.drawLine(Offset(6 * s, 8 * s), Offset(10 * s, 8 * s), paint);
    canvas.drawLine(Offset(6 * s, 18 * s), Offset(10 * s, 18 * s), paint);
    canvas.drawLine(Offset(14 * s, 8 * s), Offset(18 * s, 8 * s), paint);
    canvas.drawLine(Offset(14 * s, 18 * s), Offset(18 * s, 18 * s), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_FencePainter old) =>
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
