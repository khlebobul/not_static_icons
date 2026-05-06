import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drafting Compass Icon - compass legs open and close
class DraftingCompassIcon extends AnimatedSVGIcon {
  const DraftingCompassIcon({
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
  String get animationDescription => 'Compass legs open and close';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DraftingCompassPainter(color, animationValue, strokeWidth);
}

class _DraftingCompassPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DraftingCompassPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final open = t == 0 ? 0.0 : math.sin(math.pi * t) * 0.9 * s;

    canvas.drawCircle(Offset(12 * s, 5 * s), 2 * s, paint);
    canvas.drawLine(
        Offset(12.99 * s, 6.74 * s), Offset(14.92 * s, 10.18 * s), paint);
    final arc = Path()
      ..moveTo(19.136 * s, 12 * s)
      ..arcToPoint(Offset(4.865 * s, 12 * s),
          radius: Radius.circular(10 * s), clockwise: true);
    canvas.drawPath(arc, paint);
    canvas.drawLine(
        Offset(21 * s + open, 21 * s), Offset(18.84 * s, 17.16 * s), paint);
    canvas.drawLine(
        Offset(3 * s - open, 21 * s), Offset(11.02 * s, 6.74 * s), paint);
  }

  @override
  bool shouldRepaint(_DraftingCompassPainter old) =>
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
