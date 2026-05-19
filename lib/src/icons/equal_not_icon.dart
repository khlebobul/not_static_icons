import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Equal Not Icon - Slash draws across the equal sign
class EqualNotIcon extends AnimatedSVGIcon {
  const EqualNotIcon({
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
  String get animationDescription => 'Slash draws across the equal sign';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EqualNotPainter(color, animationValue, strokeWidth);
}

class _EqualNotPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EqualNotPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(5 * s, 9 * s), Offset(19 * s, 9 * s), paint);
    canvas.drawLine(Offset(5 * s, 15 * s), Offset(19 * s, 15 * s), paint);

    final slash = Path()
      ..moveTo(19 * s, 5 * s)
      ..lineTo(5 * s, 19 * s);
    canvas.drawPath(t == 0.0 ? slash : _extract(slash, t), paint);
  }

  @override
  bool shouldRepaint(_EqualNotPainter old) =>
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
