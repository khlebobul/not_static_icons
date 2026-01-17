import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevrons Right Icon - Both chevrons move right
class ChevronsRightIcon extends AnimatedSVGIcon {
  const ChevronsRightIcon({
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
  String get animationDescription => "Chevrons move right";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronsRightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronsRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronsRightPainter({
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

    // Animation - bounce right
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Path 1: m6 17 5-5-5-5
    final chevron1 = Path();
    chevron1.moveTo((6 + moveOffset) * scale, 17 * scale);
    chevron1.lineTo((11 + moveOffset) * scale, 12 * scale);
    chevron1.lineTo((6 + moveOffset) * scale, 7 * scale);
    canvas.drawPath(chevron1, paint);

    // Path 2: m13 17 5-5-5-5
    final chevron2 = Path();
    chevron2.moveTo((13 + moveOffset) * scale, 17 * scale);
    chevron2.lineTo((18 + moveOffset) * scale, 12 * scale);
    chevron2.lineTo((13 + moveOffset) * scale, 7 * scale);
    canvas.drawPath(chevron2, paint);
  }

  @override
  bool shouldRepaint(ChevronsRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
