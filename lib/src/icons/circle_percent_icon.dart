import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Percent Icon - Percent symbol pulses
class CirclePercentIcon extends AnimatedSVGIcon {
  const CirclePercentIcon({
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
  String get animationDescription => "Percent symbol pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CirclePercentPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Percent icon
class CirclePercentPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CirclePercentPainter({
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

    // Animated percent symbol with pulse
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Diagonal line: m15 9-6 6
    canvas.drawLine(
      Offset(15 * scale, 9 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );

    // Top-left dot: M9 9h.01
    canvas.drawLine(
      Offset(9 * scale, 9 * scale),
      Offset(9.01 * scale, 9 * scale),
      paint,
    );

    // Bottom-right dot: M15 15h.01
    canvas.drawLine(
      Offset(15 * scale, 15 * scale),
      Offset(15.01 * scale, 15 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePercentPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
