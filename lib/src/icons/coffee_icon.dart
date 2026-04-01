import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Coffee Icon - Steam rises from cup
class CoffeeIcon extends AnimatedSVGIcon {
  const CoffeeIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Steam rises from cup";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CoffeePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CoffeePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CoffeePainter({
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

    // Animation - steam rises and fades
    final oscillation = 4 * animationValue * (1 - animationValue);
    final steamRise = oscillation * 2.0;
    final steamOpacity = 1.0 - oscillation * 0.5;

    final steamPaint = Paint()
      ..color = color.withValues(alpha: steamOpacity)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Steam lines (animated)
    // Left steam: M6 2v2
    canvas.drawLine(
      Offset(6 * scale, (2 - steamRise) * scale),
      Offset(6 * scale, (4 - steamRise) * scale),
      steamPaint,
    );

    // Middle steam: M10 2v2
    canvas.drawLine(
      Offset(10 * scale, (2 - steamRise) * scale),
      Offset(10 * scale, (4 - steamRise) * scale),
      steamPaint,
    );

    // Right steam: M14 2v2
    canvas.drawLine(
      Offset(14 * scale, (2 - steamRise) * scale),
      Offset(14 * scale, (4 - steamRise) * scale),
      steamPaint,
    );

    // Cup body: M16 8a1 1 0 0 1 1 1v8a4 4 0 0 1-4 4H7a4 4 0 0 1-4-4V9a1 1 0 0 1 1-1h14
    final cupPath = Path();
    // Start at top-left of cup
    cupPath.moveTo(4 * scale, 8 * scale);

    // Top edge to right
    cupPath.lineTo(16 * scale, 8 * scale);

    // Small arc at top-right corner (a1 1 0 0 1 1 1)
    cupPath.arcToPoint(
      Offset(17 * scale, 9 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    // Right side down (v8)
    cupPath.lineTo(17 * scale, 17 * scale);

    // Bottom-right arc (a4 4 0 0 1-4 4)
    cupPath.arcToPoint(
      Offset(13 * scale, 21 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    // Bottom edge to left (H7)
    cupPath.lineTo(7 * scale, 21 * scale);

    // Bottom-left arc (a4 4 0 0 1-4-4)
    cupPath.arcToPoint(
      Offset(3 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );

    // Left side up (V9)
    cupPath.lineTo(3 * scale, 9 * scale);

    // Small arc at top-left corner (a1 1 0 0 1 1-1)
    cupPath.arcToPoint(
      Offset(4 * scale, 8 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );

    canvas.drawPath(cupPath, paint);

    // Handle: the continuation ...a4 4 0 1 1 0 8h-1
    // Handle is a semicircle on the right side
    final handlePath = Path();
    handlePath.moveTo(17 * scale, 8 * scale);

    // Line to where the handle starts on right
    handlePath.moveTo(18 * scale, 9 * scale);

    // Handle arc (a4 4 0 1 1 0 8)
    handlePath.arcToPoint(
      Offset(18 * scale, 17 * scale),
      radius: Radius.circular(4 * scale),
      largeArc: true,
      clockwise: true,
    );

    // h-1
    handlePath.lineTo(17 * scale, 17 * scale);

    canvas.drawPath(handlePath, paint);
  }

  @override
  bool shouldRepaint(CoffeePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
