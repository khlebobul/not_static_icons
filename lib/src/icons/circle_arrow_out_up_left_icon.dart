import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Out Up Left Icon - Arrow shoots out
class CircleArrowOutUpLeftIcon extends AnimatedSVGIcon {
  const CircleArrowOutUpLeftIcon({
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
  String get animationDescription => "Arrow shoots out to top left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowOutUpLeftPainter(
      color: color,
      animationValue: oscillation,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Out Up Left icon
class CircleArrowOutUpLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleArrowOutUpLeftPainter({
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

    // Partial circle arc: path d="M12 2A10 10 0 1 1 2 12"
    final rect = Rect.fromCircle(
      center: Offset(12 * scale, 12 * scale),
      radius: 10 * scale,
    );
    canvas.drawArc(rect, math.pi, -3 * math.pi / 2, false, paint);

    // Animated arrow offset
    final offset = animationValue * 2;

    // Arrow head corner: M2 8V2h6
    final path = Path();
    path.moveTo((2 - offset) * scale, (8 - offset) * scale);
    path.lineTo((2 - offset) * scale, (2 - offset) * scale);
    path.lineTo((8 - offset) * scale, (2 - offset) * scale);
    canvas.drawPath(path, paint);

    // Diagonal line: m2 2 10 10
    canvas.drawLine(
      Offset((2 - offset) * scale, (2 - offset) * scale),
      Offset((12 - offset) * scale, (12 - offset) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleArrowOutUpLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
