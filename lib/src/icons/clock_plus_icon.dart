import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Plus Icon - Clock hands rotate with plus
class ClockPlusIcon extends AnimatedSVGIcon {
  const ClockPlusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Plus pulses and rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClockPlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockPlusPainter({
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

    // Partial circle: M21.92 13.267a10 10 0 1 0-8.653 8.653
    final circlePath = Path();
    circlePath.moveTo(21.92 * scale, 13.267 * scale);
    circlePath.arcToPoint(
      Offset(13.267 * scale, 21.92 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(circlePath, paint);

    // Clock hands: M12 6v6l3.644 1.822
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(Offset(12 * scale, 12 * scale),
        Offset(15.644 * scale, 13.822 * scale), paint);

    canvas.restore();

    // Plus with pulse and rotation animation
    final plusScale = 1.0 + oscillation * 0.25;
    final plusRotation = oscillation * math.pi / 4; // 45 degrees rotation

    canvas.save();
    canvas.translate(19 * scale, 19 * scale);
    canvas.scale(plusScale);
    canvas.rotate(plusRotation);
    canvas.translate(-19 * scale, -19 * scale);

    // Horizontal line: M16 19h6
    canvas.drawLine(
        Offset(16 * scale, 19 * scale), Offset(22 * scale, 19 * scale), paint);

    // Vertical line: M19 16v6
    canvas.drawLine(
        Offset(19 * scale, 16 * scale), Offset(19 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
