import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clover Icon - Clover rotates
class CloverIcon extends AnimatedSVGIcon {
  const CloverIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Clover rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloverPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloverPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloverPainter({
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

    // Animation - rotate
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 4;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Stem line: M16.17 7.83 2 22
    canvas.drawLine(
      Offset(16.17 * scale, 7.83 * scale),
      Offset(2 * scale, 22 * scale),
      paint,
    );

    // Clover shape with four leaf arcs
    // M4.02 12a2.827 2.827 0 1 1 3.81-4.17
    // A2.827 2.827 0 1 1 12 4.02
    // a2.827 2.827 0 1 1 4.17 3.81
    // A2.827 2.827 0 1 1 19.98 12
    // a2.827 2.827 0 1 1-3.81 4.17
    // A2.827 2.827 0 1 1 12 19.98
    // a2.827 2.827 0 1 1-4.17-3.81
    // A1 1 0 1 1 4 12
    final cloverPath = Path();
    cloverPath.moveTo(4.02 * scale, 12 * scale);

    // Top-left leaf
    cloverPath.arcToPoint(
      Offset(7.83 * scale, 7.83 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Top-right leaf
    cloverPath.arcToPoint(
      Offset(12 * scale, 4.02 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Right-top leaf
    cloverPath.arcToPoint(
      Offset(16.17 * scale, 7.83 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Right-bottom leaf
    cloverPath.arcToPoint(
      Offset(19.98 * scale, 12 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Bottom-right leaf
    cloverPath.arcToPoint(
      Offset(16.17 * scale, 16.17 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Bottom-left leaf
    cloverPath.arcToPoint(
      Offset(12 * scale, 19.98 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Left-bottom leaf
    cloverPath.arcToPoint(
      Offset(7.83 * scale, 16.17 * scale),
      radius: Radius.circular(2.827 * scale),
      largeArc: true,
      clockwise: true,
    );

    // Left-top leaf (closes back)
    cloverPath.arcToPoint(
      Offset(4 * scale, 12 * scale),
      radius: Radius.circular(1 * scale),
      largeArc: true,
      clockwise: true,
    );

    canvas.drawPath(cloverPath, paint);

    // Cross line: m7.83 7.83 8.34 8.34
    canvas.drawLine(
      Offset(7.83 * scale, 7.83 * scale),
      Offset(16.17 * scale, 16.17 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloverPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
