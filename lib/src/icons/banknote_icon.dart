import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Banknote Icon - Starts fully visible, then disappears and redraws with animation
class BanknoteIcon extends AnimatedSVGIcon {
  const BanknoteIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      "Banknote starts visible, disappears, then redraws rectangle, circle, and lines in sequence";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BanknotePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Banknote icon
class BanknotePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BanknotePainter({
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

    // Animation phases:
    // animationValue = 0: Fully visible (static state)
    // 0.0-0.1: Fade out/disappear
    // 0.1-0.4: Draw rectangle
    // 0.4-0.6: Draw circle
    // 0.6-1.0: Draw lines

    if (animationValue == 0.0) {
      // Static state - draw complete banknote
      _drawCompleteBanknote(canvas, scale, paint);
    } else if (animationValue > 0.0 && animationValue <= 0.1) {
      // Fade out phase - gradually disappear
      final fadeProgress = animationValue / 0.1;
      final fadePaint = Paint()
        ..color = color.withValues(alpha: 1.0 - fadeProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      _drawCompleteBanknote(canvas, scale, fadePaint);
    } else {
      // Redraw phases (0.1-1.0)
      final redrawValue = (animationValue - 0.1) / 0.9;

      // Phase 1: Rectangle (0.0-0.33 of redraw)
      if (redrawValue >= 0.0) {
        final rectProgress = (redrawValue / 0.33).clamp(0.0, 1.0);
        _drawRectangleAnimated(canvas, scale, paint, rectProgress);
      }

      // Phase 2: Circle (0.33-0.55 of redraw)
      if (redrawValue >= 0.33) {
        if (redrawValue >= 0.55) {
          // Circle animation completed, draw full circle
          canvas.drawCircle(Offset(12 * scale, 12 * scale), 2 * scale, paint);
        } else {
          // Circle animation in progress
          final circleProgress = ((redrawValue - 0.33) / 0.22).clamp(0.0, 1.0);
          _drawCircleAnimated(canvas, scale, paint, circleProgress);
        }
      }

      // Phase 3: Lines (0.55-1.0 of redraw)
      if (redrawValue >= 0.55) {
        if (redrawValue >= 0.9) {
          // Lines animation completed, draw full lines
          canvas.drawLine(
            Offset(6 * scale, 12 * scale),
            Offset(6.01 * scale, 12 * scale),
            paint,
          );
          canvas.drawLine(
            Offset(18 * scale, 12 * scale),
            Offset(18.01 * scale, 12 * scale),
            paint,
          );
        } else {
          // Lines animation in progress
          final linesProgress = ((redrawValue - 0.55) / 0.35).clamp(0.0, 1.0);
          _drawLinesAnimated(canvas, scale, paint, linesProgress);
        }
      }
    }
  }

  void _drawCompleteBanknote(Canvas canvas, double scale, Paint paint) {
    // Rectangle with rounded corners (from SVG: <rect width="20" height="12" x="2" y="6" rx="2"/>)
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 20 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Circle
    canvas.drawCircle(Offset(12 * scale, 12 * scale), 2 * scale, paint);

    // Lines (M6 12h.01M18 12h.01)
    canvas.drawLine(
      Offset(6 * scale, 12 * scale),
      Offset(6.01 * scale, 12 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(18 * scale, 12 * scale),
      Offset(18.01 * scale, 12 * scale),
      paint,
    );
  }

  void _drawRectangleAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    // Animate rectangle drawing by scaling from center
    final center = Offset(12 * scale, 12 * scale);
    final width = 20 * scale;
    final height = 12 * scale;
    final radius = 2 * scale;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(progress);

    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: width,
        height: height,
      ),
      Radius.circular(radius),
    );
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  void _drawCircleAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final center = Offset(12 * scale, 12 * scale);
    final radius = 2 * scale;
    final sweep = 2 * 3.141592653589793 * progress;
    final path = Path();
    path.addArc(Rect.fromCircle(center: center, radius: radius), -1.57, sweep);
    canvas.drawPath(path, paint);
  }

  void _drawLinesAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    // Animate lines with staggered appearance
    if (progress < 0.5) {
      // First line
      final line1Progress = progress / 0.5;
      final x = 6 * scale + (6.01 - 6) * scale * line1Progress;
      canvas.drawLine(
        Offset(6 * scale, 12 * scale),
        Offset(x, 12 * scale),
        paint,
      );
    } else {
      // First line complete, animate second line
      canvas.drawLine(
        Offset(6 * scale, 12 * scale),
        Offset(6.01 * scale, 12 * scale),
        paint,
      );
      final line2Progress = (progress - 0.5) / 0.5;
      final x = 18 * scale + (18.01 - 18) * scale * line2Progress;
      canvas.drawLine(
        Offset(18 * scale, 12 * scale),
        Offset(x, 12 * scale),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BanknotePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
