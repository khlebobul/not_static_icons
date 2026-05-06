import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dollar Sign Icon - S stroke draws over the vertical line
class DollarSignIcon extends AnimatedSVGIcon {
  const DollarSignIcon({
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
  String get animationDescription => 'Dollar S stroke draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DollarSignPainter(color, animationValue, strokeWidth);
}

class _DollarSignPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DollarSignPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(12 * s, 2 * s), Offset(12 * s, 22 * s), paint);
    final path = Path()
      ..moveTo(17 * s, 5 * s)
      ..lineTo(9.5 * s, 5 * s)
      ..arcToPoint(
        Offset(9.5 * s, 12 * s),
        radius: Radius.circular(3.5 * s),
        clockwise: false,
      )
      ..lineTo(14.5 * s, 12 * s)
      ..arcToPoint(
        Offset(14.5 * s, 19 * s),
        radius: Radius.circular(3.5 * s),
        clockwise: true,
      )
      ..lineTo(6 * s, 19 * s);
    canvas.drawPath(t == 0.0 ? path : _extract(path, t), paint);
  }

  @override
  bool shouldRepaint(_DollarSignPainter old) =>
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
