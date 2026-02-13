import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Ellipsis Icon - Dots pulse sequentially
class CircleEllipsisIcon extends AnimatedSVGIcon {
  const CircleEllipsisIcon({
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
  String get animationDescription => "Ellipsis dots pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleEllipsisPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Ellipsis icon
class CircleEllipsisPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleEllipsisPainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;
    final center = Offset(12 * scale, 12 * scale);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // All dots pulse together with same animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final dotScale = 1.0 + oscillation * 0.5;

    final dotRadius = 0.5 * scale * dotScale;

    // Left dot: M7 12h.01
    canvas.drawCircle(
      Offset(7 * scale, 12 * scale),
      dotRadius,
      fillPaint,
    );

    // Center dot: M12 12h.01
    canvas.drawCircle(
      Offset(12 * scale, 12 * scale),
      dotRadius,
      fillPaint,
    );

    // Right dot: M17 12h.01
    canvas.drawCircle(
      Offset(17 * scale, 12 * scale),
      dotRadius,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(CircleEllipsisPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
