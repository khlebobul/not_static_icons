import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Decimals Arrow Left Icon - arrow nudges left on hover/tap
class DecimalsArrowLeftIcon extends AnimatedSVGIcon {
  const DecimalsArrowLeftIcon({
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
  String get animationDescription => 'Arrow nudges left';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DecimalsArrowLeftPainter(color, animationValue, strokeWidth);
}

class _DecimalsArrowLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DecimalsArrowLeftPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(3 * s, 11 * s), Offset(3.01 * s, 11 * s), paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(6 * s, 3 * s, 5 * s, 8 * s),
        Radius.circular(2.5 * s),
      ),
      paint,
    );

    final dx = -math.sin(math.pi * t) * 2 * s;
    canvas.save();
    canvas.translate(dx, 0);
    final arrow = Path()
      ..moveTo(13 * s, 21 * s)
      ..lineTo(10 * s, 18 * s)
      ..lineTo(13 * s, 15 * s);
    canvas.drawPath(arrow, paint);
    canvas.drawLine(Offset(20 * s, 18 * s), Offset(10 * s, 18 * s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DecimalsArrowLeftPainter old) =>
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
