import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Candy Cane Icon - Stripes move
class CandyCaneIcon extends AnimatedSVGIcon {
  const CandyCaneIcon({
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
  String get animationDescription => "Stripes move";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Move stripes along the cane
    // This is hard with static paths.
    // We can just wiggle the cane?
    // Or rotate it slightly?
    // Let's rotate/wiggle it.

    final wiggle =
        math.sin(animationValue * math.pi * 2) * (10 * math.pi / 180);

    return CandyCanePainter(
      color: color,
      wiggle: wiggle,
      strokeWidth: strokeWidth,
    );
  }
}

class CandyCanePainter extends CustomPainter {
  final Color color;
  final double wiggle;
  final double strokeWidth;

  CandyCanePainter({
    required this.color,
    required this.wiggle,
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

    // Rotate around bottom center?
    // Center of bounding box?
    // Let's rotate around center of mass roughly (12, 12).

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(wiggle);
    canvas.translate(-12 * scale, -12 * scale);

    // M5.7 21a2 2 0 0 1-3.5-2l8.6-14a6 6 0 0 1 10.4 6 2 2 0 1 1-3.464-2 2 2 0 1 0-3.464-2Z
    final canePath = Path();
    canePath.moveTo(5.7 * scale, 21 * scale);
    canePath.arcToPoint(Offset(2.2 * scale, 19 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canePath.lineTo(10.8 * scale, 5 * scale);
    canePath.arcToPoint(Offset(21.2 * scale, 11 * scale),
        radius: Radius.circular(6 * scale), clockwise: true);
    canePath.arcToPoint(Offset(17.736 * scale, 9 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canePath.arcToPoint(Offset(14.272 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    canePath.close();
    canvas.drawPath(canePath, paint);

    // Stripes
    // M17.75 7 15 2.1
    canvas.drawLine(Offset(17.75 * scale, 7 * scale),
        Offset(15 * scale, 2.1 * scale), paint);
    // M10.9 4.8 13 9
    canvas.drawLine(Offset(10.9 * scale, 4.8 * scale),
        Offset(13 * scale, 9 * scale), paint);
    // m7.9 9.7 2 4.4
    canvas.drawLine(Offset(7.9 * scale, 9.7 * scale),
        Offset(9.9 * scale, 14.1 * scale), paint);
    // M4.9 14.7 7 18.9
    canvas.drawLine(Offset(4.9 * scale, 14.7 * scale),
        Offset(7 * scale, 18.9 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CandyCanePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.wiggle != wiggle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
