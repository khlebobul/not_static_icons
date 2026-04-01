import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Code XML Icon - Chevrons spread apart
class CodeXmlIcon extends AnimatedSVGIcon {
  const CodeXmlIcon({
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
    return CodeXmlPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CodeXmlPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CodeXmlPainter({
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

    // Right chevron: m18 16 4-4-4-4 (moved right)
    final rightPath = Path();
    rightPath.moveTo((18 + spread) * scale, 16 * scale);
    rightPath.lineTo((22 + spread) * scale, 12 * scale);
    rightPath.lineTo((18 + spread) * scale, 8 * scale);
    canvas.drawPath(rightPath, paint);

    // Left chevron: m6 8-4 4 4 4 (moved left)
    final leftPath = Path();
    leftPath.moveTo((6 - spread) * scale, 8 * scale);
    leftPath.lineTo((2 - spread) * scale, 12 * scale);
    leftPath.lineTo((6 - spread) * scale, 16 * scale);
    canvas.drawPath(leftPath, paint);

    // Diagonal slash: m14.5 4-5 16
    canvas.drawLine(
      Offset(14.5 * scale, 4 * scale),
      Offset(9.5 * scale, 20 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(CodeXmlPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
