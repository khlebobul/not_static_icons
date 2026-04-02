import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Component Icon - Diamonds pulse outward
class ComponentIcon extends AnimatedSVGIcon {
  const ComponentIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Diamonds pulse outward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ComponentPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ComponentPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ComponentPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  void _drawDiamond(Canvas canvas, Paint paint, double cx, double cy,
      double halfSize, double scale) {
    final path = Path();
    path.moveTo(cx * scale, (cy - halfSize) * scale);
    path.lineTo((cx + halfSize) * scale, cy * scale);
    path.lineTo(cx * scale, (cy + halfSize) * scale);
    path.lineTo((cx - halfSize) * scale, cy * scale);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    final oscillation = 4 * animationValue * (1 - animationValue);
    final spread = oscillation * 1.0;

    // Four diamonds that spread outward from center
    // Right diamond: center ~(19, 12)
    _drawDiamond(canvas, paint, 19 + spread, 12, 2.377, scale);

    // Left diamond: center ~(5, 12)
    _drawDiamond(canvas, paint, 5 - spread, 12, 2.377, scale);

    // Bottom diamond: center ~(12, 20)
    _drawDiamond(canvas, paint, 12, 20 + spread, 2.377, scale);

    // Top diamond: center ~(12, 4)
    _drawDiamond(canvas, paint, 12, 4 - spread, 2.377, scale);
  }

  @override
  bool shouldRepaint(ComponentPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
