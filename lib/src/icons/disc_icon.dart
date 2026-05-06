import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Disc Icon - rotating groove makes the spin visible on hover/tap
class DiscIcon extends AnimatedSVGIcon {
  const DiscIcon({
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
  String get animationDescription => 'Rotating groove makes the spin visible';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiscPainter(color, animationValue, strokeWidth);
}

class _DiscPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiscPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);
    canvas.drawCircle(center, 10 * s, paint);
    canvas.drawCircle(center, 2 * s, paint);

    if (t == 0.0) return;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * math.pi * t);
    canvas.translate(-center.dx, -center.dy);

    // A short groove and radial glint make the otherwise symmetric disc visibly spin.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 6 * s),
      -0.55,
      1.1,
      false,
      paint,
    );
    canvas.drawLine(Offset(12 * s, 6 * s), Offset(12 * s, 9 * s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DiscPainter old) =>
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
