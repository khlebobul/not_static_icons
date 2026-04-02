import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Columns 3 Icon - Columns slide apart
class Columns3Icon extends AnimatedSVGIcon {
  const Columns3Icon({
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
  String get animationDescription => "Columns slide apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Columns3Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Columns3Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Columns3Painter({
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

    final oscillation = 4 * animationValue * (1 - animationValue);
    final slideOffset = oscillation * 1.0;

    // Outer rect
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rrect, paint);

    // Left divider: M9 3v18 (slides left)
    canvas.drawLine(
      Offset((9 - slideOffset) * scale, 3 * scale),
      Offset((9 - slideOffset) * scale, 21 * scale),
      paint,
    );

    // Right divider: M15 3v18 (slides right)
    canvas.drawLine(
      Offset((15 + slideOffset) * scale, 3 * scale),
      Offset((15 + slideOffset) * scale, 21 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(Columns3Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
