import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Pause Icon - Bars move apart and together
class CirclePauseIcon extends AnimatedSVGIcon {
  const CirclePauseIcon({
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
  String get animationDescription => "Pause bars move apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CirclePausePainter(
      color: color,
      offset: oscillation * 1.5,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Pause icon
class CirclePausePainter extends CustomPainter {
  final Color color;
  final double offset;
  final double strokeWidth;

  CirclePausePainter({
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

    // Left bar: x1="10" x2="10" y1="15" y2="9" (moves left)
    canvas.drawLine(
      Offset((10 - offset) * scale, 15 * scale),
      Offset((10 - offset) * scale, 9 * scale),
      paint,
    );

    // Right bar: x1="14" x2="14" y1="15" y2="9" (moves right)
    canvas.drawLine(
      Offset((14 + offset) * scale, 15 * scale),
      Offset((14 + offset) * scale, 9 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePausePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.offset != offset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
