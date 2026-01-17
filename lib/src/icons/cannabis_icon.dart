import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Cannabis Icon - Leaf sways
class CannabisIcon extends AnimatedSVGIcon {
  const CannabisIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Leaf sways";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Sway: sine wave, slow
    final angle = math.sin(animationValue * math.pi * 2) * (10 * math.pi / 180);

    return CannabisPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CannabisPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CannabisPainter({
    required this.color,
    required this.angle,
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

    // Stem (Static or moves with leaf?)
    // M12 22v-4
    // If leaf moves, stem should probably stay or move slightly.
    // Let's keep stem static base, and rotate leaf around 12, 18.

    canvas.drawLine(
        Offset(12 * scale, 22 * scale), Offset(12 * scale, 18 * scale), paint);

    // Leaf
    // M7 12c-1.5 0-4.5 1.5-5 3 3.5 1.5 6 1 6 1-1.5 1.5-2 3.5-2 5 2.5 0 4.5-1.5 6-3 1.5 1.5 3.5 3 6 3 0-1.5-.5-3.5-2-5 0 0 2.5.5 6-1-.5-1.5-3.5-3-5-3 1.5-1 4-4 4-6-2.5 0-5.5 1.5-7 3 0-2.5-.5-5-2-7-1.5 2-2 4.5-2 7-1.5-1.5-4.5-3-7-3 0 2 2.5 5 4 6

    canvas.save();
    canvas.translate(12 * scale, 18 * scale);
    canvas.rotate(angle);
    canvas.translate(-12 * scale, -18 * scale);

    final leafPath = Path();
    leafPath.moveTo(7 * scale, 12 * scale);
    // c-1.5 0-4.5 1.5-5 3
    leafPath.cubicTo(
      (7 - 1.5) * scale, 12 * scale,
      (7 - 4.5) * scale, (12 + 1.5) * scale,
      (7 - 5) * scale, (12 + 3) * scale, // 2, 15
    );
    // 3.5 1.5 6 1 6 1
    leafPath.cubicTo(
      (2 + 3.5) * scale, (15 + 1.5) * scale,
      (2 + 6) * scale, (15 + 1) * scale,
      (2 + 6) * scale, (15 + 1) * scale, // 8, 16
    );
    // -1.5 1.5-2 3.5-2 5
    leafPath.cubicTo(
      (8 - 1.5) * scale, (16 + 1.5) * scale,
      (8 - 2) * scale, (16 + 3.5) * scale,
      (8 - 2) * scale, (16 + 5) * scale, // 6, 21
    );
    // 2.5 0 4.5-1.5 6-3
    leafPath.cubicTo(
      (6 + 2.5) * scale, 21 * scale,
      (6 + 4.5) * scale, (21 - 1.5) * scale,
      (6 + 6) * scale, (21 - 3) * scale, // 12, 18
    );
    // 1.5 1.5 3.5 3 6 3
    leafPath.cubicTo(
      (12 + 1.5) * scale, (18 + 1.5) * scale,
      (12 + 3.5) * scale, (18 + 3) * scale,
      (12 + 6) * scale, (18 + 3) * scale, // 18, 21
    );
    // 0-1.5-.5-3.5-2-5
    leafPath.cubicTo(
      18 * scale, (21 - 1.5) * scale,
      (18 - 0.5) * scale, (21 - 3.5) * scale,
      (18 - 2) * scale, (21 - 5) * scale, // 16, 16
    );
    // 0 0 2.5.5 6-1
    leafPath.cubicTo(
      16 * scale, 16 * scale,
      (16 + 2.5) * scale, (16 + 0.5) * scale,
      (16 + 6) * scale, (16 - 1) * scale, // 22, 15
    );
    // -.5-1.5-3.5-3-5-3
    leafPath.cubicTo(
      (22 - 0.5) * scale, (15 - 1.5) * scale,
      (22 - 3.5) * scale, (15 - 3) * scale,
      (22 - 5) * scale, (15 - 3) * scale, // 17, 12
    );
    // 1.5-1 4-4 4-6
    leafPath.cubicTo(
      (17 + 1.5) * scale, (12 - 1) * scale,
      (17 + 4) * scale, (12 - 4) * scale,
      (17 + 4) * scale, (12 - 6) * scale, // 21, 6
    );
    // -2.5 0-5.5 1.5-7 3
    leafPath.cubicTo(
      (21 - 2.5) * scale, 6 * scale,
      (21 - 5.5) * scale, (6 + 1.5) * scale,
      (21 - 7) * scale, (6 + 3) * scale, // 14, 9
    );
    // 0-2.5-.5-5-2-7
    leafPath.cubicTo(
      14 * scale, (9 - 2.5) * scale,
      (14 - 0.5) * scale, (9 - 5) * scale,
      (14 - 2) * scale, (9 - 7) * scale, // 12, 2
    );
    // -1.5 2-2 4.5-2 7
    leafPath.cubicTo(
      (12 - 1.5) * scale, (2 + 2) * scale,
      (12 - 2) * scale, (2 + 4.5) * scale,
      (12 - 2) * scale, (2 + 7) * scale, // 10, 9
    );
    // -1.5-1.5-4.5-3-7-3
    leafPath.cubicTo(
      (10 - 1.5) * scale, (9 - 1.5) * scale,
      (10 - 4.5) * scale, (9 - 3) * scale,
      (10 - 7) * scale, (9 - 3) * scale, // 3, 6
    );
    // 0 2 2.5 5 4 6
    leafPath.cubicTo(
      3 * scale, (6 + 2) * scale,
      (3 + 2.5) * scale, (6 + 5) * scale,
      (3 + 4) * scale, (6 + 6) * scale, // 7, 12
    );

    canvas.drawPath(leafPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CannabisPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
