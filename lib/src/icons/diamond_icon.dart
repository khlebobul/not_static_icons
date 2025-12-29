import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Diamond Icon - Rotates slightly
class DiamondIcon extends AnimatedSVGIcon {
  const DiamondIcon({
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
  String get animationDescription => "Diamond rotates slightly";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return DiamondPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Diamond icon
class DiamondPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  DiamondPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - slight rotation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = oscillation * 0.15;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Diamond shape - rotated square with rounded corners
    // SVG: M2.7 10.3a2.41 2.41 0 0 0 0 3.41l7.59 7.59a2.41 2.41 0 0 0 3.41 0l7.59-7.59a2.41 2.41 0 0 0 0-3.41l-7.59-7.59a2.41 2.41 0 0 0-3.41 0Z
    final diamondPath = Path();
    diamondPath.moveTo(2.7 * scale, 10.3 * scale);
    // Bottom-left arc
    diamondPath.arcToPoint(
      Offset(2.7 * scale, 13.71 * scale),
      radius: Radius.circular(2.41 * scale),
      clockwise: false,
    );
    // Line to bottom
    diamondPath.lineTo(10.29 * scale, 21.3 * scale);
    // Bottom arc
    diamondPath.arcToPoint(
      Offset(13.7 * scale, 21.3 * scale),
      radius: Radius.circular(2.41 * scale),
      clockwise: false,
    );
    // Line to right
    diamondPath.lineTo(21.29 * scale, 13.71 * scale);
    // Right arc
    diamondPath.arcToPoint(
      Offset(21.29 * scale, 10.3 * scale),
      radius: Radius.circular(2.41 * scale),
      clockwise: false,
    );
    // Line to top
    diamondPath.lineTo(13.7 * scale, 2.71 * scale);
    // Top arc
    diamondPath.arcToPoint(
      Offset(10.29 * scale, 2.71 * scale),
      radius: Radius.circular(2.41 * scale),
      clockwise: false,
    );
    // Close path
    diamondPath.close();
    canvas.drawPath(diamondPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(DiamondPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
