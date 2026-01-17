import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chevron First Icon - Chevron moves left
class ChevronFirstIcon extends AnimatedSVGIcon {
  const ChevronFirstIcon({
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
  String get animationDescription => "Chevron first moves left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChevronFirstPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ChevronFirstPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChevronFirstPainter({
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

    // Animation - bounce left
    final oscillation = 4 * animationValue * (1 - animationValue);
    final moveOffset = oscillation * 2.0;

    // Chevron: m17 18-6-6 6-6
    final chevronPath = Path();
    chevronPath.moveTo((17 - moveOffset) * scale, 18 * scale);
    chevronPath.lineTo((11 - moveOffset) * scale, 12 * scale);
    chevronPath.lineTo((17 - moveOffset) * scale, 6 * scale);
    canvas.drawPath(chevronPath, paint);

    // Line: M7 6v12
    final linePath = Path();
    linePath.moveTo(7 * scale, 6 * scale);
    linePath.lineTo(7 * scale, 18 * scale);
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(ChevronFirstPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
