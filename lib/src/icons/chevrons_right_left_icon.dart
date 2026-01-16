import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Right Left Icon - Chevrons move toward each other
class ChevronsRightLeftIcon extends AnimatedSVGIcon {
  const ChevronsRightLeftIcon({
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
    return ChevronsRightLeftPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsRightLeftPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsRightLeftPainter({
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

    // Right chevron (pointing left): m20 17-5-5 5-5 - moves left
    final chevronRight = Path();
    chevronRight.moveTo((20 - moveOffset) * scale, 17 * scale);
    chevronRight.lineTo((15 - moveOffset) * scale, 12 * scale);
    chevronRight.lineTo((20 - moveOffset) * scale, 7 * scale);
    canvas.drawPath(chevronRight, paint);

    // Left chevron (pointing right): m4 17 5-5-5-5 - moves right
    final chevronLeft = Path();
    chevronLeft.moveTo((4 + moveOffset) * scale, 17 * scale);
    chevronLeft.lineTo((9 + moveOffset) * scale, 12 * scale);
    chevronLeft.lineTo((4 + moveOffset) * scale, 7 * scale);
    canvas.drawPath(chevronLeft, paint);
  }

  @override
  bool shouldRepaint(ChevronsRightLeftPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
