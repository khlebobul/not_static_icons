import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Plus Icon - Plus rotates/pulses
class CirclePlusIcon extends AnimatedSVGIcon {
  const CirclePlusIcon({
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
  String get animationDescription => "Plus rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CirclePlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Plus icon
class CirclePlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CirclePlusPainter({
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

    // Animated plus with rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.5; // ~90 degrees rotation

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Horizontal line: M8 12h8
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );

    // Vertical line: M12 8v8
    canvas.drawLine(
      Offset(12 * scale, 8 * scale),
      Offset(12 * scale, 16 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
