import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Antenna Icon - Swaying left and right searching for signal
class AntennaIcon extends AnimatedSVGIcon {
  const AntennaIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription => "Swaying antenna searching for signal";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AntennaPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Antenna icon
class AntennaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AntennaPainter({
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
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // Calculate sway angle (gentle left-right motion)
    final swayAngle = sin(animationValue * 2 * pi) * 0.15; // ±8.6 degrees max

    canvas.save();
    // Rotate around the base of the antenna (bottom center)
    canvas.translate(12 * scale, 22 * scale);
    canvas.rotate(swayAngle);
    canvas.translate(-12 * scale, -22 * scale);

    // Antenna elements (path d="M2 12 7 2")
    canvas.drawLine(p(2, 12), p(7, 2), paint);

    // Second element (path d="m7 12 5-10")
    canvas.drawLine(p(7, 12), p(12, 2), paint);

    // Third element (path d="m12 12 5-10")
    canvas.drawLine(p(12, 12), p(17, 2), paint);

    // Fourth element (path d="m17 12 5-10")
    canvas.drawLine(p(17, 12), p(22, 2), paint);

    // Horizontal connector (path d="M4.5 7h15")
    canvas.drawLine(p(4.5, 7), p(19.5, 7), paint);

    // Vertical base (path d="M12 16v6")
    canvas.drawLine(p(12, 16), p(12, 22), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AntennaPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
