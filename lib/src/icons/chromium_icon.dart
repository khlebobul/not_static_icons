import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chromium Icon - Inner circle pulses
class ChromiumIcon extends AnimatedSVGIcon {
  const ChromiumIcon({
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
    super.interactive = true,
    super.controller,
  });

  @override
  String get animationDescription => "Inner circle pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChromiumPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChromiumPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChromiumPainter({
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

    // Animation - inner circle pulses
    final oscillation = 4 * animationValue * (1 - animationValue);
    final radiusChange = oscillation * 0.5;

    // Outer circle: cx="12" cy="12" r="10"
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      10 * scale,
      paint,
    );

    // Inner circle with pulse: cx="12" cy="12" r="4"
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      (4 + radiusChange) * scale,
      paint,
    );

    // Line 1: M10.88 21.94 15.46 14
    canvas.drawLine(
      Offset(10.88 * scale, 21.94 * scale),
      Offset(15.46 * scale, 14 * scale),
      paint,
    );

    // Line 2: M21.17 8H12
    canvas.drawLine(
      Offset(21.17 * scale, 8 * scale),
      Offset(12 * scale, 8 * scale),
      paint,
    );

    // Line 3: M3.95 6.06 8.54 14
    canvas.drawLine(
      Offset(3.95 * scale, 6.06 * scale),
      Offset(8.54 * scale, 14 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChromiumPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
