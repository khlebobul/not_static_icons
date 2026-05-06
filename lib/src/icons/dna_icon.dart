import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated DNA Icon - helix draws in on hover/tap
class DnaIcon extends AnimatedSVGIcon {
  const DnaIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
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
  String get animationDescription => 'DNA helix draws in';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DnaPainter(color, animationValue, strokeWidth);
}

class _DnaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DnaPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final top = Path()
      ..moveTo(15 * s, 2 * s)
      ..cubicTo(
        13.202 * s,
        3.998 * s,
        12.482 * s,
        5.995 * s,
        12.193 * s,
        7.993 * s,
      );
    final middle = Path()
      ..moveTo(2 * s, 15 * s)
      ..cubicTo(
        8.667 * s,
        9 * s,
        15.333 * s,
        15 * s,
        22 * s,
        9 * s,
      );
    final bottom = Path()
      ..moveTo(9 * s, 22 * s)
      ..cubicTo(
        10.798 * s,
        20.002 * s,
        11.518 * s,
        18.005 * s,
        11.807 * s,
        16.007 * s,
      );

    final rungs = [
      Path()
        ..moveTo(10 * s, 16 * s)
        ..lineTo(11.5 * s, 17.5 * s),
      Path()
        ..moveTo(14 * s, 8 * s)
        ..lineTo(12.5 * s, 6.5 * s),
      Path()
        ..moveTo(16.5 * s, 10.5 * s)
        ..lineTo(17.5 * s, 11.5 * s),
      Path()
        ..moveTo(17 * s, 6 * s)
        ..lineTo(14.109 * s, 3.109 * s),
      Path()
        ..moveTo(20 * s, 9 * s)
        ..lineTo(20.891 * s, 9.891 * s),
      Path()
        ..moveTo(3.109 * s, 14.109 * s)
        ..lineTo(4 * s, 15 * s),
      Path()
        ..moveTo(6.5 * s, 12.5 * s)
        ..lineTo(7.5 * s, 13.5 * s),
      Path()
        ..moveTo(7 * s, 18 * s)
        ..lineTo(9.891 * s, 20.891 * s),
    ];

    if (t == 0.0) {
      canvas.drawPath(top, paint);
      canvas.drawPath(middle, paint);
      canvas.drawPath(bottom, paint);
      for (final rung in rungs) {
        canvas.drawPath(rung, paint);
      }
      return;
    }

    canvas.drawPath(_extract(top, _segment(t, 0.0, 0.35)), paint);
    canvas.drawPath(_extract(middle, _segment(t, 0.15, 0.7)), paint);
    canvas.drawPath(_extract(bottom, _segment(t, 0.35, 0.8)), paint);
    final rungProgress = _segment(t, 0.55, 1.0);
    for (final rung in rungs) {
      canvas.drawPath(_extract(rung, rungProgress), paint);
    }
  }

  @override
  bool shouldRepaint(_DnaPainter old) =>
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
