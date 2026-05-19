import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ear Off Icon - Diagonal slash draws across the ear
class EarOffIcon extends AnimatedSVGIcon {
  const EarOffIcon({
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
  String get animationDescription => 'Slash line draws across the ear';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EarOffPainter(color, animationValue, strokeWidth);
}

class _EarOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EarOffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final ear1 = Path()
      ..moveTo(6 * s, 18.5 * s)
      ..arcToPoint(Offset(13 * s, 18.5 * s),
          radius: Radius.circular(3.5 * s), clockwise: false)
      ..cubicTo(13 * s, 16.93 * s, 13.92 * s, 15.98 * s, 15.04 * s, 15.04 * s);
    final ear2 = Path()
      ..moveTo(6 * s, 8.5 * s)
      ..cubicTo(6 * s, 7.75 * s, 6.13 * s, 7.03 * s, 6.36 * s, 6.36 * s);
    final ear3 = Path()
      ..moveTo(8.8 * s, 3.15 * s)
      ..arcToPoint(Offset(19 * s, 8.5 * s),
          radius: Radius.circular(6.5 * s), clockwise: true)
      ..cubicTo(19 * s, 10.13 * s, 18.56 * s, 11.31 * s, 17.91 * s, 12.26 * s);
    final ear4 = Path()
      ..moveTo(12.5 * s, 6 * s)
      ..arcToPoint(Offset(15 * s, 8.5 * s),
          radius: Radius.circular(2.5 * s), clockwise: true);
    final ear5 = Path()
      ..moveTo(10 * s, 13 * s)
      ..arcToPoint(Offset(11.82 * s, 11.82 * s),
          radius: Radius.circular(2 * s), clockwise: false);

    canvas.drawPath(ear1, paint);
    canvas.drawPath(ear2, paint);
    canvas.drawPath(ear3, paint);
    canvas.drawPath(ear4, paint);
    canvas.drawPath(ear5, paint);

    final slash = Path()
      ..moveTo(2 * s, 2 * s)
      ..lineTo(22 * s, 22 * s);
    canvas.drawPath(t == 0.0 ? slash : _extract(slash, t), paint);
  }

  @override
  bool shouldRepaint(_EarOffPainter old) =>
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
