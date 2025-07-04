import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated A Large Small Icon - Letters alternately change sizes
class ALargeSmallIcon extends AnimatedSVGIcon {
  const ALargeSmallIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription => "Letters alternately change sizes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ALargeSmallPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for A Large Small icon
class ALargeSmallPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ALargeSmallPainter({
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

    // Calculate scaling factors for animation
    // Create a wave effect where letters scale up and down alternately
    final time = animationValue * 2 * pi;
    final largeAScale = 1.0 + 0.3 * sin(time);
    final smallAScale = 1.0 + 0.3 * sin(time + pi); // 180 degrees out of phase

    // ========== ANIMATED LARGE "A" ==========
    canvas.save();
    final largeACenter = Offset(7.5 * scale, 11.5 * scale);
    canvas.translate(largeACenter.dx, largeACenter.dy);
    canvas.scale(largeAScale);
    canvas.translate(-largeACenter.dx, -largeACenter.dy);

    // Large "A" following SVG path (m3 16 4.5-9 4.5 9)
    // Left side from (3,16) to (7.5,7)
    canvas.drawLine(
      Offset(3 * scale, 16 * scale),
      Offset(7.5 * scale, 7 * scale),
      paint,
    );

    // Right side from (7.5,7) to (12,16)
    canvas.drawLine(
      Offset(7.5 * scale, 7 * scale),
      Offset(12 * scale, 16 * scale),
      paint,
    );

    // Horizontal crossbar (M4.5 13h6)
    canvas.drawLine(
      Offset(4.5 * scale, 13 * scale),
      Offset(10.5 * scale, 13 * scale),
      paint,
    );

    canvas.restore();

    // ========== ANIMATED SMALL "a" ==========
    canvas.save();
    final smallACenter = Offset(18.5 * scale, 14.5 * scale);
    canvas.translate(smallACenter.dx, smallACenter.dy);
    canvas.scale(smallAScale);
    canvas.translate(-smallACenter.dx, -smallACenter.dy);

    // Small "a" - horizontal line at top (M21 14h-5)
    canvas.drawLine(
      Offset(21 * scale, 14 * scale),
      Offset(16 * scale, 14 * scale),
      paint,
    );

    // Small "a" - main shape following SVG path (M16 16v-3.5a2.5 2.5 0 0 1 5 0V16)
    // Start with vertical line up from (16,16) to (16,12.5)
    canvas.drawLine(
      Offset(16 * scale, 16 * scale),
      Offset(16 * scale, 12.5 * scale),
      paint,
    );

    // Arc with radius 2.5 from (16,12.5) - this creates the rounded part
    final arcRect = Rect.fromCenter(
      center: Offset(18.5 * scale, 12.5 * scale),
      width: 5 * scale,
      height: 5 * scale,
    );

    canvas.drawArc(
      arcRect,
      pi, // start from left side
      pi, // sweep 180 degrees to the right
      false,
      paint,
    );

    // Vertical line down from arc end to complete the "a"
    canvas.drawLine(
      Offset(21 * scale, 12.5 * scale),
      Offset(21 * scale, 16 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ALargeSmallPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
