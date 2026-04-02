import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Columns 2 Icon - Columns slide apart
class Columns2Icon extends AnimatedSVGIcon {
  const Columns2Icon({
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
    return Columns2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Columns2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Columns2Painter({
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

    // Animation - divider line slides
    final oscillation = 4 * animationValue * (1 - animationValue);
    final slideOffset = oscillation * 1.5;

    // Outer rect: x="3" y="3" width="18" height="18" rx="2"
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rrect, paint);

    // Divider line: M12 3v18 (animated)
    canvas.drawLine(
      Offset((12 + slideOffset) * scale, 3 * scale),
      Offset((12 + slideOffset) * scale, 21 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(Columns2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
