import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Small Icon - Small circle grows and shrinks
class CircleSmallIcon extends AnimatedSVGIcon {
  const CircleSmallIcon({
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
  String get animationDescription => "Small circle grows";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleSmallPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Small icon
class CircleSmallPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleSmallPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animated radius: grows from 6 to 8 and back
    final oscillation = 4 * animationValue * (1 - animationValue);
    final radius = 6 + oscillation * 2;

    // Small circle: cx="12" cy="12" r="6"
    canvas.drawCircle(center, radius * scale, paint);
  }

  @override
  bool shouldRepaint(CircleSmallPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
