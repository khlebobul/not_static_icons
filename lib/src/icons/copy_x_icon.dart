import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copy X Icon - X rotates
class CopyXIcon extends AnimatedSVGIcon {
  const CopyXIcon({
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
  String get animationDescription => "X rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopyXPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopyXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopyXPainter({
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

    // Front rect
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 8 * scale, 14 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(frontRect, paint);

    // Back document
    final backPath = Path();
    backPath.moveTo(4 * scale, 16 * scale);
    backPath.cubicTo(
      2.9 * scale,
      16 * scale,
      2 * scale,
      15.1 * scale,
      2 * scale,
      14 * scale,
    );
    backPath.lineTo(2 * scale, 4 * scale);
    backPath.cubicTo(
      2 * scale,
      2.9 * scale,
      2.9 * scale,
      2 * scale,
      4 * scale,
      2 * scale,
    );
    backPath.lineTo(14 * scale, 2 * scale);
    backPath.cubicTo(
      15.1 * scale,
      2 * scale,
      16 * scale,
      2.9 * scale,
      16 * scale,
      4 * scale,
    );
    canvas.drawPath(backPath, paint);

    // X with rotation
    final rotation = animationValue * math.pi * 0.5;

    canvas.save();
    canvas.translate(15 * scale, 15 * scale);
    canvas.rotate(rotation);
    canvas.translate(-15 * scale, -15 * scale);

    // x1="12" x2="18" y1="12" y2="18"
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(18 * scale, 18 * scale), paint);
    // x1="12" x2="18" y1="18" y2="12"
    canvas.drawLine(
        Offset(12 * scale, 18 * scale), Offset(18 * scale, 12 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CopyXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
