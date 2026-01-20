import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Battery Icon - starts visible, fades out, then redraws the case and terminal
class BatteryIcon extends AnimatedSVGIcon {
  const BatteryIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
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
      'Battery: fades then redraws case and terminal with a brief interior sweep';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BatteryPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BatteryPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BatteryPainter({
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

    // Phases: static → fade-out → case → terminal

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

    // No additional lines beyond original icon strokes
  }

  void _drawComplete(Canvas canvas, double scale, Paint paint) {
    // Exact to SVG: a single rounded rectangle frame (no cutouts) and the terminal
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 6 * scale, 16 * scale, 12 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    canvas.drawLine(
      Offset(22 * scale, 14 * scale),
      Offset(22 * scale, 10 * scale),
      paint,
    );
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

  @override
  bool shouldRepaint(_BatteryPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
