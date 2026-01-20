import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bell Electric Icon - indicator arcs draw in; blink pulse
class BellElectricIcon extends AnimatedSVGIcon {
  const BellElectricIcon({
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
  String get animationDescription => 'Electric bell: arcs and elements reveal';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BellElectricPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BellElectricPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BellElectricPainter({
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

    final double scale = size.width / 24.0;

    // Base shapes at t=0 exactly match original; new animation adds jitter/flicker
    final double t = animationValue.clamp(0.0, 1.0);
    final double s2pi = 2.0 * math.pi * t;

    // big circle (static)
    final Offset bellCenter = Offset(9 * scale, 9 * scale);
    canvas.drawCircle(bellCenter, 7 * scale, paint);

    // small circle (20,16): jitter around base and mild pulse; at t=0 exact original
    final Offset headBase = Offset(20 * scale, 16 * scale);
    final Offset headCenter = t == 0.0
        ? headBase
        : headBase.translate(
            0.6 * scale * math.sin(8 * s2pi),
            0.6 * scale * math.sin(10 * s2pi + math.pi / 4),
          );
    final double headRadius =
        2 * scale * (t == 0.0 ? 1.0 : (1.0 + 0.1 * math.sin(4 * s2pi)));
    canvas.drawCircle(headCenter, headRadius, paint);

    // rect (static)
    final RRect base = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 16 * scale, 10 * scale, 6 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(base, paint);

    // arcs (blink alternately when animating)
    final Path arc1 = Path()
      ..moveTo(18.8 * scale, 4 * scale)
      ..arcToPoint(
        Offset(20 * scale, 9 * scale),
        radius: Radius.circular(11 * scale),
        clockwise: true,
      );
    final Path arc2 = Path()
      ..moveTo(18.518 * scale, 17.347 * scale)
      ..arcToPoint(
        Offset(14 * scale, 19 * scale),
        radius: Radius.circular(7 * scale),
        clockwise: true,
      );
    if (t == 0.0) {
      canvas.drawPath(arc1, paint);
      canvas.drawPath(arc2, paint);
    } else {
      final double a1 = 0.6 + 0.4 * (0.5 + 0.5 * math.sin(6 * s2pi));
      final double a2 = 0.6 + 0.4 * (0.5 + 0.5 * math.sin(6 * s2pi + math.pi));
      final Paint arcPaint1 = Paint()
        ..color = color.withValues(alpha: a1)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      final Paint arcPaint2 = Paint()
        ..color = color.withValues(alpha: a2)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(arc1, arcPaint1);
      canvas.drawPath(arc2, arcPaint2);
    }

    // tiny dot path 'M9 9h.01' flicker when animating
    final double dotLen = 0.01 * scale;
    final Paint dotPaint = t == 0.0
        ? paint
        : (Paint()
          ..color = color.withValues(
              alpha: 0.7 + 0.3 * (0.5 + 0.5 * math.sin(12 * s2pi)))
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke);
    canvas.drawLine(Offset(9 * scale, 9 * scale),
        Offset(9 * scale + dotLen, 9 * scale), dotPaint);
  }

  @override
  bool shouldRepaint(_BellElectricPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
