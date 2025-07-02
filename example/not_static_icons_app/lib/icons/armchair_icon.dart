import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Armchair Icon - Swinging side to side
class ArmchairIcon extends AnimatedSVGIcon {
  const ArmchairIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
  });

  @override
  String get animationDescription =>
      "Rocking back and forth like a rocking chair";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return ArmchairPainter(color: color, animationValue: animationValue);
  }
}

/// Painter for Armchair icon
class ArmchairPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  ArmchairPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // Calculate rocking scale - rock back and forth (forward/backward)
    final rockScale =
        sin(animationValue * 2 * pi) * 0.12; // Scale variation for depth effect

    // Apply rocking animation with scale transformation to simulate forward/backward tilt
    canvas.save();
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    // Create forward/backward rocking effect using scale transformation
    final scaleY = 1.0 + rockScale; // Vertical scale changes to simulate depth
    final offsetY = rockScale * size.height * 0.1; // Slight vertical offset

    canvas.scale(1.0, scaleY);
    canvas.translate(0, offsetY);
    canvas.translate(-center.dx, -center.dy);

    // Draw the chair back: M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3
    final backPath = Path();
    backPath.moveTo(19 * scale, 9 * scale);
    backPath.lineTo(19 * scale, 6 * scale);
    backPath.cubicTo(
      19 * scale,
      4.9 * scale,
      18.1 * scale,
      4 * scale,
      17 * scale,
      4 * scale,
    );
    backPath.lineTo(7 * scale, 4 * scale);
    backPath.cubicTo(
      5.9 * scale,
      4 * scale,
      5 * scale,
      4.9 * scale,
      5 * scale,
      6 * scale,
    );
    backPath.lineTo(5 * scale, 9 * scale);

    canvas.drawPath(backPath, paint);

    // Draw the main seat and armrests: M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z
    final seatPath = Path();
    seatPath.moveTo(3 * scale, 16 * scale);
    seatPath.cubicTo(
      3 * scale,
      17.1 * scale,
      3.9 * scale,
      18 * scale,
      5 * scale,
      18 * scale,
    );
    seatPath.lineTo(19 * scale, 18 * scale);
    seatPath.cubicTo(
      20.1 * scale,
      18 * scale,
      21 * scale,
      17.1 * scale,
      21 * scale,
      16 * scale,
    );
    seatPath.lineTo(21 * scale, 11 * scale);
    seatPath.cubicTo(
      21 * scale,
      9.9 * scale,
      20.1 * scale,
      9 * scale,
      19 * scale,
      9 * scale,
    );
    seatPath.cubicTo(
      17.9 * scale,
      9 * scale,
      17 * scale,
      9.9 * scale,
      17 * scale,
      11 * scale,
    );
    seatPath.lineTo(17 * scale, 12.5 * scale);
    seatPath.cubicTo(
      17 * scale,
      12.8 * scale,
      16.8 * scale,
      13 * scale,
      16.5 * scale,
      13 * scale,
    );
    seatPath.lineTo(7.5 * scale, 13 * scale);
    seatPath.cubicTo(
      7.2 * scale,
      13 * scale,
      7 * scale,
      12.8 * scale,
      7 * scale,
      12.5 * scale,
    );
    seatPath.lineTo(7 * scale, 11 * scale);
    seatPath.cubicTo(
      7 * scale,
      9.9 * scale,
      6.1 * scale,
      9 * scale,
      5 * scale,
      9 * scale,
    );
    seatPath.cubicTo(
      3.9 * scale,
      9 * scale,
      3 * scale,
      9.9 * scale,
      3 * scale,
      11 * scale,
    );
    seatPath.close();

    canvas.drawPath(seatPath, paint);

    // Draw left leg: M5 18v2
    final leftLegPath = Path();
    leftLegPath.moveTo(5 * scale, 18 * scale);
    leftLegPath.lineTo(5 * scale, 20 * scale);
    canvas.drawPath(leftLegPath, paint);

    // Draw right leg: M19 18v2
    final rightLegPath = Path();
    rightLegPath.moveTo(19 * scale, 18 * scale);
    rightLegPath.lineTo(19 * scale, 20 * scale);
    canvas.drawPath(rightLegPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ArmchairPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
