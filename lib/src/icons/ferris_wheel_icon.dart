import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ferris Wheel Icon - wheel rotates around its hub
class FerrisWheelIcon extends AnimatedSVGIcon {
  const FerrisWheelIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
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
  String get animationDescription => 'Ferris wheel rotates';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FerrisWheelPainter(color, animationValue, strokeWidth);
}

class _FerrisWheelPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _FerrisWheelPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Static: base bar M8 22h8
    canvas.drawLine(Offset(8 * s, 22 * s), Offset(16 * s, 22 * s), paint);

    // Static: bottom gondola m9 22 3-8 3 8
    final gondola = Path()
      ..moveTo(9 * s, 22 * s)
      ..lineTo(12 * s, 14 * s)
      ..lineTo(15 * s, 22 * s);
    canvas.drawPath(gondola, paint);

    // Rotating group around hub (12, 12)
    final hub = Offset(12 * s, 12 * s);
    canvas.save();
    canvas.translate(hub.dx, hub.dy);
    canvas.rotate(2 * math.pi * t);
    canvas.translate(-hub.dx, -hub.dy);

    // Outer ring arc: M18 18.7a9 9 0 1 0-12 0
    final ring = Path()
      ..moveTo(18 * s, 18.7 * s)
      ..arcToPoint(Offset(6 * s, 18.7 * s),
          radius: Radius.circular(9 * s), largeArc: true, clockwise: false);
    canvas.drawPath(ring, paint);

    // Center hub circle: circle cx=12 cy=12 r=2
    canvas.drawCircle(hub, 2 * s, paint);

    // Spokes:
    // M12 2v4
    canvas.drawLine(Offset(12 * s, 2 * s), Offset(12 * s, 6 * s), paint);
    // M6.8 9 3.3 7
    canvas.drawLine(Offset(6.8 * s, 9 * s), Offset(3.3 * s, 7 * s), paint);
    // m20.7 7-3.5 2  → (20.7,7) to (17.2,9)
    canvas.drawLine(Offset(20.7 * s, 7 * s), Offset(17.2 * s, 9 * s), paint);
    // m6.8 15-3.5 2  → (6.8,15) to (3.3,17)
    canvas.drawLine(Offset(6.8 * s, 15 * s), Offset(3.3 * s, 17 * s), paint);
    // m20.7 17-3.5-2 → (20.7,17) to (17.2,15)
    canvas.drawLine(Offset(20.7 * s, 17 * s), Offset(17.2 * s, 15 * s), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_FerrisWheelPainter old) =>
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
