import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Arrow Out Up Right Icon - Arrow shoots out
class CircleArrowOutUpRightIcon extends AnimatedSVGIcon {
  const CircleArrowOutUpRightIcon({
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
  String get animationDescription => "Arrow shoots out to top right";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    final oscillation = 4 * animationValue * (1 - animationValue);
    return CircleArrowOutUpRightPainter(
      color: color,
      animationValue: oscillation,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Arrow Out Up Right icon
class CircleArrowOutUpRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleArrowOutUpRightPainter({
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

    // Partial circle arc: path d="M22 12A10 10 0 1 1 12 2"
    final rect = Rect.fromCircle(
      center: Offset(12 * scale, 12 * scale),
      radius: 10 * scale,
    );
    canvas.drawArc(rect, -math.pi / 2, -3 * math.pi / 2, false, paint);

    // Animated arrow offset
    final offset = animationValue * 2;

    // Diagonal line: M22 2 12 12
    canvas.drawLine(
      Offset((22 + offset) * scale, (2 - offset) * scale),
      Offset((12 + offset) * scale, (12 - offset) * scale),
      paint,
    );

    // Arrow head corner: M16 2h6v6
    final path = Path();
    path.moveTo((16 + offset) * scale, (2 - offset) * scale);
    path.lineTo((22 + offset) * scale, (2 - offset) * scale);
    path.lineTo((22 + offset) * scale, (8 - offset) * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircleArrowOutUpRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
