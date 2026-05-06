import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dock Icon - bottom dock bar rises slightly
class DockIcon extends AnimatedSVGIcon {
  const DockIcon({
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
  String get animationDescription => 'Dock bar rises slightly';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DockPainter(color, animationValue, strokeWidth);
}

class _DockPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DockPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * s, 4 * s, 20 * s, 16 * s),
        Radius.circular(2 * s),
      ),
      paint,
    );
    canvas.drawLine(Offset(2 * s, 8 * s), Offset(22 * s, 8 * s), paint);

    final dy = t == 0.0 ? 0.0 : -1.5 * s * math.sin(math.pi * t);
    canvas.drawLine(
      Offset(6 * s, 16 * s + dy),
      Offset(18 * s, 16 * s + dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(_DockPainter old) =>
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
