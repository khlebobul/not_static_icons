import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Columns 4 Icon - Columns slide apart
class Columns4Icon extends AnimatedSVGIcon {
  const Columns4Icon({
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
    return Columns4Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Columns4Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Columns4Painter({
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
    final slideOffset = oscillation * 0.8;

    // Outer rect
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rrect, paint);

    // Left divider: M7.5 3v18 (slides left)
    canvas.drawLine(
      Offset((7.5 - slideOffset) * scale, 3 * scale),
      Offset((7.5 - slideOffset) * scale, 21 * scale),
      paint,
    );

    // Center divider: M12 3v18 (static)
    canvas.drawLine(
      Offset(12 * scale, 3 * scale),
      Offset(12 * scale, 21 * scale),
      paint,
    );

    // Right divider: M16.5 3v18 (slides right)
    canvas.drawLine(
      Offset((16.5 + slideOffset) * scale, 3 * scale),
      Offset((16.5 + slideOffset) * scale, 21 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(Columns4Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
