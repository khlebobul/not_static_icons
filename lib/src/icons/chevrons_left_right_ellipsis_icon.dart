import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Left Right Ellipsis Icon - Chevrons move apart
class ChevronsLeftRightEllipsisIcon extends AnimatedSVGIcon {
  const ChevronsLeftRightEllipsisIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Chevrons move apart with ellipsis";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsLeftRightEllipsisPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsLeftRightEllipsisPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsLeftRightEllipsisPainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;

    // Animation - chevrons move apart
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Left chevron: m7 7-5 5 5 5 - moves left
    final chevronLeft = Path();
    chevronLeft.moveTo((7 - moveOffset) * scale, 7 * scale);
    chevronLeft.lineTo((2 - moveOffset) * scale, 12 * scale);
    chevronLeft.lineTo((7 - moveOffset) * scale, 17 * scale);
    canvas.drawPath(chevronLeft, paint);

    // Right chevron: m17 7 5 5-5 5 - moves right
    final chevronRight = Path();
    chevronRight.moveTo((17 + moveOffset) * scale, 7 * scale);
    chevronRight.lineTo((22 + moveOffset) * scale, 12 * scale);
    chevronRight.lineTo((17 + moveOffset) * scale, 17 * scale);
    canvas.drawPath(chevronRight, paint);

    // Dots (ellipsis) - static
    final dotRadius = 0.5 * scale;
    canvas.drawCircle(Offset(8 * scale, 12 * scale), dotRadius, fillPaint);
    canvas.drawCircle(Offset(12 * scale, 12 * scale), dotRadius, fillPaint);
    canvas.drawCircle(Offset(16 * scale, 12 * scale), dotRadius, fillPaint);
  }

  @override
  bool shouldRepaint(ChevronsLeftRightEllipsisPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
