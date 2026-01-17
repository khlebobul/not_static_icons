import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math';

/// Animated Audio Waveform Icon - Waveform oscillates like audio signal
class AudioWaveformIcon extends AnimatedSVGIcon {
  const AudioWaveformIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
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
      "Audio waveform peaks randomly change their values, simulating a live audio signal with varying levels.";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AudioWaveformPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Audio Waveform icon
class AudioWaveformPainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  AudioWaveformPainter({
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

    // Draw the waveform path with wave effect animation
    _drawAnimatedWaveform(canvas, paint, scale, animationValue);
  }

  // Create random peak variations for each position
  double _createRandomPeakVariation(double t, double position) {
    // Use position as seed for consistent randomness per peak
    final seed = (position * 1000).round();

    // Create multiple sine waves with different frequencies for each peak
    final wave1 = sin(t * 4 * pi + seed * 0.1);
    final wave2 = sin(t * 6 * pi + seed * 0.2);
    final wave3 = sin(t * 8 * pi + seed * 0.3);

    // Combine waves for complex variation
    final combinedWave = (wave1 * 0.5 + wave2 * 0.3 + wave3 * 0.2);

    // Apply smooth envelope to fade in/out the effect
    final envelope = sin(t * pi);

    // Scale the variation (1.0 means original size, can go from 0.3 to 1.7)
    final variation = 1.0 + combinedWave * envelope * 0.7;

    return variation.clamp(0.3, 1.7); // Ensure it doesn't go too extreme
  }

  void _drawAnimatedWaveform(
      Canvas canvas, Paint paint, double scale, double animationValue) {
    final path = Path();

    // Convert the SVG path to Flutter path with wave effect
    // Original: M2 13a2 2 0 0 0 2-2V7a2 2 0 0 1 4 0v13a2 2 0 0 0 4 0V4a2 2 0 0 1 4 0v13a2 2 0 0 0 4 0v-4a2 2 0 0 1 2-2

    // Helper function to amplify peaks with random variations
    double amplifyPeak(double y, double xPosition) {
      const center = 12.0;
      final distance = y - center;
      final randomVariation =
          _createRandomPeakVariation(animationValue, xPosition);
      return center + distance * randomVariation;
    }

    // Start point: M2 13 (position 0.0)
    path.moveTo(2 * scale, amplifyPeak(13, 0.0) * scale);

    // First curve: a2 2 0 0 0 2-2 (to point 4,11)
    path.relativeArcToPoint(
      Offset(2 * scale, (amplifyPeak(11, 0.1) - amplifyPeak(13, 0.0)) * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Vertical line to V7 (position 0.2 - first peak)
    path.lineTo(4 * scale, amplifyPeak(7, 0.2) * scale);

    // Second curve: a2 2 0 0 1 4 0 (to point 8,7)
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Vertical line v13 (to point 8,20 - position 0.4, second peak)
    path.lineTo(8 * scale, amplifyPeak(20, 0.4) * scale);

    // Third curve: a2 2 0 0 0 4 0 (to point 12,20)
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Vertical line V4 (position 0.5 - center, highest peak)
    path.lineTo(12 * scale, amplifyPeak(4, 0.5) * scale);

    // Fourth curve: a2 2 0 0 1 4 0 (to point 16,4)
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Vertical line v13 (to point 16,17 - position 0.7, third peak)
    path.lineTo(16 * scale, amplifyPeak(17, 0.7) * scale);

    // Fifth curve: a2 2 0 0 0 4 0 (to point 20,17)
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    // Vertical line v-4 (to point 20,13 - position 0.9, small peak)
    path.lineTo(20 * scale, amplifyPeak(13, 0.9) * scale);

    // Final curve: a2 2 0 0 1 2-2 (to point 22,11)
    path.relativeArcToPoint(
      Offset(2 * scale, (amplifyPeak(11, 1.0) - amplifyPeak(13, 0.9)) * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(AudioWaveformPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
