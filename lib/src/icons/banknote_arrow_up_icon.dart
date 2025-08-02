import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Banknote Arrow Up Icon - Starts fully visible, then disappears and redraws with animation
class BanknoteArrowUpIcon extends AnimatedSVGIcon {
  const BanknoteArrowUpIcon({
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
      "Banknote with arrow up: starts visible, disappears, then redraws banknote and arrow in sequence";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BanknoteArrowUpPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Banknote Arrow Up icon
class BanknoteArrowUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BanknoteArrowUpPainter({
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
    // 0.8-0.9: Draw arrow shaft
    // 0.9-1.0: Draw arrowhead

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

      // Phase 4: Arrow shaft (0.77-0.88 of redraw)
      if (redrawValue >= 0.77) {
        if (redrawValue >= 0.88) {
          // Arrow shaft animation completed, draw full shaft
          canvas.drawLine(Offset(19 * scale, 22 * scale),
              Offset(19 * scale, 16 * scale), paint);
        } else {
          // Arrow shaft animation in progress
          final shaftProgress = ((redrawValue - 0.77) / 0.11).clamp(0.0, 1.0);
          _drawArrowShaftAnimated(canvas, scale, paint, shaftProgress);
        }
      }

      // Phase 5: Arrowhead (0.88-1.0 of redraw)
      if (redrawValue >= 0.88) {
        if (redrawValue >= 0.9) {
          // Arrowhead animation completed, draw full arrowhead
          canvas.drawLine(Offset(22 * scale, 19 * scale),
              Offset(19 * scale, 16 * scale), paint);
          canvas.drawLine(Offset(19 * scale, 16 * scale),
              Offset(16 * scale, 19 * scale), paint);
        } else {
          // Arrowhead animation in progress
          final headProgress = ((redrawValue - 0.88) / 0.02).clamp(0.0, 1.0);
          _drawArrowHeadAnimated(canvas, scale, paint, headProgress);
        }
      }
    }
  }

  void _drawCompleteIcon(Canvas canvas, double scale, Paint paint) {
    // Banknote outline - partial rectangle (from SVG path: M12 18H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5)
    final path = Path();
    path.moveTo(12 * scale, 18 * scale);
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

    // Arrow shaft (M19 22v-6)
    canvas.drawLine(
        Offset(19 * scale, 22 * scale), Offset(19 * scale, 16 * scale), paint);

    // Arrowhead (m22 19-3-3-3 3)
    canvas.drawLine(
        Offset(22 * scale, 19 * scale), Offset(19 * scale, 16 * scale), paint);
    canvas.drawLine(
        Offset(19 * scale, 16 * scale), Offset(16 * scale, 19 * scale), paint);
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
    path.moveTo(12 * scale, 18 * scale);
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

  void _drawArrowShaftAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final start = Offset(19 * scale, 22 * scale);
    final end = Offset(19 * scale, 16 * scale);
    final y = start.dy - (start.dy - end.dy) * progress;
    canvas.drawLine(start, Offset(start.dx, y), paint);
  }

  void _drawArrowHeadAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final left = Offset(16 * scale, 19 * scale);
    final tip = Offset(19 * scale, 16 * scale);
    final right = Offset(22 * scale, 19 * scale);

    if (progress < 0.5) {
      // Animate left side of arrowhead
      final leftProgress = progress / 0.5;
      final p = Offset.lerp(tip, left, 1 - leftProgress)!;
      canvas.drawLine(p, tip, paint);
    } else {
      // Left side complete, animate right side
      canvas.drawLine(left, tip, paint);
      final rightProgress = (progress - 0.5) / 0.5;
      final p = Offset.lerp(tip, right, rightProgress)!;
      canvas.drawLine(tip, p, paint);
    }
  }

  @override
  bool shouldRepaint(BanknoteArrowUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
