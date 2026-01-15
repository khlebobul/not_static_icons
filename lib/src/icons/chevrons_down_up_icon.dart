import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Down Up Icon - Chevrons move toward each other
class ChevronsDownUpIcon extends AnimatedSVGIcon {
  const ChevronsDownUpIcon({
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
  String get animationDescription => "Chevrons move toward each other";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsDownUpPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsDownUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsDownUpPainter({
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

    // Animation - chevrons move toward center
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Bottom chevron (pointing up): m7 20 5-5 5 5 - moves up
    final chevronBottom = Path();
    chevronBottom.moveTo(7 * scale, (20 - moveOffset) * scale);
    chevronBottom.lineTo(12 * scale, (15 - moveOffset) * scale);
    chevronBottom.lineTo(17 * scale, (20 - moveOffset) * scale);
    canvas.drawPath(chevronBottom, paint);

    // Top chevron (pointing down): m7 4 5 5 5-5 - moves down
    final chevronTop = Path();
    chevronTop.moveTo(7 * scale, (4 + moveOffset) * scale);
    chevronTop.lineTo(12 * scale, (9 + moveOffset) * scale);
    chevronTop.lineTo(17 * scale, (4 + moveOffset) * scale);
    canvas.drawPath(chevronTop, paint);
  }

  @override
  bool shouldRepaint(ChevronsDownUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
