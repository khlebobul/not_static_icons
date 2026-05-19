import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Equal Icon - Lines slide together then apart
class EqualIcon extends AnimatedSVGIcon {
  const EqualIcon({
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
  String get animationDescription => 'Equal lines come closer then return';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EqualPainter(color, animationValue, strokeWidth);
}

class _EqualPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EqualPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = 4 * t * (1 - t);
    final offset = pulse * 1.5;

    canvas.drawLine(
      Offset(5 * s, (9 + offset) * s),
      Offset(19 * s, (9 + offset) * s),
      paint,
    );
    canvas.drawLine(
      Offset(5 * s, (15 - offset) * s),
      Offset(19 * s, (15 - offset) * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EqualPainter old) =>
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
