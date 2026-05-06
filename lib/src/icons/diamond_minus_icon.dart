import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Diamond Minus Icon - diamond rocks while the minus line draws in
class DiamondMinusIcon extends AnimatedSVGIcon {
  const DiamondMinusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 750),
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
  String get animationDescription => 'Minus draws inside rocking diamond';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiamondMinusPainter(color, animationValue, strokeWidth);
}

class _DiamondMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiamondMinusPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.12 * math.sin(math.pi * t));
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(_diamondPath(s), paint);
    canvas.restore();

    final minus = Path()
      ..moveTo(8 * s, 12 * s)
      ..lineTo(16 * s, 12 * s);
    canvas.drawPath(t == 0.0 ? minus : _extractPath(minus, t), paint);
  }

  @override
  bool shouldRepaint(_DiamondMinusPainter old) =>
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

Path _diamondPath(double s) {
  return Path()
    ..moveTo(2.7 * s, 10.3 * s)
    ..arcToPoint(
      Offset(2.7 * s, 13.71 * s),
      radius: Radius.circular(2.41 * s),
      clockwise: false,
    )
    ..lineTo(10.29 * s, 21.3 * s)
    ..arcToPoint(
      Offset(13.7 * s, 21.3 * s),
      radius: Radius.circular(2.41 * s),
      clockwise: false,
    )
    ..lineTo(21.29 * s, 13.71 * s)
    ..arcToPoint(
      Offset(21.29 * s, 10.3 * s),
      radius: Radius.circular(2.41 * s),
      clockwise: false,
    )
    ..lineTo(13.7 * s, 2.71 * s)
    ..arcToPoint(
      Offset(10.29 * s, 2.71 * s),
      radius: Radius.circular(2.41 * s),
      clockwise: false,
    )
    ..close();
}
