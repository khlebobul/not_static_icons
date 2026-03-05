import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Arrow Down Icon - Clock hands rotate with arrow
class ClockArrowDownIcon extends AnimatedSVGIcon {
  const ClockArrowDownIcon({
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
  String get animationDescription => "Arrow moves down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClockArrowDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockArrowDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockArrowDownPainter({
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

    // Partial circle: M12.337 21.994a10 10 0 1 1 9.588-8.767
    final circlePath = Path();
    circlePath.moveTo(12.337 * scale, 21.994 * scale);
    circlePath.arcToPoint(
      Offset(21.925 * scale, 13.227 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
      largeArc: true,
    );
    canvas.drawPath(circlePath, paint);

    // Clock hands: M12 6v6l2 1
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(14 * scale, 13 * scale), paint);

    canvas.restore();

    // Arrow down with smooth down movement animation
    final arrowOffset = oscillation * 2.5;

    canvas.save();
    canvas.translate(0, arrowOffset * scale);

    // Vertical line
    canvas.drawLine(
        Offset(18 * scale, 14 * scale), Offset(18 * scale, 22 * scale), paint);

    // Arrow head: m14 18 4 4 4-4
    final arrowHead = Path();
    arrowHead.moveTo(14 * scale, 18 * scale);
    arrowHead.lineTo(18 * scale, 22 * scale);
    arrowHead.lineTo(22 * scale, 18 * scale);
    canvas.drawPath(arrowHead, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockArrowDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
