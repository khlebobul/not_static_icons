import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Contrast Icon - Circle rotates
class ContrastIcon extends AnimatedSVGIcon {
  const ContrastIcon({
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
  String get animationDescription => "Circle rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ContrastPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ContrastPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ContrastPainter({
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
    final rotation = animationValue * math.pi * 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Outer circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Half fill: M12 18a6 6 0 0 0 0-12v12z
    final halfPath = Path();
    halfPath.moveTo(12 * scale, 18 * scale);
    halfPath.arcToPoint(
      Offset(12 * scale, 6 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    halfPath.lineTo(12 * scale, 18 * scale);
    halfPath.close();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(halfPath, fillPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ContrastPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
