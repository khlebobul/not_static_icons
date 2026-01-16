import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Undo 2 Icon - Arrow moves left
class Undo2Icon extends AnimatedSVGIcon {
  const Undo2Icon({
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
  String get animationDescription => "Undo arrow moves left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Undo2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Undo 2 icon
class Undo2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Undo2Painter({
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

    // Animation - arrow moves left and back
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Arrow head: M9 14 L4 9 l5-5
    // Moves left during animation
    final arrowPath = Path();
    arrowPath.moveTo((9 - moveOffset) * scale, 14 * scale);
    arrowPath.lineTo((4 - moveOffset) * scale, 9 * scale);
    arrowPath.lineTo((9 - moveOffset) * scale, 4 * scale);
    canvas.drawPath(arrowPath, paint);

    // Curved path: M4 9h10.5a5.5 5.5 0 0 1 5.5 5.5a5.5 5.5 0 0 1-5.5 5.5H11
    final curvePath = Path();
    curvePath.moveTo((4 - moveOffset) * scale, 9 * scale);
    curvePath.lineTo(14.5 * scale, 9 * scale);
    // Arc to bottom (right side going down)
    curvePath.arcToPoint(
      Offset(20 * scale, 14.5 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: true,
    );
    // Arc continuing (bottom going left)
    curvePath.arcToPoint(
      Offset(14.5 * scale, 20 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: true,
    );
    curvePath.lineTo(11 * scale, 20 * scale);
    canvas.drawPath(curvePath, paint);
  }

  @override
  bool shouldRepaint(Undo2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
