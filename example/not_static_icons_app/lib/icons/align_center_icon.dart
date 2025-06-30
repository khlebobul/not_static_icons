import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignCenterIcon extends AnimatedSVGIcon {
  const AlignCenterIcon({super.key, required super.size});

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlignCenterPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription =>
      'Middle line shakes horizontally while other lines remain static';
}

class AlignCenterPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlignCenterPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24;

    // Calculate horizontal shake offset for middle line only
    final maxShakeOffset = size.width * 0.03; // Small shake movement
    final shakeOffset =
        sin(animationValue * 8 * pi) * maxShakeOffset; // Fast shake

    // Top line: static and longest (M21 6H3)
    canvas.drawLine(
      Offset(3 * scale, 6 * scale),
      Offset(21 * scale, 6 * scale),
      paint,
    );

    // Middle line: shaking and shortest (M17 12H7)
    canvas.drawLine(
      Offset((7 * scale) + shakeOffset, 12 * scale),
      Offset((17 * scale) + shakeOffset, 12 * scale),
      paint,
    );

    // Bottom line: static and medium length (M19 18H5)
    canvas.drawLine(
      Offset(5 * scale, 18 * scale),
      Offset(19 * scale, 18 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
