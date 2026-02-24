import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Citrus Icon - Citrus slice rotates
class CitrusIcon extends AnimatedSVGIcon {
  const CitrusIcon({
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
  String get animationDescription => "Citrus slice rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CitrusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CitrusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CitrusPainter({
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
    final center = Offset(13 * scale, 10 * scale);

    // Animation - citrus rotates
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotationAngle = oscillation * 0.2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);
    canvas.translate(-center.dx, -center.dy);

    // Outer slice: M21.66 17.67a1.08 1.08 0 0 1-.04 1.6A12 12 0 0 1 4.73 2.38a1.1 1.1 0 0 1 1.61-.04z
    // This is a wedge shape from top-right to bottom-left
    final outerPath = Path();
    outerPath.moveTo(21.66 * scale, 17.67 * scale);
    
    // Small arc at corner: a1.08 1.08 0 0 1-.04 1.6
    outerPath.arcToPoint(
      Offset(21.62 * scale, 19.27 * scale),
      radius: Radius.circular(1.08 * scale),
      clockwise: true,
      largeArc: false,
    );
    
    // Large arc (the curved edge): A12 12 0 0 1 4.73 2.38
    outerPath.arcToPoint(
      Offset(4.73 * scale, 2.38 * scale),
      radius: Radius.circular(12 * scale),
      clockwise: true,
      largeArc: false,
    );
    
    // Small arc at other corner: a1.1 1.1 0 0 1 1.61-.04
    outerPath.arcToPoint(
      Offset(6.34 * scale, 2.34 * scale),
      radius: Radius.circular(1.1 * scale),
      clockwise: true,
      largeArc: false,
    );
    
    // z - close path
    outerPath.close();
    canvas.drawPath(outerPath, paint);

    // Inner arc: M19.65 15.66A8 8 0 0 1 8.35 4.34
    // This is a smaller arc parallel to the outer edge
    final innerArc = Path();
    innerArc.moveTo(19.65 * scale, 15.66 * scale);
    innerArc.arcToPoint(
      Offset(8.35 * scale, 4.34 * scale),
      radius: Radius.circular(8 * scale),
      clockwise: true,
      largeArc: false,
    );
    canvas.drawPath(innerArc, paint);

    // Diagonal line (segment divider): m14 10-5.5 5.5
    canvas.drawLine(
      Offset(14 * scale, 10 * scale),
      Offset(8.5 * scale, 15.5 * scale),
      paint,
    );

    // Bottom segment lines: M14 17.85V10H6.15
    // Vertical line from (14, 17.85) to (14, 10)
    canvas.drawLine(
      Offset(14 * scale, 17.85 * scale),
      Offset(14 * scale, 10 * scale),
      paint,
    );
    
    // Horizontal line from (14, 10) to (6.15, 10)
    canvas.drawLine(
      Offset(14 * scale, 10 * scale),
      Offset(6.15 * scale, 10 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CitrusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
