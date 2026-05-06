import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Divide Icon - divider line draws while dots pulse
class DivideIcon extends AnimatedSVGIcon {
  const DivideIcon({
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
  String get animationDescription => 'Divider line draws while dots pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DividePainter(color, animationValue, strokeWidth);
}

class _DividePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DividePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final t = animationValue.clamp(0.0, 1.0);
    final dotPulse = t == 0.0 ? 1.0 : 0.8 + 0.35 * math.sin(math.pi * t);

    canvas.drawCircle(Offset(12 * s, 6 * s), 1 * s * dotPulse, fillPaint);
    canvas.drawCircle(Offset(12 * s, 18 * s), 1 * s * dotPulse, fillPaint);

    final line = Path()
      ..moveTo(5 * s, 12 * s)
      ..lineTo(19 * s, 12 * s);
    canvas.drawPath(t == 0.0 ? line : _extract(line, t), paint);
  }

  @override
  bool shouldRepaint(_DividePainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Path _extract(Path path, double fraction) {
  final out = Path();
  for (final metric in path.computeMetrics()) {
    final end = metric.length * fraction.clamp(0.0, 1.0);
    if (end > 0) out.addPath(metric.extractPath(0, end), Offset.zero);
  }
  return out;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
