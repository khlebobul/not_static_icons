import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignJustifyIcon extends AnimatedSVGIcon {
  const AlignJustifyIcon({super.key, required double size}) : super(size: size);

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlignJustifyPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription =>
      'Middle line shakes horizontally while other lines remain static';
}

class AlignJustifyPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlignJustifyPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth =
          size.width *
          0.083 // 2/24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24;

    // Calculate horizontal shake offset for middle line only
    final maxShakeOffset = size.width * 0.03; // Small shake movement
    final shakeOffset =
        sin(animationValue * 8 * pi) * maxShakeOffset; // Fast shake

    // Top line: static (M3 6h18)
    canvas.drawLine(
      Offset(3 * scale, 6 * scale),
      Offset(21 * scale, 6 * scale),
      paint,
    );

    // Middle line: shaking (M3 12h18)
    canvas.drawLine(
      Offset((3 * scale) + shakeOffset, 12 * scale),
      Offset((21 * scale) + shakeOffset, 12 * scale),
      paint,
    );

    // Bottom line: static (M3 18h18)
    canvas.drawLine(
      Offset(3 * scale, 18 * scale),
      Offset(21 * scale, 18 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
