import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Decimals Arrow Right Icon - arrow nudges right on hover/tap
class DecimalsArrowRightIcon extends AnimatedSVGIcon {
  const DecimalsArrowRightIcon({
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
  String get animationDescription => 'Arrow nudges right';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DecimalsArrowRightPainter(color, animationValue, strokeWidth);
}

class _DecimalsArrowRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DecimalsArrowRightPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(3 * s, 11 * s), Offset(3.01 * s, 11 * s), paint);
    for (final x in [6.0, 15.0]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x * s, 3 * s, 5 * s, 8 * s),
          Radius.circular(2.5 * s),
        ),
        paint,
      );
    }

    final dx = math.sin(math.pi * t) * 2 * s;
    canvas.save();
    canvas.translate(dx, 0);
    canvas.drawLine(Offset(10 * s, 18 * s), Offset(20 * s, 18 * s), paint);
    final arrow = Path()
      ..moveTo(17 * s, 21 * s)
      ..lineTo(20 * s, 18 * s)
      ..lineTo(17 * s, 15 * s);
    canvas.drawPath(arrow, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DecimalsArrowRightPainter old) =>
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
