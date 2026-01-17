import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Calculator Icon - Buttons press
class CalculatorIcon extends AnimatedSVGIcon {
  const CalculatorIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Buttons press sequentially";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CalculatorPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CalculatorPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CalculatorPainter({
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

    // Body
    // rect width="16" height="20" x="4" y="2" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 2 * scale, 16 * scale, 20 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Screen
    // line x1="8" x2="16" y1="6" y2="6"
    canvas.drawLine(
        Offset(8 * scale, 6 * scale), Offset(16 * scale, 6 * scale), paint);

    // Vertical Line
    // line x1="16" x2="16" y1="14" y2="18"
    canvas.drawLine(
        Offset(16 * scale, 14 * scale), Offset(16 * scale, 18 * scale), paint);

    // Buttons (Animated)
    // M16 10h.01
    // M12 10h.01
    // M8 10h.01
    // M12 14h.01
    // M8 14h.01
    // M12 18h.01
    // M8 18h.01

    // 7 buttons.
    // Animate them "pressing" (opacity or scale change) in sequence.
    // 0.0 - 1.0 cycle.
    // 7 slots.

    final buttons = [
      Offset(16, 10),
      Offset(12, 10),
      Offset(8, 10),
      Offset(12, 14),
      Offset(8, 14),
      Offset(12, 18),
      Offset(8, 18),
    ];

    for (int i = 0; i < buttons.length; i++) {
      final btn = buttons[i];

      // Determine if this button is pressed
      // Divide animation into segments, but leave a buffer at the end so it returns to original state
      // Use 0.0 to 0.9 for buttons, 0.9 to 1.0 for rest.
      final totalDuration = 0.9;
      final segment = totalDuration / buttons.length;
      final start = i * segment;
      final end = (i + 1) * segment;

      bool isPressed = false;
      if (animationValue > 0 &&
          animationValue >= start &&
          animationValue < end) {
        isPressed = true;
      }

      // If pressed, maybe change color opacity or scale?
      // Or just draw it normally vs dimmed?
      // Let's make "pressed" be full opacity, others slightly dimmed?
      // Or "pressed" be larger?
      // Let's make "pressed" scale up slightly.

      double btnScale = 1.0;
      if (isPressed) {
        btnScale = 1.5;
      }

      canvas.save();
      canvas.translate(btn.dx * scale, btn.dy * scale);
      canvas.scale(btnScale);

      canvas.drawLine(Offset(0, 0), Offset(0.01 * scale, 0), paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CalculatorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
