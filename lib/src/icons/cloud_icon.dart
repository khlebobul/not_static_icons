import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Icon - Cloud floats
class CloudIcon extends AnimatedSVGIcon {
  const CloudIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Cloud floats";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudPainter({
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

    // Cloud floating animation
    final floatOffset = math.sin(animationValue * math.pi * 2) * 1.5;

    canvas.save();
    canvas.translate(0, floatOffset * scale);

    // Cloud path: M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z
    final cloudPath = Path();
    cloudPath.moveTo(17.5 * scale, 19 * scale);
    cloudPath.lineTo(9 * scale, 19 * scale);

    // Large circle (left side): a7 7 0 1 1 6.71-9
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 10 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );

    // h1.79
    cloudPath.lineTo(17.5 * scale, 10 * scale);

    // Small circle (right side): a4.5 4.5 0 1 1 0 9
    cloudPath.arcToPoint(
      Offset(17.5 * scale, 19 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
      largeArc: true,
    );

    cloudPath.close();
    canvas.drawPath(cloudPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
