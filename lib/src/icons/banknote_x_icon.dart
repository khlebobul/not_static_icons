import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Banknote X Icon - Starts fully visible, then disappears and redraws with animation
class BanknoteXIcon extends AnimatedSVGIcon {
  const BanknoteXIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription =>
      "Banknote with X: starts visible, disappears, then redraws banknote and X in sequence";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BanknoteXPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Banknote X icon
class BanknoteXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BanknoteXPainter({
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
    // 0.1-0.4: Draw banknote outline
    // 0.4-0.6: Draw circle
    // 0.6-0.8: Draw lines
    // 0.8-0.9: Draw first X line
    // 0.9-1.0: Draw second X line

    if (animationValue == 0.0) {
      // Static state - draw complete icon
      _drawCompleteIcon(canvas, scale, paint);
    } else if (animationValue > 0.0 && animationValue <= 0.1) {
      // Fade out phase - gradually disappear
      final fadeProgress = animationValue / 0.1;
      final fadePaint = Paint()
        ..color = color.withValues(alpha: 1.0 - fadeProgress)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      _drawCompleteIcon(canvas, scale, fadePaint);
    } else {
      // Redraw phases (0.1-1.0)
      final redrawValue = (animationValue - 0.1) / 0.9;

      // Phase 1: Banknote outline (0.0-0.33 of redraw)
      if (redrawValue >= 0.0) {
        final outlineProgress = (redrawValue / 0.33).clamp(0.0, 1.0);
        _drawBanknoteOutlineAnimated(canvas, scale, paint, outlineProgress);
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

      // Phase 3: Lines (0.55-0.77 of redraw)
      if (redrawValue >= 0.55) {
        if (redrawValue >= 0.77) {
          // Lines animation completed, draw full lines
          canvas.drawLine(Offset(6 * scale, 12 * scale),
              Offset(6.01 * scale, 12 * scale), paint);
          canvas.drawLine(Offset(18 * scale, 12 * scale),
              Offset(18.01 * scale, 12 * scale), paint);
        } else {
          // Lines animation in progress
          final linesProgress = ((redrawValue - 0.55) / 0.22).clamp(0.0, 1.0);
          _drawLinesAnimated(canvas, scale, paint, linesProgress);
        }
      }

      // Phase 4: First X line (0.77-0.88 of redraw)
      if (redrawValue >= 0.77) {
        if (redrawValue >= 0.88) {
          // First X line animation completed, draw full first line
          canvas.drawLine(Offset(17 * scale, 17 * scale),
              Offset(22 * scale, 22 * scale), paint);
        } else {
          // First X line animation in progress
          final x1Progress = ((redrawValue - 0.77) / 0.11).clamp(0.0, 1.0);
          _drawXLine1Animated(canvas, scale, paint, x1Progress);
        }
      }

      // Phase 5: Second X line (0.88-1.0 of redraw)
      if (redrawValue >= 0.88) {
        if (redrawValue >= 0.9) {
          // Second X line animation completed, draw full second line
          canvas.drawLine(Offset(22 * scale, 17 * scale),
              Offset(17 * scale, 22 * scale), paint);
        } else {
          // Second X line animation in progress
          final x2Progress = ((redrawValue - 0.88) / 0.02).clamp(0.0, 1.0);
          _drawXLine2Animated(canvas, scale, paint, x2Progress);
        }
      }
    }
  }

  void _drawCompleteIcon(Canvas canvas, double scale, Paint paint) {
    // Banknote outline - partial rectangle (from SVG path: M13 18H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5)
    final path = Path();
    path.moveTo(13 * scale, 18 * scale);
    path.lineTo(4 * scale, 18 * scale);
    path.arcToPoint(Offset(2 * scale, 16 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(2 * scale, 8 * scale);
    path.arcToPoint(Offset(4 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(20 * scale, 6 * scale);
    path.arcToPoint(Offset(22 * scale, 8 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(22 * scale, 13 * scale);
    canvas.drawPath(path, paint);

    // Circle
    canvas.drawCircle(Offset(12 * scale, 12 * scale), 2 * scale, paint);

    // Short lines (M6 12h.01 and M18 12h.01)
    canvas.drawLine(
        Offset(6 * scale, 12 * scale), Offset(6.01 * scale, 12 * scale), paint);
    canvas.drawLine(Offset(18 * scale, 12 * scale),
        Offset(18.01 * scale, 12 * scale), paint);

    // X lines (m17 17 5 5 and m22 17-5 5)
    canvas.drawLine(
        Offset(17 * scale, 17 * scale), Offset(22 * scale, 22 * scale), paint);
    canvas.drawLine(
        Offset(22 * scale, 17 * scale), Offset(17 * scale, 22 * scale), paint);
  }

  void _drawBanknoteOutlineAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    // Animate banknote outline by scaling from center
    final center = Offset(12 * scale, 12 * scale);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(progress);
    canvas.translate(-center.dx, -center.dy);

    final path = Path();
    path.moveTo(13 * scale, 18 * scale);
    path.lineTo(4 * scale, 18 * scale);
    path.arcToPoint(Offset(2 * scale, 16 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(2 * scale, 8 * scale);
    path.arcToPoint(Offset(4 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(20 * scale, 6 * scale);
    path.arcToPoint(Offset(22 * scale, 8 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path.lineTo(22 * scale, 13 * scale);
    canvas.drawPath(path, paint);
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
          Offset(6 * scale, 12 * scale), Offset(x, 12 * scale), paint);
    } else {
      // First line complete, animate second line
      canvas.drawLine(Offset(6 * scale, 12 * scale),
          Offset(6.01 * scale, 12 * scale), paint);
      final line2Progress = (progress - 0.5) / 0.5;
      final x = 18 * scale + (18.01 - 18) * scale * line2Progress;
      canvas.drawLine(
          Offset(18 * scale, 12 * scale), Offset(x, 12 * scale), paint);
    }
  }

  void _drawXLine1Animated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final start = Offset(17 * scale, 17 * scale);
    final end = Offset(22 * scale, 22 * scale);
    final x = start.dx + (end.dx - start.dx) * progress;
    final y = start.dy + (end.dy - start.dy) * progress;
    canvas.drawLine(start, Offset(x, y), paint);
  }

  void _drawXLine2Animated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final start = Offset(22 * scale, 17 * scale);
    final end = Offset(17 * scale, 22 * scale);
    final x = start.dx - (start.dx - end.dx) * progress;
    final y = start.dy + (end.dy - start.dy) * progress;
    canvas.drawLine(start, Offset(x, y), paint);
  }

  @override
  bool shouldRepaint(BanknoteXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
