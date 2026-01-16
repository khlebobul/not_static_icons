import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bandage Icon - Starts fully visible, then disappears and redraws with animation
class BandageIcon extends AnimatedSVGIcon {
  const BandageIcon({
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
      "Bandage starts visible, disappears, then redraws with rotation and scaling";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BandagePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Bandage icon
class BandagePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BandagePainter({
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
    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);

    // Animation phases:
    // animationValue = 0: Fully visible (static state)
    // 0.0-0.1: Fade out/disappear
    // 0.1-0.4: Scale and rotate the main rectangle (redraw)
    // 0.4-0.7: Draw side strips
    // 0.7-1.0: Draw dots (adhesive points)

    if (animationValue == 0.0) {
      // Static state - draw complete bandage
      _drawCompleteBandage(canvas, scale, paint);
    } else if (animationValue > 0.0 && animationValue <= 0.1) {
      // Fade out phase - gradually disappear
      final fadeProgress = animationValue / 0.1;
      final fadePaint = Paint()
        ..color = color.withValues(alpha: 1.0 - fadeProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      _drawCompleteBandage(canvas, scale, fadePaint);
    } else {
      // Redraw phases (0.1-1.0)
      final redrawValue = (animationValue - 0.1) / 0.9;

      // Phase 1: Main rectangle with scaling and rotation (0.0-0.33 of redraw)
      if (redrawValue >= 0.0) {
        final rectProgress = (redrawValue / 0.33).clamp(0.0, 1.0);
        final scaleValue = rectProgress;
        final rotationValue =
            (1 - rectProgress) * 0.3; // Start rotated, then straighten

        canvas.save();
        canvas.scale(scaleValue);
        canvas.rotate(rotationValue);

        // Main rectangle
        final rect = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: 20 * scale,
            height: 12 * scale,
          ),
          Radius.circular(2 * scale),
        );
        canvas.drawRRect(rect, paint);
        canvas.restore();
      }

      // Phase 2: Side strips (0.33-0.66 of redraw)
      if (redrawValue >= 0.33) {
        final stripProgress = ((redrawValue - 0.33) / 0.33).clamp(0.0, 1.0);

        // Left strip
        final leftStripPath = Path()
          ..moveTo(-6 * scale, -6 * scale)
          ..lineTo(-6 * scale, 6 * scale);

        // Right strip
        final rightStripPath = Path()
          ..moveTo(6 * scale, -5.5 * scale)
          ..lineTo(6 * scale, 5.5 * scale);

        // Draw strips with progress
        for (final metric in leftStripPath.computeMetrics()) {
          final extract = metric.extractPath(0, metric.length * stripProgress);
          canvas.drawPath(extract, paint);
        }

        for (final metric in rightStripPath.computeMetrics()) {
          final extract = metric.extractPath(0, metric.length * stripProgress);
          canvas.drawPath(extract, paint);
        }
      }

      // Phase 3: Dots (adhesive points) (0.66-1.0 of redraw)
      if (redrawValue >= 0.66) {
        final dotProgress = ((redrawValue - 0.66) / 0.34).clamp(0.0, 1.0);

        // Define dot positions
        final dotPositions = [
          Offset(-2 * scale, -2 * scale),
          Offset(-2 * scale, 2 * scale),
          Offset(2 * scale, -2 * scale),
          Offset(2 * scale, 2 * scale),
        ];

        // Draw dots with staggered appearance
        for (int i = 0; i < dotPositions.length; i++) {
          final dotDelay = i * 0.25;
          final individualProgress =
              ((dotProgress - dotDelay) / 0.25).clamp(0.0, 1.0);

          if (individualProgress > 0) {
            final dotScale = individualProgress;
            canvas.save();
            canvas.translate(dotPositions[i].dx, dotPositions[i].dy);
            canvas.scale(dotScale);

            // Draw small dot
            final dotPath = Path()
              ..moveTo(-0.01 * scale, 0)
              ..lineTo(0.01 * scale, 0);
            canvas.drawPath(dotPath, paint);

            canvas.restore();
          }
        }
      }
    }

    canvas.restore();
  }

  void _drawCompleteBandage(Canvas canvas, double scale, Paint paint) {
    // Draw complete bandage (main rectangle + strips + dots)

    // Main rectangle
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: 20 * scale,
        height: 12 * scale,
      ),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Left strip
    canvas.drawLine(
      Offset(-6 * scale, -6 * scale),
      Offset(-6 * scale, 6 * scale),
      paint,
    );

    // Right strip
    canvas.drawLine(
      Offset(6 * scale, -5.5 * scale),
      Offset(6 * scale, 5.5 * scale),
      paint,
    );

    // Dots
    final dotPositions = [
      Offset(-2 * scale, -2 * scale),
      Offset(-2 * scale, 2 * scale),
      Offset(2 * scale, -2 * scale),
      Offset(2 * scale, 2 * scale),
    ];

    for (final position in dotPositions) {
      final dotPath = Path()
        ..moveTo(position.dx - 0.01 * scale, position.dy)
        ..lineTo(position.dx + 0.01 * scale, position.dy);
      canvas.drawPath(dotPath, paint);
    }
  }

  @override
  bool shouldRepaint(BandagePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
