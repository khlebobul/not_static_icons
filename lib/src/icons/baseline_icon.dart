import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Baseline Icon - original 'A' with baseline; underline animates, then returns to original
class BaselineIcon extends AnimatedSVGIcon {
  const BaselineIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 400),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      'Baseline: underline draws from left to right and returns to original';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BaselinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BaselinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BaselinePainter({
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

    // Always draw the 'A' (two slanted legs and crossbar) exactly like SVG
    // Legs: path d="m6 16 6-12 6 12"
    canvas.drawLine(
      Offset(6 * scale, 16 * scale),
      Offset(12 * scale, 4 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(12 * scale, 4 * scale),
      Offset(18 * scale, 16 * scale),
      paint,
    );

    // Crossbar: path d="M8 12h8"
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );

    // Underline baseline: path d="M4 20h16"
    if (animationValue == 0.0) {
      // Static original
      canvas.drawLine(
        Offset(4 * scale, 20 * scale),
        Offset(20 * scale, 20 * scale),
        paint,
      );
    } else {
      // Animate underline from left to right
      final progress = animationValue.clamp(0.0, 1.0);
      final endX = 4 * scale + 16 * scale * progress;
      canvas.drawLine(
        Offset(4 * scale, 20 * scale),
        Offset(endX, 20 * scale),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BaselinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
