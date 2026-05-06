import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Diamond Percent Icon - percent mark draws in with pulsing dots
class DiamondPercentIcon extends AnimatedSVGIcon {
  const DiamondPercentIcon({
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
  String get animationDescription => 'Percent line draws and dots pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DiamondPercentPainter(color, animationValue, strokeWidth);
}

class _DiamondPercentPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DiamondPercentPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _strokePaint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final center = Offset(12 * s, 12 * s);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.1 * math.sin(math.pi * t));
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(_diamondPath(s), paint);
    canvas.restore();

    final slash = Path()
      ..moveTo(14.5 * s, 9.5 * s)
      ..lineTo(9.5 * s, 14.5 * s);
    canvas.drawPath(t == 0.0 ? slash : _extractPath(slash, t), paint);

    final dotScale = t == 0.0 ? 1.0 : 0.75 + 0.35 * math.sin(math.pi * t);
    canvas.drawLine(Offset(9.2 * s, 9.2 * s),
        Offset((9.2 + 0.01 * dotScale) * s, 9.2 * s), paint);
    canvas.drawLine(Offset(14.7 * s, 14.8 * s),
        Offset((14.7 + 0.01 * dotScale) * s, 14.8 * s), paint);
  }

  @override
  bool shouldRepaint(_DiamondPercentPainter old) =>
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
