import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Egg Off Icon - Slash line draws across the egg
class EggOffIcon extends AnimatedSVGIcon {
  const EggOffIcon({
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
  String get animationDescription => 'Slash line draws across the egg';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EggOffPainter(color, animationValue, strokeWidth);
}

class _EggOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EggOffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final top = Path()
      ..moveTo(20 * s, 14.347 * s)
      ..lineTo(20 * s, 14 * s)
      ..cubicTo(20 * s, 8 * s, 16 * s, 2 * s, 12 * s, 2 * s)
      ..cubicTo(10.922 * s, 2 * s, 9.843 * s, 2.436 * s, 8.843 * s, 3.19 * s);
    final bottom = Path()
      ..moveTo(6.206 * s, 6.21 * s)
      ..cubicTo(4.871 * s, 8.4 * s, 4 * s, 11.2 * s, 4 * s, 14 * s)
      ..arcToPoint(Offset(18.568 * s, 18.568 * s),
          radius: Radius.circular(8 * s), clockwise: false);

    canvas.drawPath(top, paint);
    canvas.drawPath(bottom, paint);

    final slash = Path()
      ..moveTo(2 * s, 2 * s)
      ..lineTo(22 * s, 22 * s);
    canvas.drawPath(t == 0.0 ? slash : _extract(slash, t), paint);
  }

  @override
  bool shouldRepaint(_EggOffPainter old) =>
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
