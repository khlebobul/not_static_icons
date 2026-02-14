import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Pile Icon - Circles bounce sequentially
class CirclePileIcon extends AnimatedSVGIcon {
  const CirclePileIcon({
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
  String get animationDescription => "Circle pile bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CirclePilePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Pile icon
class CirclePilePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CirclePilePainter({
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

    // Sequential bounce animation
    double getBounce(int index) {
      final phase = (animationValue + index * 0.15) % 1.0;
      return 4 * phase * (1 - phase) * 2;
    }

    // Top circle: cx="12" cy="5" r="2"
    canvas.drawCircle(
      Offset(12 * scale, (5 - getBounce(0)) * scale),
      2 * scale,
      paint,
    );

    // Middle left circle: cx="8" cy="12" r="2"
    canvas.drawCircle(
      Offset(8 * scale, (12 - getBounce(1)) * scale),
      2 * scale,
      paint,
    );

    // Middle right circle: cx="16" cy="12" r="2"
    canvas.drawCircle(
      Offset(16 * scale, (12 - getBounce(2)) * scale),
      2 * scale,
      paint,
    );

    // Bottom left circle: cx="4" cy="19" r="2"
    canvas.drawCircle(
      Offset(4 * scale, (19 - getBounce(3)) * scale),
      2 * scale,
      paint,
    );

    // Bottom center circle: cx="12" cy="19" r="2"
    canvas.drawCircle(
      Offset(12 * scale, (19 - getBounce(4)) * scale),
      2 * scale,
      paint,
    );

    // Bottom right circle: cx="20" cy="19" r="2"
    canvas.drawCircle(
      Offset(20 * scale, (19 - getBounce(5)) * scale),
      2 * scale,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePilePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
