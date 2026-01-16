import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bus Front Icon - Bus rocks side to side
class BusFrontIcon extends AnimatedSVGIcon {
  const BusFrontIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Bus rocks side to side";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Rocking: -angle -> +angle -> -angle
    // sin wave
    final angle =
        math.sin(animationValue * math.pi * 2) * 0.05; // Small rotation

    return BusFrontPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class BusFrontPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  BusFrontPainter({
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

    // Pivot at bottom center (12, 21)
    final pivotX = 12.0 * scale;
    final pivotY = 21.0 * scale;

    canvas.save();
    canvas.translate(pivotX, pivotY);
    canvas.rotate(angle);
    canvas.translate(-pivotX, -pivotY);

    // Mirrors (Attached to bus, move with it)
    // M4 6 2 7
    canvas.drawLine(
        Offset(4 * scale, 6 * scale), Offset(2 * scale, 7 * scale), paint);
    // m22 7-2-1 -> M22 7 L20 6
    canvas.drawLine(
        Offset(22 * scale, 7 * scale), Offset(20 * scale, 6 * scale), paint);

    // Top Sign
    // M10 6h4
    canvas.drawLine(
        Offset(10 * scale, 6 * scale), Offset(14 * scale, 6 * scale), paint);

    // Body
    // rect width="16" height="16" x="4" y="3" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 3 * scale, 16 * scale, 16 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Windshield Line
    // M4 11h16
    canvas.drawLine(
        Offset(4 * scale, 11 * scale), Offset(20 * scale, 11 * scale), paint);

    // Lights
    // M8 15h.01
    canvas.drawLine(
        Offset(8 * scale, 15 * scale), Offset(8.01 * scale, 15 * scale), paint);
    // M16 15h.01
    canvas.drawLine(Offset(16 * scale, 15 * scale),
        Offset(16.01 * scale, 15 * scale), paint);

    // Wheels
    // M6 19v2
    canvas.drawLine(
        Offset(6 * scale, 19 * scale), Offset(6 * scale, 21 * scale), paint);
    // M18 21v-2 -> M18 21 L18 19
    canvas.drawLine(
        Offset(18 * scale, 21 * scale), Offset(18 * scale, 19 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(BusFrontPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
