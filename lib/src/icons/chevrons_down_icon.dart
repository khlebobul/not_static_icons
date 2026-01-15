import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Down Icon - Both chevrons move down
class ChevronsDownIcon extends AnimatedSVGIcon {
  const ChevronsDownIcon({
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
  String get animationDescription => "Chevrons move down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsDownPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsDownPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsDownPainter({
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

    // Animation - bounce down
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Path 1: m7 6 5 5 5-5
    final chevron1 = Path();
    chevron1.moveTo(7 * scale, (6 + moveOffset) * scale);
    chevron1.lineTo(12 * scale, (11 + moveOffset) * scale);
    chevron1.lineTo(17 * scale, (6 + moveOffset) * scale);
    canvas.drawPath(chevron1, paint);

    // Path 2: m7 13 5 5 5-5
    final chevron2 = Path();
    chevron2.moveTo(7 * scale, (13 + moveOffset) * scale);
    chevron2.lineTo(12 * scale, (18 + moveOffset) * scale);
    chevron2.lineTo(17 * scale, (13 + moveOffset) * scale);
    canvas.drawPath(chevron2, paint);
  }

  @override
  bool shouldRepaint(ChevronsDownPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
