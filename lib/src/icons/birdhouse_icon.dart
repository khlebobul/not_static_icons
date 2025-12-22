import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Birdhouse Icon - House sways slightly
class BirdhouseIcon extends AnimatedSVGIcon {
  const BirdhouseIcon({
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
  String get animationDescription => "Birdhouse sways slightly";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BirdhousePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Birdhouse icon
class BirdhousePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BirdhousePainter({
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

    // Animation - slight sway
    final oscillation = 4 * animationValue * (1 - animationValue);
    final sway = oscillation * 0.5;

    // ========== ROOF ==========
    // m3 8 7.82-5.615a2 2 0 0 1 2.36 0L21 8
    final roofPath = Path();
    roofPath.moveTo((3 - sway) * scale, 8 * scale);
    // Line to peak with bezier for the arc effect
    roofPath.lineTo((10.82 - sway * 0.5) * scale, 2.385 * scale);
    roofPath.arcToPoint(
      Offset((13.18 + sway * 0.5) * scale, 2.385 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    roofPath.lineTo((21 + sway) * scale, 8 * scale);
    canvas.drawPath(roofPath, paint);

    // ========== LEFT WALL ==========
    // M7 18 L5.044 6.532
    canvas.drawLine(
      Offset((7 - sway * 0.3) * scale, 18 * scale),
      Offset((5.044 - sway * 0.5) * scale, 6.532 * scale),
      paint,
    );

    // ========== RIGHT WALL ==========
    // m17 18 1.956-11.468
    canvas.drawLine(
      Offset((17 + sway * 0.3) * scale, 18 * scale),
      Offset((18.956 + sway * 0.5) * scale, 6.532 * scale),
      paint,
    );

    // ========== FLOOR ==========
    // M4 18h16
    canvas.drawLine(
      Offset(4 * scale, 18 * scale),
      Offset(20 * scale, 18 * scale),
      paint,
    );

    // ========== POLE ==========
    // M12 18v4
    canvas.drawLine(
      Offset(12 * scale, 18 * scale),
      Offset(12 * scale, 22 * scale),
      paint,
    );

    // ========== ENTRANCE HOLE ==========
    // circle cx="12" cy="10" r="2"
    canvas.drawCircle(
      Offset(12 * scale, 10 * scale),
      2 * scale,
      paint,
    );
  }

  @override
  bool shouldRepaint(BirdhousePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
