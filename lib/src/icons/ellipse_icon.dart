import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ellipse Icon - Ellipse pulses horizontally
class EllipseIcon extends AnimatedSVGIcon {
  const EllipseIcon({
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
  String get animationDescription => 'Ellipse stretches horizontally';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EllipsePainter(color, animationValue, strokeWidth);
}

class _EllipsePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EllipsePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = 4 * t * (1 - t);
    final center = Offset(12 * s, 12 * s);
    final rx = (10 + pulse * 1.0) * s;
    final ry = (6 - pulse * 1.0) * s;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EllipsePainter old) =>
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
