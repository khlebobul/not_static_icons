import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Computer Icon - Screen pulses
class ComputerIcon extends AnimatedSVGIcon {
  const ComputerIcon({
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
  String get animationDescription => "Screen pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ComputerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ComputerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ComputerPainter({
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

    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounce = oscillation * 1.5;

    // Monitor (animated - bounces up): x="5" y="2" width="14" height="8" rx="2"
    final monitorRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(5 * scale, (2 - bounce) * scale, 14 * scale, 8 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(monitorRect, paint);

    // Base unit (static): x="2" y="14" width="20" height="8" rx="2"
    final baseRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, 14 * scale, 20 * scale, 8 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(baseRect, paint);

    // Base detail: M6 18h2
    canvas.drawLine(
      Offset(6 * scale, 18 * scale),
      Offset(8 * scale, 18 * scale),
      paint,
    );

    // Base detail: M12 18h6
    canvas.drawLine(
      Offset(12 * scale, 18 * scale),
      Offset(18 * scale, 18 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ComputerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
