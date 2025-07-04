import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Aperture Icon - Lines drawing from circle border inward
class ApertureIcon extends AnimatedSVGIcon {
  const ApertureIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription => "Aperture lines drawing inward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AperturePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Aperture icon
class AperturePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AperturePainter({
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
    final centerX = 12 * scale;
    final centerY = 12 * scale;
    final radius = 10 * scale;

    // Always draw the outer circle
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Define the 6 aperture blades paths from the original SVG
    final bladePaths = [
      // m14.31 8 5.74 9.94
      {
        'start': [14.31 * scale, 8 * scale],
        'end': [20.05 * scale, 17.94 * scale],
      },
      // M9.69 8h11.48
      {
        'start': [9.69 * scale, 8 * scale],
        'end': [21.17 * scale, 8 * scale],
      },
      // m7.38 12 5.74-9.94
      {
        'start': [7.38 * scale, 12 * scale],
        'end': [13.12 * scale, 2.06 * scale],
      },
      // M9.69 16 3.95 6.06
      {
        'start': [9.69 * scale, 16 * scale],
        'end': [3.95 * scale, 6.06 * scale],
      },
      // M14.31 16H2.83
      {
        'start': [14.31 * scale, 16 * scale],
        'end': [2.83 * scale, 16 * scale],
      },
      // m16.62 12-5.74 9.94
      {
        'start': [16.62 * scale, 12 * scale],
        'end': [10.88 * scale, 21.94 * scale],
      },
    ];

    if (animationValue == 0.0) {
      // Show all lines when not animating
      for (int i = 0; i < bladePaths.length; i++) {
        final startX = bladePaths[i]['start']![0];
        final startY = bladePaths[i]['start']![1];
        final endX = bladePaths[i]['end']![0];
        final endY = bladePaths[i]['end']![1];

        canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      }
    } else if (animationValue > 0.0) {
      // Two-phase animation: disappear then redraw
      if (animationValue <= 0.3) {
        // Phase 1: Lines disappearing (0.0 to 0.3)
        final disappearProgress = animationValue / 0.3;

        for (int i = 0; i < bladePaths.length; i++) {
          final bladeDelay = i * 0.05; // Quick staggered disappearance
          final bladeDisappearValue = math.max(
            0.0,
            math.min(
              1.0,
              (disappearProgress - bladeDelay) / (1.0 - bladeDelay),
            ),
          );

          if (bladeDisappearValue < 1.0) {
            final startX = bladePaths[i]['start']![0];
            final startY = bladePaths[i]['start']![1];
            final endX = bladePaths[i]['end']![0];
            final endY = bladePaths[i]['end']![1];

            // Draw line getting shorter from the end
            final currentEndX = endX - (endX - startX) * bladeDisappearValue;
            final currentEndY = endY - (endY - startY) * bladeDisappearValue;

            canvas.drawLine(
              Offset(startX, startY),
              Offset(currentEndX, currentEndY),
              paint,
            );
          }
        }
      } else {
        // Phase 2: Lines redrawing (0.3 to 1.0)
        final redrawProgress = (animationValue - 0.3) / 0.7;

        for (int i = 0; i < bladePaths.length; i++) {
          final bladeDelay = i * 0.15; // Staggered redrawing
          final bladeRedrawValue = math.max(
            0.0,
            (redrawProgress - bladeDelay) / (1.0 - bladeDelay),
          );

          if (bladeRedrawValue > 0.0) {
            final startX = bladePaths[i]['start']![0];
            final startY = bladePaths[i]['start']![1];
            final endX = bladePaths[i]['end']![0];
            final endY = bladePaths[i]['end']![1];

            // Draw line growing from start to end
            final currentEndX = startX + (endX - startX) * bladeRedrawValue;
            final currentEndY = startY + (endY - startY) * bladeRedrawValue;

            canvas.drawLine(
              Offset(startX, startY),
              Offset(currentEndX, currentEndY),
              paint,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(AperturePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
