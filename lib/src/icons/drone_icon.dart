import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Drone Icon - original propeller arcs spin around the body
class DroneIcon extends AnimatedSVGIcon {
  const DroneIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
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
  String get animationDescription => 'Drone propellers spin';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DronePainter(color, animationValue, strokeWidth);
}

class _DronePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DronePainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    canvas.drawLine(Offset(10 * s, 10 * s), Offset(7 * s, 7 * s), paint);
    canvas.drawLine(Offset(10 * s, 14 * s), Offset(7 * s, 17 * s), paint);
    canvas.drawLine(Offset(14 * s, 10 * s), Offset(17 * s, 7 * s), paint);
    canvas.drawLine(Offset(14 * s, 14 * s), Offset(17 * s, 17 * s), paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(10 * s, 8 * s, 4 * s, 8 * s), Radius.circular(1 * s)),
      paint,
    );

    _drawPropeller(
      canvas,
      paint,
      center: Offset(17 * s, 7 * s),
      rotation: 2 * math.pi * t,
      path: Path()
        ..moveTo(14.205 * s, 4.139 * s)
        ..arcToPoint(Offset(19.644 * s, 10.002 * s),
            radius: Radius.circular(4 * s), largeArc: true, clockwise: true),
    );
    _drawPropeller(
      canvas,
      paint,
      center: Offset(17 * s, 17 * s),
      rotation: 2 * math.pi * t,
      path: Path()
        ..moveTo(19.637 * s, 14 * s)
        ..arcToPoint(Offset(14.205 * s, 19.868 * s),
            radius: Radius.circular(4 * s), largeArc: true, clockwise: true),
    );
    _drawPropeller(
      canvas,
      paint,
      center: Offset(7 * s, 7 * s),
      rotation: 2 * math.pi * t,
      path: Path()
        ..moveTo(4.367 * s, 10 * s)
        ..arcToPoint(Offset(9.805 * s, 4.138 * s),
            radius: Radius.circular(4 * s), largeArc: true, clockwise: true),
    );
    _drawPropeller(
      canvas,
      paint,
      center: Offset(7 * s, 17 * s),
      rotation: 2 * math.pi * t,
      path: Path()
        ..moveTo(9.795 * s, 19.862 * s)
        ..arcToPoint(Offset(4.366 * s, 13.989 * s),
            radius: Radius.circular(4 * s), largeArc: true, clockwise: true),
    );
  }

  @override
  bool shouldRepaint(_DronePainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

void _drawPropeller(
  Canvas canvas,
  Paint paint, {
  required Offset center,
  required double rotation,
  required Path path,
}) {
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(rotation);
  canvas.translate(-center.dx, -center.dy);
  canvas.drawPath(path, paint);
  canvas.restore();
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
