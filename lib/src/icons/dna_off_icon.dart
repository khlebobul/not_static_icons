import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated DNA Off Icon - broken helix draws in while slash stays fixed
class DnaOffIcon extends AnimatedSVGIcon {
  const DnaOffIcon({
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
  String get animationDescription => 'Broken helix draws in with static slash';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DnaOffPainter(color, animationValue, strokeWidth);
}

class _DnaOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DnaOffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final top = Path()
      ..moveTo(15 * s, 2 * s)
      ..cubicTo(
        13.65 * s,
        3.5 * s,
        12.908 * s,
        5 * s,
        12.5 * s,
        6.5 * s,
      )
      ..lineTo(14 * s, 8 * s);

    final middle = Path()
      ..moveTo(2 * s, 15 * s)
      ..cubicTo(
        5.333 * s,
        12 * s,
        8.667 * s,
        12 * s,
        12 * s,
        12 * s,
      );
    final right = Path()
      ..moveTo(22 * s, 9 * s)
      ..cubicTo(
        20.5 * s,
        10.35 * s,
        19 * s,
        11.092 * s,
        17.5 * s,
        11.5 * s,
      )
      ..lineTo(16.5 * s, 10.5 * s);

    final bottom = Path()
      ..moveTo(9 * s, 22 * s)
      ..cubicTo(
        10.35 * s,
        20.5 * s,
        11.092 * s,
        19 * s,
        11.5 * s,
        17.5 * s,
      )
      ..lineTo(10 * s, 16 * s);

    final rungs = [
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
      canvas.drawPath(right, paint);
      canvas.drawPath(bottom, paint);
      for (final rung in rungs) {
        canvas.drawPath(rung, paint);
      }
      canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);
      return;
    }

    canvas.drawPath(_extract(top, _segment(t, 0.0, 0.3)), paint);
    canvas.drawPath(_extract(middle, _segment(t, 0.15, 0.45)), paint);
    canvas.drawPath(_extract(right, _segment(t, 0.35, 0.65)), paint);
    canvas.drawPath(_extract(bottom, _segment(t, 0.5, 0.8)), paint);
    final rungProgress = _segment(t, 0.55, 1.0);
    for (final rung in rungs) {
      canvas.drawPath(_extract(rung, rungProgress), paint);
    }

    canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);
  }

  @override
  bool shouldRepaint(_DnaOffPainter old) =>
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
