import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Cable Car Icon - Car moves along the cable
class CableCarIcon extends AnimatedSVGIcon {
  const CableCarIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Cable car moves along the cable";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Movement: Slide back and forth along the cable
    // Cable goes from (2,9) to (22,4).
    // Vector: (20, -5).
    // Let's oscillate around the center.

    final sine = math.sin(animationValue * math.pi * 2);
    final offsetFactor = sine * 0.2; // Move 20% of the way

    return CableCarPainter(
      color: color,
      offsetFactor: offsetFactor,
      strokeWidth: strokeWidth,
    );
  }
}

class CableCarPainter extends CustomPainter {
  final Color color;
  final double offsetFactor;
  final double strokeWidth;

  CableCarPainter({
    required this.color,
    required this.offsetFactor,
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

    // Static Cable
    // m2 9 20-5 -> M2 9 L22 4
    canvas.drawLine(
        Offset(2 * scale, 9 * scale), Offset(22 * scale, 4 * scale), paint);

    // Static dots on cable?
    // M10 3h.01
    canvas.drawLine(
        Offset(10 * scale, 3 * scale), Offset(10.01 * scale, 3 * scale), paint);
    // M14 2h.01
    canvas.drawLine(
        Offset(14 * scale, 2 * scale), Offset(14.01 * scale, 2 * scale), paint);

    // Moving Car
    // Calculate translation based on cable slope
    // Cable vector (20, -5).
    final dx = 20.0 * offsetFactor;
    final dy = -5.0 * offsetFactor;

    canvas.save();
    canvas.translate(dx * scale, dy * scale);

    // Hanger
    // M12 12V6.5
    // Note: 6.5 is on the cable line?
    // At x=12 (midpoint), y on cable:
    // Start (2,9). Slope -5/20 = -0.25.
    // y = 9 + (x-2)*(-0.25).
    // At x=12: y = 9 + 10*(-0.25) = 9 - 2.5 = 6.5. Correct.
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(12 * scale, 6.5 * scale), paint);

    // Car Body
    // rect width="16" height="10" x="4" y="12" rx="3"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 12 * scale, 16 * scale, 10 * scale),
      Radius.circular(3 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Windows/Details
    // M9 12v5
    canvas.drawLine(
        Offset(9 * scale, 12 * scale), Offset(9 * scale, 17 * scale), paint);
    // M15 12v5
    canvas.drawLine(
        Offset(15 * scale, 12 * scale), Offset(15 * scale, 17 * scale), paint);
    // M4 17h16
    canvas.drawLine(
        Offset(4 * scale, 17 * scale), Offset(20 * scale, 17 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CableCarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offsetFactor != offsetFactor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
