import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Plus Icon - Lines expand from center
class PlusIcon extends AnimatedSVGIcon {
  const PlusIcon({
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
    super.interactive = true,
    super.controller,
  });

  @override
  String get animationDescription => "Lines expand";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return PlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class PlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  PlusPainter({
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

    // Animation - lines expand from center
    final oscillation = 4 * animationValue * (1 - animationValue);
    final expansion = oscillation * 2.0;

    // Horizontal line: M5 12h14
    canvas.drawLine(
      Offset((5 - expansion) * scale, 12 * scale),
      Offset((19 + expansion) * scale, 12 * scale),
      paint,
    );

    // Vertical line: M12 5v14
    canvas.drawLine(
      Offset(12 * scale, (5 - expansion) * scale),
      Offset(12 * scale, (19 + expansion) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(PlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
