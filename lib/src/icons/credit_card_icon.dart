import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Credit Card Icon - card swipes right then returns on hover/tap
class CreditCardIcon extends AnimatedSVGIcon {
  const CreditCardIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
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
  String get animationDescription => 'Card swipes right then returns';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CreditCardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CreditCardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CreditCardPainter({
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

    // Swipe offset: card slides right then back
    final double dx = math.sin(math.pi * t) * 2.5 * s;

    canvas.save();
    canvas.translate(dx, 0);

    // Card body: rect width=20 height=14 x=2 y=5 rx=2
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * s, 5 * s, 20 * s, 14 * s),
        Radius.circular(2 * s),
      ),
      paint,
    );

    // Stripe: line x1=2 x2=22 y1=10 y2=10
    canvas.drawLine(Offset(2 * s, 10 * s), Offset(22 * s, 10 * s), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CreditCardPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
