import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Car Icon - Car bounces
class CarIcon extends AnimatedSVGIcon {
  const CarIcon({
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
  String get animationDescription => "Car bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce: sine wave translation Y
    final bounce = math.sin(animationValue * math.pi * 2) * 1.0;

    return CarPainter(
      color: color,
      bounce: bounce,
      strokeWidth: strokeWidth,
    );
  }
}

class CarPainter extends CustomPainter {
  final Color color;
  final double bounce;
  final double strokeWidth;

  CarPainter({
    required this.color,
    required this.bounce,
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

    // Bounce the whole car? Or just the body?
    // If we bounce the whole car, wheels leave the ground.
    // If we bounce just the body, wheels stay.
    // Let's bounce just the body to simulate suspension.

    // Body
    // M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2

    canvas.save();
    canvas.translate(0, -bounce * scale);

    final bodyPath = Path();
    bodyPath.moveTo(19 * scale, 17 * scale);
    bodyPath.lineTo(21 * scale, 17 * scale);
    bodyPath.cubicTo(21.6 * scale, 17 * scale, 22 * scale, 16.6 * scale,
        22 * scale, 16 * scale);
    bodyPath.lineTo(22 * scale, 13 * scale);
    bodyPath.cubicTo(22 * scale, 12.1 * scale, 21.3 * scale, 11.3 * scale,
        20.5 * scale, 11.1 * scale);
    bodyPath.cubicTo(18.7 * scale, 10.6 * scale, 16 * scale, 10 * scale,
        16 * scale, 10 * scale);
    bodyPath.cubicTo(16 * scale, 10 * scale, 14.7 * scale, 8.6 * scale,
        13.8 * scale, 7.7 * scale);
    bodyPath.cubicTo(13.3 * scale, 7.3 * scale, 12.7 * scale, 7 * scale,
        12 * scale, 7 * scale);
    bodyPath.lineTo(5 * scale, 7 * scale);
    bodyPath.cubicTo(4.4 * scale, 7 * scale, 3.9 * scale, 7.4 * scale,
        3.6 * scale, 7.9 * scale);
    bodyPath.lineTo(2.2 * scale, 10.8 * scale);
    // A3.7 3.7 0 0 0 2 12
    bodyPath.arcToPoint(Offset(2 * scale, 12 * scale),
        radius: Radius.circular(3.7 * scale), clockwise: false);
    bodyPath.lineTo(2 * scale, 16 * scale);
    bodyPath.cubicTo(2 * scale, 16.6 * scale, 2.4 * scale, 17 * scale,
        3 * scale, 17 * scale);
    bodyPath.lineTo(5 * scale, 17 * scale);
    canvas.drawPath(bodyPath, paint);

    // M9 17h6
    canvas.drawLine(
        Offset(9 * scale, 17 * scale), Offset(15 * scale, 17 * scale), paint);

    canvas.restore();

    // Wheels (Static relative to ground, or moving with body?)
    // If suspension, wheels stay on ground.
    // circle cx="7" cy="17" r="2"
    // circle cx="17" cy="17" r="2"

    canvas.drawCircle(Offset(7 * scale, 17 * scale), 2 * scale, paint);
    canvas.drawCircle(Offset(17 * scale, 17 * scale), 2 * scale, paint);
  }

  @override
  bool shouldRepaint(CarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounce != bounce ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
