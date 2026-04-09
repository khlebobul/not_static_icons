import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copyleft Icon - Circle rotates
class CopyleftIcon extends AnimatedSVGIcon {
  const CopyleftIcon({
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
  String get animationDescription => "Circle rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopyleftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopyleftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopyleftPainter({
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

    // Outer circle with rotation
    final rotation = animationValue * math.pi * 2;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(Offset(12 * scale, 12 * scale), 10 * scale, paint);

    // C shape (reversed): M9.17 14.83a4 4 0 1 0 0-5.66
    // a4 4 0 1 0 means: radius=4, largeArc=true, clockwise=false
    final cPath = Path();
    cPath.moveTo(9.17 * scale, 14.83 * scale);
    cPath.arcToPoint(
      Offset(9.17 * scale, 9.17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(cPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CopyleftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
