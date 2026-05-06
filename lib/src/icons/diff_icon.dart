import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Diff Icon - plus line draws before the bottom line
class DiffIcon extends AnimatedSVGIcon {
  const DiffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
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
  String get animationDescription => 'Diff plus and minus lines draw in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiffPainter(color, animationValue, strokeWidth);
}

class _DiffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final vertical = Path()
      ..moveTo(12 * s, 3 * s)
      ..lineTo(12 * s, 17 * s);
    final plus = Path()
      ..moveTo(5 * s, 10 * s)
      ..lineTo(19 * s, 10 * s);
    final minus = Path()
      ..moveTo(5 * s, 21 * s)
      ..lineTo(19 * s, 21 * s);

    if (t == 0.0) {
      canvas.drawPath(vertical, paint);
      canvas.drawPath(plus, paint);
      canvas.drawPath(minus, paint);
    } else {
      canvas.drawPath(_extract(vertical, _segment(t, 0.0, 0.45)), paint);
      canvas.drawPath(_extract(plus, _segment(t, 0.25, 0.7)), paint);
      canvas.drawPath(_extract(minus, _segment(t, 0.55, 1.0)), paint);
    }
  }

  @override
  bool shouldRepaint(_DiffPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Path _extract(Path path, double fraction) {
  final out = Path();
  for (final metric in path.computeMetrics()) {
    final end = metric.length * fraction.clamp(0.0, 1.0);
    if (end > 0) {
      out.addPath(metric.extractPath(0, end), Offset.zero);
    }
  }
  return out;
}

double _segment(double value, double start, double end) {
  return ((value - start) / (end - start)).clamp(0.0, 1.0);
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
