import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Redo 2 Icon - Arrow moves right
class Redo2Icon extends AnimatedSVGIcon {
  const Redo2Icon({
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
  String get animationDescription => "Redo arrow moves right";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Redo2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Redo 2 icon
class Redo2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Redo2Painter({
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

    // Animation - arrow moves right and back
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Arrow head: m15 14 5-5-5-5
    // Moves right during animation
    final arrowPath = Path();
    arrowPath.moveTo((15 + moveOffset) * scale, 14 * scale);
    arrowPath.lineTo((20 + moveOffset) * scale, 9 * scale);
    arrowPath.lineTo((15 + moveOffset) * scale, 4 * scale);
    canvas.drawPath(arrowPath, paint);

    // Curved path: M20 9H9.5A5.5 5.5 0 0 0 4 14.5A5.5 5.5 0 0 0 9.5 20H13
    final curvePath = Path();
    curvePath.moveTo((20 + moveOffset) * scale, 9 * scale);
    curvePath.lineTo(9.5 * scale, 9 * scale);
    // Arc to bottom (left side going down)
    curvePath.arcToPoint(
      Offset(4 * scale, 14.5 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: false,
    );
    // Arc continuing (bottom going right)
    curvePath.arcToPoint(
      Offset(9.5 * scale, 20 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: false,
    );
    curvePath.lineTo(13 * scale, 20 * scale);
    canvas.drawPath(curvePath, paint);
  }

  @override
  bool shouldRepaint(Redo2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
