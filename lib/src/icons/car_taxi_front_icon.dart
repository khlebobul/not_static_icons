import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Car Taxi Front Icon - Car rocks side to side
class CarTaxiFrontIcon extends AnimatedSVGIcon {
  const CarTaxiFrontIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Car rocks side to side";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Rocking: sine wave rotation
    final angle = math.sin(animationValue * math.pi * 2) * (5 * math.pi / 180);

    return CarTaxiFrontPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CarTaxiFrontPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CarTaxiFrontPainter({
    required this.color,
    required this.angle,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // Rotate around bottom center (12, 20)
    canvas.save();
    canvas.translate(12 * scale, 20 * scale);
    canvas.rotate(angle);
    canvas.translate(-12 * scale, -20 * scale);

    // M10 2h4 (Taxi sign)
    canvas.drawLine(
        Offset(10 * scale, 2 * scale), Offset(14 * scale, 2 * scale), paint);

    // m21 8-2 2-1.5-3.7A2 2 0 0 0 15.646 5H8.4a2 2 0 0 0-1.903 1.257L5 10 3 8
    final topPath = Path();
    topPath.moveTo(21 * scale, 8 * scale);
    topPath.lineTo(19 * scale, 10 * scale);
    topPath.lineTo(17.5 * scale, 6.3 * scale);
    topPath.arcToPoint(Offset(15.646 * scale, 5 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    topPath.lineTo(8.4 * scale, 5 * scale);
    topPath.arcToPoint(Offset(6.497 * scale, 6.257 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    topPath.lineTo(5 * scale, 10 * scale);
    topPath.lineTo(3 * scale, 8 * scale);
    canvas.drawPath(topPath, paint);

    // rect width="18" height="8" x="3" y="10" rx="2"
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 10 * scale, 18 * scale, 8 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(bodyRect, paint);

    // M7 14h.01
    canvas.drawLine(
        Offset(7 * scale, 14 * scale), Offset(7.01 * scale, 14 * scale), paint);

    // M17 14h.01
    canvas.drawLine(Offset(17 * scale, 14 * scale),
        Offset(17.01 * scale, 14 * scale), paint);

    // M5 18v2
    canvas.drawLine(
        Offset(5 * scale, 18 * scale), Offset(5 * scale, 20 * scale), paint);

    // M19 18v2
    canvas.drawLine(
        Offset(19 * scale, 18 * scale), Offset(19 * scale, 20 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CarTaxiFrontPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
