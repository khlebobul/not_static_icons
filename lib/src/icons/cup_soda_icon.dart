import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cup Soda Icon - the bubble/wave line oscillates upward on hover/tap
class CupSodaIcon extends AnimatedSVGIcon {
  const CupSodaIcon({
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
  String get animationDescription => 'Bubble wave line rises and falls';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CupSodaPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CupSodaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CupSodaPainter({
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

    // Cup body: m6 8 1.75 12.28a2 2 0 0 0 2 1.72h4.54a2 2 0 0 0 2-1.72L18 8
    final Path body = Path()
      ..moveTo(6 * s, 8 * s)
      ..relativeLineTo(1.75 * s, 12.28 * s)
      ..relativeArcToPoint(
        Offset(2 * s, 1.72 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..relativeLineTo(4.54 * s, 0)
      ..relativeArcToPoint(
        Offset(2 * s, -1.72 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..lineTo(18 * s, 8 * s);
    canvas.drawPath(body, paint);

    // Top opening: M5 8h14
    canvas.drawLine(Offset(5 * s, 8 * s), Offset(19 * s, 8 * s), paint);

    // Straw: m12 8 1-6h2 → moveTo(12,8) relLineTo(1,-6) relLineTo(2,0)
    final Path straw = Path()
      ..moveTo(12 * s, 8 * s)
      ..relativeLineTo(1 * s, -6 * s)
      ..relativeLineTo(2 * s, 0);
    canvas.drawPath(straw, paint);

    // Bubble wave: M7 15a6.47 6.47 0 0 1 5 0 6.47 6.47 0 0 0 5 0
    // Oscillates upward with animation
    final double waveOffset = -math.sin(math.pi * t) * 1.8 * s;

    canvas.save();
    canvas.translate(0, waveOffset);
    final Path wave = Path()
      ..moveTo(7 * s, 15 * s)
      ..relativeArcToPoint(
        Offset(5 * s, 0),
        radius: Radius.circular(6.47 * s),
        clockwise: true,
      )
      ..relativeArcToPoint(
        Offset(5 * s, 0),
        radius: Radius.circular(6.47 * s),
        clockwise: false,
      );
    canvas.drawPath(wave, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupSodaPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
