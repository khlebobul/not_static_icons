import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Dashed Icon - Dashes rotate
class CircleDashedIcon extends AnimatedSVGIcon {
  const CircleDashedIcon({
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
  String get animationDescription => "Dashed circle rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleDashedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Dashed icon
class CircleDashedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleDashedPainter({
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

    // Rotation animation
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animationValue * math.pi / 4);
    canvas.translate(-center.dx, -center.dy);

    // Draw 8 dashed arcs around the circle
    final rect = Rect.fromCircle(center: center, radius: 10 * scale);
    const dashCount = 8;
    const gapAngle = math.pi / 16;
    const dashAngle = (2 * math.pi - dashCount * gapAngle) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * (dashAngle + gapAngle) - math.pi / 2;
      canvas.drawArc(rect, startAngle, dashAngle, false, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleDashedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
