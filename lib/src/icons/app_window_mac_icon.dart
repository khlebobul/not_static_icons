import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated App Window Mac Icon - Window frame with sequential control buttons
class AppWindowMacIcon extends AnimatedSVGIcon {
  const AppWindowMacIcon({
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
      "Window frame with sequential control buttons";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AppWindowMacPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for App Window Mac icon
class AppWindowMacPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AppWindowMacPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    // Always draw the window frame (rounded rectangle)
    // rect width="20" height="16" x="2" y="4" rx="2"
    final rect = RRect.fromLTRBR(
      2 * scale,
      4 * scale,
      22 * scale,
      20 * scale,
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Three control buttons positions
    final buttonPositions = [
      {'x': 6 * scale, 'y': 8 * scale}, // First button (close)
      {'x': 10 * scale, 'y': 8 * scale}, // Second button (minimize)
      {'x': 14 * scale, 'y': 8 * scale}, // Third button (maximize)
    ];

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotRadius = 0.5 * scale;

    if (animationValue == 0.0) {
      // Show all dots when not animating
      for (int i = 0; i < buttonPositions.length; i++) {
        final x = buttonPositions[i]['x']!;
        final y = buttonPositions[i]['y']!;

        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
      }
    } else if (animationValue > 0.0) {
      // Two-phase animation: disappear then redraw
      if (animationValue <= 0.3) {
        // Phase 1: Dots disappearing (0.0 to 0.3)
        final disappearProgress = animationValue / 0.3;

        for (int i = 0; i < buttonPositions.length; i++) {
          final dotDelay = i * 0.1; // Quick staggered disappearance
          final dotDisappearValue = math.max(
            0.0,
            math.min(1.0, (disappearProgress - dotDelay) / (1.0 - dotDelay)),
          );

          if (dotDisappearValue < 1.0) {
            final x = buttonPositions[i]['x']!;
            final y = buttonPositions[i]['y']!;

            // Dot shrinking from full size to 0
            final currentRadius = dotRadius * (1.0 - dotDisappearValue);

            canvas.drawCircle(Offset(x, y), currentRadius, dotPaint);
          }
        }
      } else {
        // Phase 2: Dots redrawing (0.3 to 1.0)
        final redrawProgress = (animationValue - 0.3) / 0.7;

        for (int i = 0; i < buttonPositions.length; i++) {
          final dotDelay = i * 0.25; // Staggered redrawing
          final dotRedrawValue = math.max(
            0.0,
            (redrawProgress - dotDelay) / (1.0 - dotDelay),
          );

          if (dotRedrawValue > 0.0) {
            final x = buttonPositions[i]['x']!;
            final y = buttonPositions[i]['y']!;

            // Dot growing from 0 to full size
            final currentRadius = dotRadius * dotRedrawValue;

            canvas.drawCircle(Offset(x, y), currentRadius, dotPaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(AppWindowMacPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
