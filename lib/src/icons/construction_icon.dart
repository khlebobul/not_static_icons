import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Construction Icon - Barrier flashes
class ConstructionIcon extends AnimatedSVGIcon {
  const ConstructionIcon({
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
  String get animationDescription => "Barrier flashes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ConstructionPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ConstructionPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ConstructionPainter({
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

    // Animation - barrier bounces
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounce = oscillation * 1.5;

    // Barrier body (animated): x="2" y="6" width="20" height="8" rx="1"
    final barrierRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * scale, (6 - bounce) * scale, 20 * scale, 8 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(barrierRect, paint);

    // Legs (static)
    // M17 14v7
    canvas.drawLine(
      Offset(17 * scale, 14 * scale),
      Offset(17 * scale, 21 * scale),
      paint,
    );
    // M7 14v7
    canvas.drawLine(
      Offset(7 * scale, 14 * scale),
      Offset(7 * scale, 21 * scale),
      paint,
    );

    // Top posts (animated)
    // M17 3v3
    canvas.drawLine(
      Offset(17 * scale, (3 - bounce) * scale),
      Offset(17 * scale, (6 - bounce) * scale),
      paint,
    );
    // M7 3v3
    canvas.drawLine(
      Offset(7 * scale, (3 - bounce) * scale),
      Offset(7 * scale, (6 - bounce) * scale),
      paint,
    );

    // Diagonal stripes (animated)
    // M10 14 L2.3 6.3
    canvas.drawLine(
      Offset(10 * scale, (14 - bounce) * scale),
      Offset(2.3 * scale, (6.3 - bounce) * scale),
      paint,
    );
    // m14 6 7.7 7.7
    canvas.drawLine(
      Offset(14 * scale, (6 - bounce) * scale),
      Offset(21.7 * scale, (13.7 - bounce) * scale),
      paint,
    );
    // m8 6 8 8
    canvas.drawLine(
      Offset(8 * scale, (6 - bounce) * scale),
      Offset(16 * scale, (14 - bounce) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ConstructionPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
