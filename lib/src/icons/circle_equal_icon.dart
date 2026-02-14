import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Equal Icon - Lines move apart and together
class CircleEqualIcon extends AnimatedSVGIcon {
  const CircleEqualIcon({
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
  String get animationDescription => "Equal lines move apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleEqualPainter(
      color: color,
      offset: oscillation * 1.5,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Equal icon
class CircleEqualPainter extends CustomPainter {
  final Color color;
  final double offset;
  final double strokeWidth;

  CircleEqualPainter({
    required this.color,
    required this.offset,
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

    // Top line: M7 10h10 (moves up)
    canvas.drawLine(
      Offset(7 * scale, (10 - offset) * scale),
      Offset(17 * scale, (10 - offset) * scale),
      paint,
    );

    // Bottom line: M7 14h10 (moves down)
    canvas.drawLine(
      Offset(7 * scale, (14 + offset) * scale),
      Offset(17 * scale, (14 + offset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleEqualPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offset != offset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
