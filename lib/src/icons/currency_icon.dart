import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Currency Icon - full spin rotation like a coin on hover/tap
class CurrencyIcon extends AnimatedSVGIcon {
  const CurrencyIcon({
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
  String get animationDescription => 'Spins like a coin';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CurrencyPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CurrencyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CurrencyPainter({
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

    // Rotate everything around center (12, 12)
    final double angle = 2 * math.pi * t;

    canvas.save();
    canvas.translate(12 * s, 12 * s);
    canvas.rotate(angle);
    canvas.translate(-12 * s, -12 * s);

    // Circle: cx=12 cy=12 r=8
    canvas.drawCircle(Offset(12 * s, 12 * s), 8 * s, paint);

    // Top-left corner line: (3,3) to (6,6)
    canvas.drawLine(Offset(3 * s, 3 * s), Offset(6 * s, 6 * s), paint);

    // Top-right corner line: (21,3) to (18,6)
    canvas.drawLine(Offset(21 * s, 3 * s), Offset(18 * s, 6 * s), paint);

    // Bottom-left corner line: (3,21) to (6,18)
    canvas.drawLine(Offset(3 * s, 21 * s), Offset(6 * s, 18 * s), paint);

    // Bottom-right corner line: (21,21) to (18,18)
    canvas.drawLine(Offset(21 * s, 21 * s), Offset(18 * s, 18 * s), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CurrencyPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
