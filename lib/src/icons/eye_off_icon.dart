import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Eye Off Icon - Slash draws across the eye
class EyeOffIcon extends AnimatedSVGIcon {
  const EyeOffIcon({
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
  String get animationDescription => 'Slash draws across the eye';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EyeOffPainter(color, animationValue, strokeWidth);
}

class _EyeOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EyeOffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final topArc = Path()
      ..moveTo(10.733 * s, 5.076 * s)
      ..arcToPoint(Offset(21.938 * s, 11.651 * s),
          radius: Radius.circular(10.744 * s), clockwise: true)
      ..arcToPoint(Offset(21.938 * s, 12.347 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..arcToPoint(Offset(20.494 * s, 14.837 * s),
          radius: Radius.circular(10.747 * s), clockwise: true);
    final iris = Path()
      ..moveTo(14.084 * s, 14.158 * s)
      ..arcToPoint(Offset(9.842 * s, 9.916 * s),
          radius: Radius.circular(3 * s), clockwise: true);
    final bottomArc = Path()
      ..moveTo(17.479 * s, 17.499 * s)
      ..arcToPoint(Offset(2.062 * s, 12.348 * s),
          radius: Radius.circular(10.75 * s), clockwise: true)
      ..arcToPoint(Offset(2.062 * s, 11.652 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..arcToPoint(Offset(6.508 * s, 6.509 * s),
          radius: Radius.circular(10.75 * s), clockwise: true);

    canvas.drawPath(topArc, paint);
    canvas.drawPath(iris, paint);
    canvas.drawPath(bottomArc, paint);

    final slash = Path()
      ..moveTo(2 * s, 2 * s)
      ..lineTo(22 * s, 22 * s);
    canvas.drawPath(t == 0.0 ? slash : _extract(slash, t), paint);
  }

  @override
  bool shouldRepaint(_EyeOffPainter old) =>
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
