import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevron Up Icon - Chevron moves up
class ChevronUpIcon extends AnimatedSVGIcon {
  const ChevronUpIcon({
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
  String get animationDescription => "Chevron moves up";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronUpPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronUpPainter({
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

    // Animation - bounce up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * -2.0;

    // Path: m18 15-6-6-6 6
    final chevronPath = Path();
    chevronPath.moveTo(18 * scale, (15 + moveOffset) * scale);
    chevronPath.lineTo(12 * scale, (9 + moveOffset) * scale);
    chevronPath.lineTo(6 * scale, (15 + moveOffset) * scale);
    canvas.drawPath(chevronPath, paint);
  }

  @override
  bool shouldRepaint(ChevronUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
