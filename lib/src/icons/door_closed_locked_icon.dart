import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Door Closed Locked Icon - lock shackle bounces subtly
class DoorClosedLockedIcon extends AnimatedSVGIcon {
  const DoorClosedLockedIcon({
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
  String get animationDescription => 'Lock shackle bounces on closed door';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DoorClosedLockedPainter(color, animationValue, strokeWidth);
}

class _DoorClosedLockedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DoorClosedLockedPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final lockDy = t == 0.0 ? 0.0 : -math.sin(math.pi * t) * 0.9 * s;

    canvas.drawLine(Offset(10 * s, 12 * s), Offset(10.01 * s, 12 * s), paint);
    final door = Path()
      ..moveTo(18 * s, 9 * s)
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
    canvas.drawLine(Offset(2 * s, 20 * s), Offset(10 * s, 20 * s), paint);

    canvas.save();
    canvas.translate(0, lockDy);
    final shackle = Path()
      ..moveTo(20 * s, 17 * s)
      ..lineTo(20 * s, 15 * s)
      ..arcToPoint(
        Offset(16 * s, 15 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(16 * s, 17 * s);
    canvas.drawPath(shackle, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(14 * s, 17 * s, 8 * s, 5 * s),
        Radius.circular(1 * s),
      ),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DoorClosedLockedPainter old) =>
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
