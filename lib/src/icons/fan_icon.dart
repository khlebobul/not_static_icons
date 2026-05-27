import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Fan Icon - fan blades rotate around the center
class FanIcon extends AnimatedSVGIcon {
  const FanIcon({
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
  String get animationDescription => 'Fan blades spin';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FanPainter(color, animationValue, strokeWidth);
}

class _FanPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FanPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    final center = Offset(12 * s, 12 * s);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * math.pi * t);
    canvas.translate(-center.dx, -center.dy);

    // Fan blade shape:
    // M10.827 16.379a6.082 6.082 0 0 1-8.618-7.002l5.412 1.45
    //   a6.082 6.082 0 0 1 7.002-8.618l-1.45 5.412
    //   a6.082 6.082 0 0 1 8.618 7.002l-5.412-1.45
    //   a6.082 6.082 0 0 1-7.002 8.618l1.45-5.412Z
    final blades = Path()
      ..moveTo(10.827 * s, 16.379 * s)
      ..arcToPoint(Offset(2.209 * s, 9.377 * s),
          radius: Radius.circular(6.082 * s), clockwise: true)
      ..lineTo(7.621 * s, 10.827 * s)
      ..arcToPoint(Offset(14.623 * s, 2.209 * s),
          radius: Radius.circular(6.082 * s), clockwise: true)
      ..lineTo(13.173 * s, 7.621 * s)
      ..arcToPoint(Offset(21.791 * s, 14.623 * s),
          radius: Radius.circular(6.082 * s), clockwise: true)
      ..lineTo(16.379 * s, 13.173 * s)
      ..arcToPoint(Offset(9.377 * s, 21.791 * s),
          radius: Radius.circular(6.082 * s), clockwise: true)
      ..lineTo(10.827 * s, 16.379 * s)
      ..close();
    canvas.drawPath(blades, paint);

    canvas.restore();

    // Center dot: M12 12v.01
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, strokeWidth * 0.6, dotPaint);
  }

  @override
  bool shouldRepaint(_FanPainter old) =>
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
