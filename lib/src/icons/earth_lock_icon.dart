import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Earth Lock Icon - Lock shackle bounces
class EarthLockIcon extends AnimatedSVGIcon {
  const EarthLockIcon({
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
  String get animationDescription => 'Lock shackle bounces above the globe';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _EarthLockPainter(color, animationValue, strokeWidth);
}

class _EarthLockPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _EarthLockPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);
    final lift = -math.sin(math.pi * t) * 1.5 * s;

    final globe1 = Path()
      ..moveTo(7 * s, 3.34 * s)
      ..lineTo(7 * s, 5 * s)
      ..arcToPoint(Offset(10 * s, 8 * s),
          radius: Radius.circular(3 * s), clockwise: false);
    final globe2 = Path()
      ..moveTo(11 * s, 21.95 * s)
      ..lineTo(11 * s, 18 * s)
      ..arcToPoint(Offset(9 * s, 16 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..arcToPoint(Offset(7 * s, 14 * s),
          radius: Radius.circular(2 * s), clockwise: true)
      ..lineTo(7 * s, 13 * s)
      ..arcToPoint(Offset(5 * s, 11 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(2.05 * s, 11 * s);
    final globe3 = Path()
      ..moveTo(21.54 * s, 15 * s)
      ..lineTo(17 * s, 15 * s)
      ..arcToPoint(Offset(15 * s, 17 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(15 * s, 21.54 * s);
    final globe4 = Path()
      ..moveTo(12 * s, 2 * s)
      ..arcToPoint(Offset(21.54 * s, 15 * s),
          radius: Radius.circular(10 * s), largeArc: true, clockwise: false);

    canvas.drawPath(globe1, paint);
    canvas.drawPath(globe2, paint);
    canvas.drawPath(globe3, paint);
    canvas.drawPath(globe4, paint);

    // Lock body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(14 * s, 6 * s, 8 * s, 5 * s),
        Radius.circular(1 * s),
      ),
      paint,
    );

    // Shackle bounces
    canvas.save();
    canvas.translate(0, lift);
    final shackle = Path()
      ..moveTo(20 * s, 6 * s)
      ..lineTo(20 * s, 4 * s)
      ..arcToPoint(Offset(16 * s, 4 * s),
          radius: Radius.circular(2 * s), largeArc: true, clockwise: false)
      ..lineTo(16 * s, 6 * s);
    canvas.drawPath(shackle, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_EarthLockPainter old) =>
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
