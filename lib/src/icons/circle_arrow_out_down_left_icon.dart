import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Out Down Left Icon - Arrow shoots out
class CircleArrowOutDownLeftIcon extends AnimatedSVGIcon {
  const CircleArrowOutDownLeftIcon({
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
  String get animationDescription => "Arrow shoots out to bottom left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowOutDownLeftPainter(
      color: color,
      animationValue: oscillation,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Out Down Left icon
class CircleArrowOutDownLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleArrowOutDownLeftPainter({
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

    // Partial circle arc: M2 12a10 10 0 1 1 10 10
    // This is an arc from (2,12) going clockwise
    final rect = Rect.fromCircle(
      center: Offset(12 * scale, 12 * scale),
      radius: 10 * scale,
    );
    // Start at 180 degrees (left), sweep 270 degrees clockwise
    canvas.drawArc(rect, math.pi, 3 * math.pi / 2, false, paint);

    // Animated arrow offset
    final offset = animationValue * 2;

    // Diagonal line: m2 22 10-10
    canvas.drawLine(
      Offset((2 - offset) * scale, (22 + offset) * scale),
      Offset((12 - offset) * scale, (12 + offset) * scale),
      paint,
    );

    // Arrow head: M8 22H2v-6
    final path = Path();
    path.moveTo((8 - offset) * scale, (22 + offset) * scale);
    path.lineTo((2 - offset) * scale, (22 + offset) * scale);
    path.lineTo((2 - offset) * scale, (16 + offset) * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleArrowOutDownLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
