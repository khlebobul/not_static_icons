import 'dart:math';
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AlignLeftIcon extends AnimatedSVGIcon {
  const AlignLeftIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlignLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  @override
  String get animationDescription =>
      'Lines move left from center in sinusoidal motion';
}

class AlignLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlignLeftPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24;

    // Calculate horizontal offset based on animation (move left from center)
    final maxOffset = size.width * 0.1; // Maximum left movement
    final offset = sin(animationValue * 2 * pi) * maxOffset;

    // Top line: full width (M21 6H3)
    canvas.drawLine(
      Offset((3 * scale) + offset, 6 * scale),
      Offset((21 * scale) + offset, 6 * scale),
      paint,
    );

    // Middle line: shorter (M15 12H3)
    canvas.drawLine(
      Offset((3 * scale) + offset, 12 * scale),
      Offset((15 * scale) + offset, 12 * scale),
      paint,
    );

    // Bottom line: medium (M17 18H3)
    canvas.drawLine(
      Offset((3 * scale) + offset, 18 * scale),
      Offset((17 * scale) + offset, 18 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
