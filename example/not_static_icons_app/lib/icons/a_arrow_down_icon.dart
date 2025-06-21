import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated A Arrow Down Icon - Arrow moves up and down
class AArrowDownIcon extends AnimatedSVGIcon {
  const AArrowDownIcon({
    super.key,
    super.size = 100.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  String get animationDescription => "Arrow moves up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AArrowDownPainter(
      color: color,
      arrowOffset: animationValue * 1.5, // Reduced from 4.0 to 1.5 pixels
    );
  }
}

/// Painter for A Arrow Down icon
class AArrowDownPainter extends CustomPainter {
  final Color color;
  final double arrowOffset;

  AArrowDownPainter({required this.color, required this.arrowOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    Offset scalePoint(double x, double y) {
      return Offset(x * scale, y * scale);
    }

    Offset scalePointWithArrowOffset(double x, double y) {
      return Offset(x * scale, (y + arrowOffset) * scale);
    }

    // ========== STATIC PART - LETTER "A" ==========

    // Horizontal line of A
    canvas.drawLine(scalePoint(3.5, 13), scalePoint(9.5, 13), paint);

    // Left side of A
    canvas.drawLine(scalePoint(2, 16), scalePoint(6.5, 7), paint);

    // Right side of A
    canvas.drawLine(scalePoint(6.5, 7), scalePoint(11, 16), paint);

    // ========== ANIMATED PART - ARROW ==========

    // Vertical line of arrow - animated
    canvas.drawLine(
      scalePointWithArrowOffset(18, 7),
      scalePointWithArrowOffset(18, 16),
      paint,
    );

    // Left arrow line - animated
    canvas.drawLine(
      scalePointWithArrowOffset(14, 12),
      scalePointWithArrowOffset(18, 16),
      paint,
    );

    // Right arrow line - animated
    canvas.drawLine(
      scalePointWithArrowOffset(18, 16),
      scalePointWithArrowOffset(22, 12),
      paint,
    );
  }

  @override
  bool shouldRepaint(AArrowDownPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.arrowOffset != arrowOffset;
  }
}
