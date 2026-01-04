import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Venus Icon - Cross pulses downward
class VenusIcon extends AnimatedSVGIcon {
  const VenusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Venus cross pulses downward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return VenusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Venus icon
class VenusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  VenusPainter({
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

    // Animation - cross extends downward
    final oscillation = 4 * animationValue * (1 - animationValue);
    final crossOffset = oscillation * 1.5;

    // Circle: cx="12" cy="9" r="6"
    canvas.drawCircle(
      Offset(12 * scale, 9 * scale),
      6 * scale,
      paint,
    );

    // Vertical line: M12 15v7 (with animation)
    canvas.drawLine(
      Offset(12 * scale, 15 * scale),
      Offset(12 * scale, (22 + crossOffset) * scale),
      paint,
    );

    // Horizontal line: M9 19h6 (with animation offset)
    canvas.drawLine(
      Offset(9 * scale, (19 + crossOffset) * scale),
      Offset(15 * scale, (19 + crossOffset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(VenusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
