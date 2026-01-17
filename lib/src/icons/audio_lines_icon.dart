import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Audio Lines Icon - Lines oscillate like music equalizer
class AudioLinesIcon extends AnimatedSVGIcon {
  const AudioLinesIcon({
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
  String get animationDescription =>
      "Audio lines oscillate like a music equalizer with wave-like motion.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AudioLinesPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Audio Lines icon
class AudioLinesPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  AudioLinesPainter({
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

    // Create wave-like oscillation for each line with different phases
    final wave1 = _createWave(animationValue, 0);
    final wave2 = _createWave(animationValue, pi / 3);
    final wave3 = _createWave(animationValue, 2 * pi / 3);
    final wave4 = _createWave(animationValue, pi);
    final wave5 = _createWave(animationValue, 4 * pi / 3);
    final wave6 = _createWave(animationValue, 5 * pi / 3);

    // Draw each line with wave oscillation
    // Line 1: x=2, original height: 3 units (from y=10 to y=13)
    _drawOscillatingLine(canvas, paint, scale, 2, 10, 13, wave1);

    // Line 2: x=6, original height: 11 units (from y=6 to y=17)
    _drawOscillatingLine(canvas, paint, scale, 6, 6, 17, wave2);

    // Line 3: x=10, original height: 18 units (from y=3 to y=21)
    _drawOscillatingLine(canvas, paint, scale, 10, 3, 21, wave3);

    // Line 4: x=14, original height: 7 units (from y=8 to y=15)
    _drawOscillatingLine(canvas, paint, scale, 14, 8, 15, wave4);

    // Line 5: x=18, original height: 13 units (from y=5 to y=18)
    _drawOscillatingLine(canvas, paint, scale, 18, 5, 18, wave5);

    // Line 6: x=22, original height: 3 units (from y=10 to y=13)
    _drawOscillatingLine(canvas, paint, scale, 22, 10, 13, wave6);
  }

  // Create a wave function with different phases for natural music wave effect
  double _createWave(double t, double phase) {
    // Create multiple overlapping sine waves for complex musical pattern
    final wave1 = sin(t * 4 * pi + phase) * 0.4;
    final wave2 = sin(t * 6 * pi + phase) * 0.3;
    final wave3 = sin(t * 8 * pi + phase) * 0.2;

    // Combine waves and apply smooth envelope
    final combinedWave = wave1 + wave2 + wave3;
    final envelope = sin(t * pi); // Smooth fade in/out

    return combinedWave * envelope;
  }

  // Draw a line that oscillates in height based on the wave value
  void _drawOscillatingLine(Canvas canvas, Paint paint, double scale, double x,
      double originalY1, double originalY2, double waveValue) {
    // Calculate the original center and height
    final centerY = (originalY1 + originalY2) / 2;
    final halfHeight = (originalY2 - originalY1) / 2;

    // Apply wave oscillation to the height (scale the height by wave)
    final oscillationFactor = 1.0 + waveValue * 0.6; // ±60% height variation
    final newHalfHeight = halfHeight * oscillationFactor;

    // Calculate new start and end points
    final newY1 = centerY - newHalfHeight;
    final newY2 = centerY + newHalfHeight;

    // Draw the oscillating line
    canvas.drawLine(
      Offset(x * scale, newY1 * scale),
      Offset(x * scale, newY2 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(AudioLinesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
