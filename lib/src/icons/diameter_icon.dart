import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Diameter Icon - diagonal measurement line draws between endpoints
class DiameterIcon extends AnimatedSVGIcon {
  const DiameterIcon({
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
  String get animationDescription => 'Diameter line draws between endpoints';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiameterPainter(color, animationValue, strokeWidth);
}

class _DiameterPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiameterPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawCircle(Offset(19 * s, 19 * s), 2 * s, paint);
    canvas.drawCircle(Offset(5 * s, 5 * s), 2 * s, paint);

    final topArc = Path()
      ..moveTo(6.48 * s, 3.66 * s)
      ..arcToPoint(
        Offset(20.34 * s, 17.52 * s),
        radius: Radius.circular(10 * s),
        clockwise: true,
      );
    final bottomArc = Path()
      ..moveTo(3.66 * s, 6.48 * s)
      ..arcToPoint(
        Offset(17.52 * s, 20.34 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
      );
    canvas.drawPath(topArc, paint);
    canvas.drawPath(bottomArc, paint);

    final line = Path()
      ..moveTo(6.41 * s, 6.41 * s)
      ..lineTo(17.59 * s, 17.59 * s);
    if (t == 0.0) {
      canvas.drawPath(line, paint);
    } else {
      final scale = 1 + 0.08 * math.sin(math.pi * t);
      canvas.save();
      canvas.translate(12 * s, 12 * s);
      canvas.scale(scale, scale);
      canvas.translate(-12 * s, -12 * s);
      canvas.drawPath(_extractPath(line, t), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DiameterPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _strokePaint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}

Path _extractPath(Path path, double fraction) {
  final out = Path();
  final f = fraction.clamp(0.0, 1.0);
  for (final metric in path.computeMetrics()) {
    final end = metric.length * f;
    if (end > 0) {
      out.addPath(metric.extractPath(0, end), Offset.zero);
    }
  }
  return out;
}
