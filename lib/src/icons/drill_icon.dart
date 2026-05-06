import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drill Icon - original body with a small motor pulse
class DrillIcon extends AnimatedSVGIcon {
  const DrillIcon({
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
  String get animationDescription => 'Drill motor pulse';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DrillPainter(color, animationValue, strokeWidth);
}

class _DrillPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DrillPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = t == 0 ? 0.0 : math.sin(math.pi * t);

    final handle = Path()
      ..moveTo(10 * s, 18 * s)
      ..arcToPoint(Offset(11 * s, 19 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(11 * s, 21 * s)
      ..arcToPoint(Offset(10 * s, 22 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(5 * s, 22 * s)
      ..arcToPoint(Offset(2 * s, 19 * s),
          radius: Radius.circular(3 * s), clockwise: true)
      ..arcToPoint(Offset(3 * s, 18 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..close();
    canvas.drawPath(handle, paint);

    final body = Path()
      ..moveTo(13 * s, 10 * s)
      ..lineTo(4 * s, 10 * s)
      ..arcToPoint(Offset(2 * s, 8 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(2 * s, 4 * s)
      ..arcToPoint(Offset(4 * s, 2 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(13 * s, 2 * s)
      ..arcToPoint(Offset(14 * s, 3 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(14 * s, 9 * s)
      ..arcToPoint(Offset(13 * s, 10 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(12.19 * s, 13.242 * s)
      ..arcToPoint(Offset(11.22 * s, 14 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(8 * s, 14 * s);
    canvas.drawPath(body, paint);

    final chuck = Path()
      ..moveTo(14 * s, 4 * s)
      ..lineTo(17 * s, 4 * s)
      ..arcToPoint(Offset(18 * s, 5 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(18 * s, 7 * s)
      ..arcToPoint(Offset(17 * s, 8 * s),
          radius: Radius.circular(1 * s), clockwise: true)
      ..lineTo(14 * s, 8 * s);
    canvas.drawPath(chuck, paint);
    canvas.drawLine(Offset(18 * s, 6 * s), Offset(22 * s, 6 * s), paint);
    canvas.drawLine(Offset(5 * s, 10 * s), Offset(3 * s, 18 * s), paint);
    canvas.drawLine(Offset(7 * s, 18 * s), Offset(9 * s, 10 * s), paint);

    if (pulse > 0) {
      final pulsePaint = _paint(color.withValues(alpha: 0.45 * pulse), strokeWidth);
      canvas.drawLine(
          Offset(19.2 * s, 4.7 * s), Offset(21.2 * s, 4.7 * s), pulsePaint);
      canvas.drawLine(
          Offset(19.2 * s, 7.3 * s), Offset(21.2 * s, 7.3 * s), pulsePaint);
    }
  }

  @override
  bool shouldRepaint(_DrillPainter old) =>
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
