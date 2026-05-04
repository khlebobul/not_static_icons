import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated CPU Icon - inner core rect pulses outward on hover/tap
class CpuIcon extends AnimatedSVGIcon {
  const CpuIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
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
  String get animationDescription => 'Inner core pulses outward';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CpuPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CpuPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CpuPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    void drawPins() {
      // Bottom pins
      canvas.drawLine(Offset(12 * s, 20 * s), Offset(12 * s, 22 * s), paint);
      canvas.drawLine(Offset(17 * s, 20 * s), Offset(17 * s, 22 * s), paint);
      canvas.drawLine(Offset(7 * s, 20 * s), Offset(7 * s, 22 * s), paint);
      // Top pins
      canvas.drawLine(Offset(12 * s, 2 * s), Offset(12 * s, 4 * s), paint);
      canvas.drawLine(Offset(17 * s, 2 * s), Offset(17 * s, 4 * s), paint);
      canvas.drawLine(Offset(7 * s, 2 * s), Offset(7 * s, 4 * s), paint);
      // Left pins
      canvas.drawLine(Offset(2 * s, 12 * s), Offset(4 * s, 12 * s), paint);
      canvas.drawLine(Offset(2 * s, 17 * s), Offset(4 * s, 17 * s), paint);
      canvas.drawLine(Offset(2 * s, 7 * s), Offset(4 * s, 7 * s), paint);
      // Right pins
      canvas.drawLine(Offset(20 * s, 12 * s), Offset(22 * s, 12 * s), paint);
      canvas.drawLine(Offset(20 * s, 17 * s), Offset(22 * s, 17 * s), paint);
      canvas.drawLine(Offset(20 * s, 7 * s), Offset(22 * s, 7 * s), paint);
    }

    void drawOuterRect() {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(4 * s, 4 * s, 16 * s, 16 * s),
          Radius.circular(2 * s),
        ),
        paint,
      );
    }

    void drawInnerRect() {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(8 * s, 8 * s, 8 * s, 8 * s),
          Radius.circular(1 * s),
        ),
        paint,
      );
    }

    drawPins();
    drawOuterRect();

    if (t == 0.0) {
      drawInnerRect();
    } else {
      // Pulse inner rect from center (12, 12)
      final double scale = 1.0 + 0.35 * math.sin(math.pi * t);
      canvas.save();
      canvas.translate(12 * s, 12 * s);
      canvas.scale(scale, scale);
      canvas.translate(-12 * s, -12 * s);
      drawInnerRect();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CpuPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
