import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevron Right Icon - Chevron moves right
class ChevronRightIcon extends AnimatedSVGIcon {
  const ChevronRightIcon({
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
  String get animationDescription => "Chevron moves right";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronRightPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronRightPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronRightPainter({
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

    // Path: m9 18 6-6-6-6
    final chevronPath = Path();
    chevronPath.moveTo((9 + moveOffset) * scale, 18 * scale);
    chevronPath.lineTo((15 + moveOffset) * scale, 12 * scale);
    chevronPath.lineTo((9 + moveOffset) * scale, 6 * scale);
    canvas.drawPath(chevronPath, paint);
  }

  @override
  bool shouldRepaint(ChevronRightPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
