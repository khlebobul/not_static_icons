import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Carrot Icon - Carrot wiggles
class CarrotIcon extends AnimatedSVGIcon {
  const CarrotIcon({
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
  String get animationDescription => "Carrot wiggles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Wiggle: sine wave rotation
    final angle = math.sin(animationValue * math.pi * 2) * (10 * math.pi / 180);

    return CarrotPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CarrotPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CarrotPainter({
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

    // Rotate around tip (2, 22)
    canvas.save();
    canvas.translate(2 * scale, 22 * scale);
    canvas.rotate(angle);
    canvas.translate(-2 * scale, -22 * scale);

    // Body
    // M2.27 21.7s9.87-3.5 12.73-6.36a4.5 4.5 0 0 0-6.36-6.37C5.77 11.84 2.27 21.7 2.27 21.7z
    final bodyPath = Path();
    bodyPath.moveTo(2.27 * scale, 21.7 * scale);
    bodyPath.cubicTo(
      2.27 * scale, 21.7 * scale, // CP1
      (2.27 + 9.87) * scale, (21.7 - 3.5) * scale, // CP2
      (2.27 + 12.73) * scale, (21.7 - 6.36) * scale, // End
    );

    // a4.5 4.5 0 0 0-6.36-6.37
    // End point was 15, 15.34.
    // dx = -6.36, dy = -6.37.
    // New end = 15-6.36 = 8.64, 15.34-6.37 = 8.97.
    bodyPath.arcToPoint(
      Offset((2.27 + 12.73 - 6.36) * scale, (21.7 - 6.36 - 6.37) * scale),
      radius: Radius.circular(4.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // C5.77 11.84 2.27 21.7 2.27 21.7z
    bodyPath.cubicTo(
      5.77 * scale,
      11.84 * scale,
      2.27 * scale,
      21.7 * scale,
      2.27 * scale,
      21.7 * scale,
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, paint);

    // Lines
    // M8.64 14l-2.05-2.04
    canvas.drawLine(Offset(8.64 * scale, 14 * scale),
        Offset((8.64 - 2.05) * scale, (14 - 2.04) * scale), paint);

    // M15.34 15l-2.46-2.46
    canvas.drawLine(Offset(15.34 * scale, 15 * scale),
        Offset((15.34 - 2.46) * scale, (15 - 2.46) * scale), paint);

    // Leaves
    // M22 9s-1.33-2-3.5-2C16.86 7 15 9 15 9s1.33 2 3.5 2S22 9 22 9z
    final leaf1 = Path();
    leaf1.moveTo(22 * scale, 9 * scale);
    // s-1.33-2-3.5-2
    leaf1.cubicTo(
      22 * scale, 9 * scale, // CP1
      (22 - 1.33) * scale, (9 - 2) * scale, // CP2
      (22 - 3.5) * scale, (9 - 2) * scale, // End: 18.5, 7
    );
    // C16.86 7 15 9 15 9
    leaf1.cubicTo(
      16.86 * scale,
      7 * scale,
      15 * scale,
      9 * scale,
      15 * scale,
      9 * scale,
    );
    // s1.33 2 3.5 2
    leaf1.cubicTo(
      15 * scale, 9 * scale, // CP1
      (15 + 1.33) * scale, (9 + 2) * scale, // CP2
      (15 + 3.5) * scale, (9 + 2) * scale, // End: 18.5, 11
    );
    // S22 9 22 9z
    leaf1.cubicTo(
      (18.5 + (18.5 - (15 + 1.33))) * scale,
      (11 + (11 - (9 + 2))) * scale, // Reflection of previous CP2?
      // S command: first control point is reflection of previous second control point.
      // Previous CP2 was 16.33, 11. End was 18.5, 11.
      // Reflection of 16.33 around 18.5 is 20.67.
      // So CP1 is 20.67, 11.
      // CP2 is 22, 9. End is 22, 9.
      22 * scale, 9 * scale,
      22 * scale, 9 * scale,
    );
    leaf1.close();
    canvas.drawPath(leaf1, paint);

    // M15 2s-2 1.33-2 3.5S15 9 15 9s2-1.84 2-3.5C17 3.33 15 2 15 2z
    final leaf2 = Path();
    leaf2.moveTo(15 * scale, 2 * scale);
    // s-2 1.33-2 3.5
    leaf2.cubicTo(
      15 * scale, 2 * scale,
      (15 - 2) * scale, (2 + 1.33) * scale,
      (15 - 2) * scale, (2 + 3.5) * scale, // 13, 5.5
    );
    // S15 9 15 9
    // Previous CP2: 13, 3.33. End: 13, 5.5.
    // Reflection: 13, 7.67.
    leaf2.cubicTo(
      13 * scale,
      7.67 * scale,
      15 * scale,
      9 * scale,
      15 * scale,
      9 * scale,
    );
    // s2-1.84 2-3.5
    leaf2.cubicTo(
      15 * scale, 9 * scale,
      (15 + 2) * scale, (9 - 1.84) * scale,
      (15 + 2) * scale, (9 - 3.5) * scale, // 17, 5.5
    );
    // C17 3.33 15 2 15 2z
    leaf2.cubicTo(
      17 * scale,
      3.33 * scale,
      15 * scale,
      2 * scale,
      15 * scale,
      2 * scale,
    );
    leaf2.close();
    canvas.drawPath(leaf2, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CarrotPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
