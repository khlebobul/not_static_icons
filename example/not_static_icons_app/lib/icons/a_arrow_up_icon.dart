import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated A Arrow Up Icon - Arrow moves up and down
class AArrowUpIcon extends AnimatedSVGIcon {
  const AArrowUpIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription =>
      "Arrow moves up and returns to original position";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Create oscillating motion: goes from 0 to max and back to 0
    final oscillation = 4 * animationValue * (1 - animationValue);
    return AArrowUpPainter(
      color: color,
      arrowOffset: oscillation * 3,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for A Arrow Up icon
class AArrowUpPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;
  final double strokeWidth;

  AArrowUpPainter({
    required this.color,
    required this.arrowOffset,
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

    Offset scalePoint(double x, double y) {
      return Offset(x * scale, y * scale);
    }

    Offset scalePointWithArrowOffset(double x, double y) {
      return Offset(x * scale, (y - arrowOffset) * scale);
    }

    // ========== STATIC PART - LETTER "A" ==========

    // Horizontal line of A (M3.5 13h6)
    canvas.drawLine(scalePoint(3.5, 13), scalePoint(9.5, 13), paint);

    // Left side of A (m2 16 4.5-9)
    canvas.drawLine(scalePoint(2, 16), scalePoint(6.5, 7), paint);

    // Right side of A (4.5 9 from the previous end point)
    canvas.drawLine(scalePoint(6.5, 7), scalePoint(11, 16), paint);

    // ========== ANIMATED PART - ARROW ==========

    // Vertical line of arrow (M18 16V7) - animated
    canvas.drawLine(
      scalePointWithArrowOffset(18, 16),
      scalePointWithArrowOffset(18, 7),
      paint,
    );

    // Left arrow line (m14 11 4-4) - animated
    canvas.drawLine(
      scalePointWithArrowOffset(14, 11),
      scalePointWithArrowOffset(18, 7),
      paint,
    );

    // Right arrow line (4 4 from the arrow tip) - animated
    canvas.drawLine(
      scalePointWithArrowOffset(18, 7),
      scalePointWithArrowOffset(22, 11),
      paint,
    );
  }

  @override
  bool shouldRepaint(AArrowUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.arrowOffset != arrowOffset ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
