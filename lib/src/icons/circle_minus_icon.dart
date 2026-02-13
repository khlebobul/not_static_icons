import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Minus Icon - Minus line shrinks and grows
class CircleMinusIcon extends AnimatedSVGIcon {
  const CircleMinusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Minus line pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleMinusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Minus icon
class CircleMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleMinusPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Animated minus line: M8 12h8
    final oscillation = 4 * animationValue * (1 - animationValue);
    final shrink = oscillation * 2;

    canvas.drawLine(
      Offset((8 + shrink) * scale, 12 * scale),
      Offset((16 - shrink) * scale, 12 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleMinusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
