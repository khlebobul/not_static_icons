import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Alert Icon - Exclamation pulses/scales
class CircleAlertIcon extends AnimatedSVGIcon {
  const CircleAlertIcon({
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
  String get animationDescription => "Alert icon pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleAlertPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Alert icon
class CircleAlertPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleAlertPainter({
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

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Exclamation line: x1="12" x2="12" y1="8" y2="12"
    canvas.drawLine(
      Offset(12 * scale, 8 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );

    // Exclamation dot: x1="12" x2="12.01" y1="16" y2="16"
    canvas.drawLine(
      Offset(12 * scale, 16 * scale),
      Offset(12.01 * scale, 16 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleAlertPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
