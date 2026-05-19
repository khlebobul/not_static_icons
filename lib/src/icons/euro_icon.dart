import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Euro Icon - Bars slide outward then back
class EuroIcon extends AnimatedSVGIcon {
  const EuroIcon({
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
  String get animationDescription => 'Horizontal bars extend then retract';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EuroPainter(color, animationValue, strokeWidth);
}

class _EuroPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EuroPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = 4 * t * (1 - t);
    final ext = pulse * 1.5;

    final c = Path()
      ..moveTo(19 * s, 6 * s)
      ..arcToPoint(Offset(13.8 * s, 4 * s),
          radius: Radius.circular(6 * s), clockwise: false)
      ..arcToPoint(Offset(6 * s, 12 * s),
          radius: Radius.circular(8 * s), clockwise: false)
      ..cubicTo(6 * s, 16.4 * s, 9.5 * s, 20 * s, 13.8 * s, 20 * s)
      ..arcToPoint(Offset(19 * s, 18 * s),
          radius: Radius.circular(8 * s), clockwise: false);
    canvas.drawPath(c, paint);

    canvas.drawLine(
      Offset((4 - ext) * s, 10 * s),
      Offset((16 + ext) * s, 10 * s),
      paint,
    );
    canvas.drawLine(
      Offset((4 - ext) * s, 14 * s),
      Offset((13 + ext) * s, 14 * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EuroPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
