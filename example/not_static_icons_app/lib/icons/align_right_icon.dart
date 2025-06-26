import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignRightIcon extends AnimatedSVGIcon {
  const AlignRightIcon({super.key, required super.size});

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AlignRightPainter(color: color, animationValue: animationValue);
  }

  @override
  String get animationDescription =>
      'Lines move right from center in sinusoidal motion';
}

class AlignRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AlignRightPainter({required this.color, required this.animationValue});

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

    // Calculate horizontal offset based on animation (move right from center)
    final maxOffset = size.width * 0.1; // Maximum right movement
    final offset = sin(animationValue * 2 * pi) * maxOffset;

    // Top line: full width (M21 6H3)
    canvas.drawLine(
      Offset((3 * scale) + offset, 6 * scale),
      Offset((21 * scale) + offset, 6 * scale),
      paint,
    );

    // Middle line: shorter right aligned (M21 12H9)
    canvas.drawLine(
      Offset((9 * scale) + offset, 12 * scale),
      Offset((21 * scale) + offset, 12 * scale),
      paint,
    );

    // Bottom line: medium right aligned (M21 18H7)
    canvas.drawLine(
      Offset((7 * scale) + offset, 18 * scale),
      Offset((21 * scale) + offset, 18 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
