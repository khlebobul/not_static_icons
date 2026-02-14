import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle X Icon - X rotates/pulses
class CircleXIcon extends AnimatedSVGIcon {
  const CircleXIcon({
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
  String get animationDescription => "X rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleXPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle X icon
class CircleXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleXPainter({
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

    // Animated X with rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // X lines: m15 9-6 6 and m9 9 6 6
    canvas.drawLine(
      Offset(15 * scale, 9 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );

    canvas.drawLine(
      Offset(9 * scale, 9 * scale),
      Offset(15 * scale, 15 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
