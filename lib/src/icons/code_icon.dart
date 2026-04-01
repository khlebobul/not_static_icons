import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Code Icon - Chevrons spread apart
class CodeIcon extends AnimatedSVGIcon {
  const CodeIcon({
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
  String get animationDescription => "Chevrons spread apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CodePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CodePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CodePainter({
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

    // Animation - chevrons spread apart horizontally
    final oscillation = 4 * animationValue * (1 - animationValue);
    final spread = oscillation * 2.0;

    // Right chevron: m16 18 6-6-6-6 (moved right)
    final rightPath = Path();
    rightPath.moveTo((16 + spread) * scale, 18 * scale);
    rightPath.lineTo((22 + spread) * scale, 12 * scale);
    rightPath.lineTo((16 + spread) * scale, 6 * scale);
    canvas.drawPath(rightPath, paint);

    // Left chevron: m8 6-6 6 6 6 (moved left)
    final leftPath = Path();
    leftPath.moveTo((8 - spread) * scale, 6 * scale);
    leftPath.lineTo((2 - spread) * scale, 12 * scale);
    leftPath.lineTo((8 - spread) * scale, 18 * scale);
    canvas.drawPath(leftPath, paint);
  }

  @override
  bool shouldRepaint(CodePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
