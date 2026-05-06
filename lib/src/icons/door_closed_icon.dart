import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Door Closed Icon - knob nudges as if the door is checked
class DoorClosedIcon extends AnimatedSVGIcon {
  const DoorClosedIcon({
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
  String get animationDescription => 'Door knob nudges';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DoorClosedPainter(color, animationValue, strokeWidth);
}

class _DoorClosedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DoorClosedPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final knobDx = t == 0.0 ? 0.0 : math.sin(math.pi * t) * 0.8 * s;

    canvas.drawLine(Offset(10 * s + knobDx, 12 * s),
        Offset(10.01 * s + knobDx, 12 * s), paint);
    final door = Path()
      ..moveTo(18 * s, 20 * s)
      ..lineTo(18 * s, 6 * s)
      ..arcToPoint(
        Offset(16 * s, 4 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(8 * s, 4 * s)
      ..arcToPoint(
        Offset(6 * s, 6 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(6 * s, 20 * s);
    canvas.drawPath(door, paint);
    canvas.drawLine(Offset(2 * s, 20 * s), Offset(22 * s, 20 * s), paint);
  }

  @override
  bool shouldRepaint(_DoorClosedPainter old) =>
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
