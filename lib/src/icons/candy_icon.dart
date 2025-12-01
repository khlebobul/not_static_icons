import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Candy Icon - Candy wiggles
class CandyIcon extends AnimatedSVGIcon {
  const CandyIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Candy wiggles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Wiggle: sine wave
    final wiggle =
        math.sin(animationValue * math.pi * 2) * (15 * math.pi / 180);

    return CandyPainter(
      color: color,
      wiggle: wiggle,
      strokeWidth: strokeWidth,
    );
  }
}

class CandyPainter extends CustomPainter {
  final Color color;
  final double wiggle;
  final double strokeWidth;

  CandyPainter({
    required this.color,
    required this.wiggle,
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

    // Rotate around center (12, 12)
    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(wiggle);
    canvas.translate(-12 * scale, -12 * scale);

    // M10 7v10.9
    canvas.drawLine(
        Offset(10 * scale, 7 * scale), Offset(10 * scale, 17.9 * scale), paint);

    // M14 6.1V17
    canvas.drawLine(
        Offset(14 * scale, 6.1 * scale), Offset(14 * scale, 17 * scale), paint);

    // M16 7V3a1 1 0 0 1 1.707-.707 2.5 2.5 0 0 0 2.152.717 1 1 0 0 1 1.131 1.131 2.5 2.5 0 0 0 .717 2.152A1 1 0 0 1 21 8h-4
    final wrapper1 = Path();
    wrapper1.moveTo(16 * scale, 7 * scale);
    wrapper1.lineTo(16 * scale, 3 * scale);
    wrapper1.arcToPoint(Offset(17.707 * scale, 2.293 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.arcToPoint(Offset(19.859 * scale, 3.01 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper1.arcToPoint(Offset(20.99 * scale, 4.141 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.arcToPoint(Offset(21.707 * scale, 6.293 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper1.arcToPoint(Offset(21 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.lineTo(17 * scale, 8 * scale);
    canvas.drawPath(wrapper1, paint);

    // M16.536 7.465a5 5 0 0 0-7.072 0l-2 2a5 5 0 0 0 0 7.07 5 5 0 0 0 7.072 0l2-2a5 5 0 0 0 0-7.07
    final bodyPath = Path();
    bodyPath.moveTo(16.536 * scale, 7.465 * scale);
    bodyPath.arcToPoint(Offset(9.464 * scale, 7.465 * scale),
        radius: Radius.circular(5 * scale), clockwise: false);
    bodyPath.lineTo(7.464 * scale, 9.465 * scale);
    bodyPath.arcToPoint(Offset(7.464 * scale, 16.535 * scale),
        radius: Radius.circular(5 * scale), clockwise: false);
    bodyPath.arcToPoint(Offset(14.536 * scale, 16.535 * scale),
        radius: Radius.circular(5 * scale), clockwise: false);
    bodyPath.lineTo(16.536 * scale, 14.535 * scale);
    bodyPath.arcToPoint(Offset(16.536 * scale, 7.465 * scale),
        radius: Radius.circular(5 * scale), clockwise: false);
    canvas.drawPath(bodyPath, paint);

    // M8 17v4a1 1 0 0 1-1.707.707 2.5 2.5 0 0 0-2.152-.717 1 1 0 0 1-1.131-1.131 2.5 2.5 0 0 0-.717-2.152A1 1 0 0 1 3 16h4
    final wrapper2 = Path();
    wrapper2.moveTo(8 * scale, 17 * scale);
    wrapper2.lineTo(8 * scale, 21 * scale);
    wrapper2.arcToPoint(Offset(6.293 * scale, 21.707 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.arcToPoint(Offset(4.141 * scale, 20.99 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper2.arcToPoint(Offset(3.01 * scale, 19.859 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.arcToPoint(Offset(2.293 * scale, 17.707 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper2.arcToPoint(Offset(3 * scale, 16 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.lineTo(7 * scale, 16 * scale);
    canvas.drawPath(wrapper2, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CandyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.wiggle != wiggle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
