import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Eclipse Icon - Moon rotates across the sun
class EclipseIcon extends AnimatedSVGIcon {
  const EclipseIcon({
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
  String get animationDescription => 'Inner moon rotates across the sun';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EclipsePainter(color, animationValue, strokeWidth);
}

class _EclipsePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EclipsePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);
    final angle = math.sin(t * math.pi * 2) * 0.6;

    canvas.drawCircle(center, 10 * s, paint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);

    final inner = Path()
      ..moveTo(12 * s, 2 * s)
      ..arcToPoint(Offset(22 * s, 12 * s),
          radius: Radius.circular(7 * s), clockwise: false);
    canvas.drawPath(inner, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EclipsePainter old) =>
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
