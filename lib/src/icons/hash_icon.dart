import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Hash Icon - Lines rotate slightly
class HashIcon extends AnimatedSVGIcon {
  const HashIcon({
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
  String get animationDescription => "Hash rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return HashPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class HashPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  HashPainter({
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

    // Animation - slight rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.1; // Small rotation angle

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Horizontal line 1: x1="4" x2="20" y1="9" y2="9"
    canvas.drawLine(
      Offset(4 * scale, 9 * scale),
      Offset(20 * scale, 9 * scale),
      paint,
    );

    // Horizontal line 2: x1="4" x2="20" y1="15" y2="15"
    canvas.drawLine(
      Offset(4 * scale, 15 * scale),
      Offset(20 * scale, 15 * scale),
      paint,
    );

    // Vertical line 1: x1="10" x2="8" y1="3" y2="21"
    canvas.drawLine(
      Offset(10 * scale, 3 * scale),
      Offset(8 * scale, 21 * scale),
      paint,
    );

    // Vertical line 2: x1="16" x2="14" y1="3" y2="21"
    canvas.drawLine(
      Offset(16 * scale, 3 * scale),
      Offset(14 * scale, 21 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(HashPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
