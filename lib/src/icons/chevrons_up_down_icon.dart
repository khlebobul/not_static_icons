import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Up Down Icon - Chevrons move apart vertically
class ChevronsUpDownIcon extends AnimatedSVGIcon {
  const ChevronsUpDownIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Chevrons move apart vertically";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsUpDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsUpDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsUpDownPainter({
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

    // Animation - chevrons move apart
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Bottom chevron (pointing down): m7 15 5 5 5-5 - moves down
    final chevronBottom = Path();
    chevronBottom.moveTo(7 * scale, (15 + moveOffset) * scale);
    chevronBottom.lineTo(12 * scale, (20 + moveOffset) * scale);
    chevronBottom.lineTo(17 * scale, (15 + moveOffset) * scale);
    canvas.drawPath(chevronBottom, paint);

    // Top chevron (pointing up): m7 9 5-5 5 5 - moves up
    final chevronTop = Path();
    chevronTop.moveTo(7 * scale, (9 - moveOffset) * scale);
    chevronTop.lineTo(12 * scale, (4 - moveOffset) * scale);
    chevronTop.lineTo(17 * scale, (9 - moveOffset) * scale);
    canvas.drawPath(chevronTop, paint);
  }

  @override
  bool shouldRepaint(ChevronsUpDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
