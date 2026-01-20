import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated X Icon - Lines rotate
class XIcon extends AnimatedSVGIcon {
  const XIcon({
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
  String get animationDescription => "X rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return XPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class XPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  XPainter({
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
    final center = Offset(size.width / 2, size.height / 2);

    // Animation - rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.5; // 90 degrees rotation effect

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Line 1: M18 6 6 18
    canvas.drawLine(
      Offset(18 * scale, 6 * scale),
      Offset(6 * scale, 18 * scale),
      paint,
    );

    // Line 2: m6 6 12 12
    canvas.drawLine(
      Offset(6 * scale, 6 * scale),
      Offset(18 * scale, 18 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(XPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
