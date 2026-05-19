import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated External Link Icon - Arrow shifts outward
class ExternalLinkIcon extends AnimatedSVGIcon {
  const ExternalLinkIcon({
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
  String get animationDescription => 'Arrow shifts toward upper right';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _ExternalLinkPainter(color, animationValue, strokeWidth);
}

class _ExternalLinkPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _ExternalLinkPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = 4 * t * (1 - t);
    final d = pulse * 1.8;

    final box = Path()
      ..moveTo(18 * s, 13 * s)
      ..lineTo(18 * s, 19 * s)
      ..arcToPoint(Offset(16 * s, 21 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(5 * s, 21 * s)
      ..arcToPoint(Offset(3 * s, 19 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(3 * s, 8 * s)
      ..arcToPoint(Offset(5 * s, 6 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(11 * s, 6 * s);
    canvas.drawPath(box, paint);

    // Animated arrow: shifts up and to the right
    canvas.save();
    canvas.translate(d * s, -d * s);
    final corner = Path()
      ..moveTo(15 * s, 3 * s)
      ..lineTo(21 * s, 3 * s)
      ..lineTo(21 * s, 9 * s);
    canvas.drawPath(corner, paint);
    canvas.drawLine(Offset(10 * s, 14 * s), Offset(21 * s, 3 * s), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ExternalLinkPainter old) =>
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
