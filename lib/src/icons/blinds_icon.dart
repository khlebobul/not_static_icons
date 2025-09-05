import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Blinds Icon - cord pulling and slats animation
class BlindsIcon extends AnimatedSVGIcon {
  const BlindsIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Blinds: cord pulling and slats animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BlindsPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BlindsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BlindsPainter({
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

    // Draw animated blinds
    _drawAnimatedBlinds(canvas, paint, scale);
  }

  void _drawAnimatedBlinds(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Draw animated vertical cord
    _drawAnimatedCord(canvas, paint, scale, progress);

    // Draw top rail (always visible)
    canvas.drawLine(
      Offset(3 * scale, 3 * scale),
      Offset(21 * scale, 3 * scale),
      paint,
    );

    // Draw slats with sequential appearance/disappearance
    _drawAnimatedSlats(canvas, paint, scale, progress);
  }

  void _drawAnimatedCord(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Cord animation - entire cord pulls down and back up
    double cordPull = 0.0;
    if (progress < 0.2) {
      // Quick pull down
      cordPull = (progress / 0.2) * 2 * scale;
    } else if (progress < 0.3) {
      // Return to position
      cordPull = (1 - (progress - 0.2) / 0.1) * 2 * scale;
    }

    // Draw vertical cord with animation
    canvas.drawLine(
      Offset(4 * scale, 3 * scale),
      Offset(4 * scale, (17 + cordPull) * scale),
      paint,
    );

    // Draw cord handle (circle) with animation
    canvas.drawCircle(
      Offset(4 * scale, (19 + cordPull) * scale),
      2 * scale,
      paint,
    );
  }

  void _drawAnimatedSlats(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Define slat positions and their appearance timing
    final slats = [
      {'y': 7.0, 'start': 8.0, 'end': 20.0, 'timing': 0.3}, // M20 7H8
      {'y': 11.0, 'start': 8.0, 'end': 20.0, 'timing': 0.4}, // M20 11H8
      {'y': 15.0, 'start': 8.0, 'end': 20.0, 'timing': 0.5}, // M8 15h12
      {'y': 19.0, 'start': 10.0, 'end': 20.0, 'timing': 0.6}, // M10 19h10
    ];

    for (final slat in slats) {
      final slatTiming = slat['timing'] as double;
      final slatY = slat['y'] as double;
      final slatStart = slat['start'] as double;
      final slatEnd = slat['end'] as double;

      double slatAlpha = 1.0;
      double slatLength = 1.0;

      if (progress > slatTiming && progress < slatTiming + 0.15) {
        // Slat disappears
        final disappearProgress = (progress - slatTiming) / 0.15;
        slatAlpha = 1.0 - disappearProgress;
        slatLength = 1.0 - disappearProgress * 0.3; // Slight shrink effect
      } else if (progress >= slatTiming + 0.15 &&
          progress < slatTiming + 0.25) {
        // Slat is hidden
        slatAlpha = 0.0;
      } else if (progress >= slatTiming + 0.25 && progress < slatTiming + 0.4) {
        // Slat reappears
        final appearProgress = (progress - (slatTiming + 0.25)) / 0.15;
        slatAlpha = appearProgress;
        slatLength = 0.7 + appearProgress * 0.3; // Grow back to full size
      }

      if (slatAlpha > 0.0) {
        final slatPaint = Paint()
          ..color = color.withValues(alpha: slatAlpha)
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        // Calculate slat endpoints with length animation
        final fullLength = slatEnd - slatStart;
        final animatedLength = fullLength * slatLength;
        final centerX = (slatStart + slatEnd) / 2;
        final animatedStart = centerX - animatedLength / 2;
        final animatedEnd = centerX + animatedLength / 2;

        canvas.drawLine(
          Offset(animatedStart * scale, slatY * scale),
          Offset(animatedEnd * scale, slatY * scale),
          slatPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_BlindsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
