import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Full Icon - bars fill sequentially after the case and terminal
class BatteryFullIcon extends AnimatedSVGIcon {
  const BatteryFullIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1100),
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
      'Battery full: case and terminal, then 3 bars fill left-to-right';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryFullPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryFullPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryFullPainter({
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

    // Phases
    // 0.0: static
    // 0.0-0.1: fade out
    // 0.1-0.45: case
    // 0.45-0.6: terminal
    // 0.6-0.75: bar1
    // 0.75-0.9: bar2
    // 0.9-1.0: bar3

    if (animationValue == 0.0) {
      _drawComplete(canvas, scale, paint);
      return;
    }

    if (animationValue > 0.0 && animationValue <= 0.1) {
      final p = animationValue / 0.1;
      final fadePaint = Paint()
        ..color = color.withValues(alpha: 1.0 - p)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      _drawComplete(canvas, scale, fadePaint);
      return;
    }

    final t = (animationValue - 0.1) / 0.9;

    // Case
    if (t >= 0.0) {
      final caseProgress = (t / 0.35).clamp(0.0, 1.0);
      _drawCaseAnimated(canvas, scale, paint, caseProgress);
    }

    // Terminal
    if (t >= 0.35) {
      final termProgress = ((t - 0.35) / 0.15).clamp(0.0, 1.0);
      _drawTerminalAnimated(canvas, scale, paint, termProgress);
    }

    // Bars
    if (t >= 0.5) {
      final p1 = ((t - 0.5) / 0.15).clamp(0.0, 1.0);
      _drawBar(canvas, scale, paint, x: 6, progress: p1);
    }
    if (t >= 0.65) {
      final p2 = ((t - 0.65) / 0.15).clamp(0.0, 1.0);
      _drawBar(canvas, scale, paint, x: 10, progress: p2);
    }
    if (t >= 0.8) {
      final p3 = ((t - 0.8) / 0.2).clamp(0.0, 1.0);
      _drawBar(canvas, scale, paint, x: 14, progress: p3);
    }
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    // Solid rounded rectangle frame (no cutouts), like SVG rect
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 16 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Terminal
    canvas.drawLine(
      Offset(22 * scale, 14 * scale),
      Offset(22 * scale, 10 * scale),
      paint,
    );
    // Bars
    canvas.drawLine(
        Offset(6 * scale, 10 * scale), Offset(6 * scale, 14 * scale), paint);
    canvas.drawLine(
        Offset(10 * scale, 10 * scale), Offset(10 * scale, 14 * scale), paint);
    canvas.drawLine(
        Offset(14 * scale, 10 * scale), Offset(14 * scale, 14 * scale), paint);
  }

  void _drawCaseAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final center = Offset(10 * scale, 12 * scale);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(progress);
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: 16 * scale,
        height: 12 * scale,
      ),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  void _drawTerminalAnimated(
      Canvas canvas, double scale, Paint paint, double progress) {
    final start = Offset(22 * scale, 14 * scale);
    final end = Offset(22 * scale, 10 * scale);
    final y = start.dy - (start.dy - end.dy) * progress;
    canvas.drawLine(start, Offset(start.dx, y), paint);
  }

  void _drawBar(Canvas canvas, double scale, Paint paint,
      {required double x, required double progress}) {
    final top = Offset(x * scale, 10 * scale);
    final bottom = Offset(x * scale, 14 * scale);
    final y = top.dy + (bottom.dy - top.dy) * progress;
    canvas.drawLine(top, Offset(top.dx, y), paint);
  }

  @override
  bool shouldRepaint(_BatteryFullPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
