import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Left Right Icon - Chevrons move apart
class ChevronsLeftRightIcon extends AnimatedSVGIcon {
  const ChevronsLeftRightIcon({
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
  String get animationDescription => "Chevrons move apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsLeftRightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsLeftRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsLeftRightPainter({
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

    // Left chevron: m9 7-5 5 5 5 - moves left
    final chevronLeft = Path();
    chevronLeft.moveTo((9 - moveOffset) * scale, 7 * scale);
    chevronLeft.lineTo((4 - moveOffset) * scale, 12 * scale);
    chevronLeft.lineTo((9 - moveOffset) * scale, 17 * scale);
    canvas.drawPath(chevronLeft, paint);

    // Right chevron: m15 7 5 5-5 5 - moves right
    final chevronRight = Path();
    chevronRight.moveTo((15 + moveOffset) * scale, 7 * scale);
    chevronRight.lineTo((20 + moveOffset) * scale, 12 * scale);
    chevronRight.lineTo((15 + moveOffset) * scale, 17 * scale);
    canvas.drawPath(chevronRight, paint);
  }

  @override
  bool shouldRepaint(ChevronsLeftRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
