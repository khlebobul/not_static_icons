import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ellipsis Icon - Three dots pulse sequentially
class EllipsisIcon extends AnimatedSVGIcon {
  const EllipsisIcon({
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
  String get animationDescription => 'Three dots pulse sequentially';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EllipsisPainter(color, animationValue, strokeWidth);
}

class _EllipsisPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EllipsisPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final stroke = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final centers = [
      Offset(5 * s, 12 * s),
      Offset(12 * s, 12 * s),
      Offset(19 * s, 12 * s),
    ];

    for (int i = 0; i < centers.length; i++) {
      final phase = (t - i * 0.2).clamp(0.0, 1.0);
      final pulse = math.sin(math.pi * phase).clamp(0.0, 1.0);
      final radius = (1.2 + pulse * 1.4) * s;
      // outline first
      canvas.drawCircle(centers[i], 1.2 * s, stroke);
      canvas.drawCircle(centers[i], radius, fill);
    }
  }

  @override
  bool shouldRepaint(_EllipsisPainter old) =>
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
