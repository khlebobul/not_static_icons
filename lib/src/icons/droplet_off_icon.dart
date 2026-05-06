import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Droplet Off Icon - broken droplet squishes behind static slash
class DropletOffIcon extends AnimatedSVGIcon {
  const DropletOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
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
  String get animationDescription =>
      'Broken droplet squishes with static slash';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DropletOffPainter(color, animationValue, strokeWidth);
}

class _DropletOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DropletOffPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final squash = math.sin(math.pi * t) * 0.06;
    canvas.save();
    canvas.translate(12 * s, 14 * s);
    canvas.scale(1 + squash, 1 - squash);
    canvas.translate(-12 * s, -14 * s);
    final top = Path()
      ..moveTo(18.715 * s, 13.186 * s)
      ..cubicTo(18.29 * s, 11.858 * s, 17.384 * s, 10.607 * s, 16 * s, 9.5 * s)
      ..cubicTo(14 * s, 7.9 * s, 12.5 * s, 5.5 * s, 12 * s, 3 * s)
      ..cubicTo(11.78 * s, 4.1 * s, 11.48 * s, 4.95 * s, 11.116 * s, 5.586 * s);
    final bottom = Path()
      ..moveTo(8.795 * s, 8.797 * s)
      ..cubicTo(8.55 * s, 9.04 * s, 8.28 * s, 9.27 * s, 8 * s, 9.5 * s)
      ..cubicTo(6 * s, 11.1 * s, 5 * s, 13 * s, 5 * s, 15 * s)
      ..arcToPoint(Offset(18.222 * s, 18.208 * s),
          radius: Radius.circular(7 * s), clockwise: false);
    canvas.drawPath(top, paint);
    canvas.drawPath(bottom, paint);
    canvas.restore();
    canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);
  }

  @override
  bool shouldRepaint(_DropletOffPainter old) =>
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
