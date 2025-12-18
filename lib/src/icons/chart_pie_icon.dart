import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Pie Icon - Pie slice separates slightly
class ChartPieIcon extends AnimatedSVGIcon {
  const ChartPieIcon({
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
  String get animationDescription => "Pie slice separates slightly";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartPiePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Pie icon
class ChartPiePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartPiePainter({
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

    // Animation - slice moves out slightly
    final oscillation = 4 * animationValue * (1 - animationValue);
    final sliceOffset = oscillation * 1.0;
    
    // Offset direction for slice (diagonal: up-right)
    final dx = sliceOffset * 0.7;
    final dy = -sliceOffset * 0.7;

    // ========== PART 1: The pie slice (top-right quadrant) ==========
    // SVG: M21 12c.552 0 1.005-.449.95-.998a10 10 0 0 0-8.953-8.951c-.55-.055-.998.398-.998.95v8a1 1 0 0 0 1 1z
    // Simplified interpretation:
    // - Start at (21, 12) - right edge
    // - Arc counter-clockwise to (12, 3) - top edge  
    // - Line down to (12, 12) - center
    // - Line right back to (21, 12)
    
    final slicePath = Path();
    // Start at right edge of slice
    slicePath.moveTo((21 + dx) * scale, (12 + dy) * scale);
    // Arc to top (counter-clockwise, 90 degrees)
    slicePath.arcToPoint(
      Offset((12 + dx) * scale, (3 + dy) * scale),
      radius: Radius.circular(9 * scale),
      clockwise: false,
    );
    // Line down to center
    slicePath.lineTo((12 + dx) * scale, (12 + dy) * scale);
    // Line back to start (close the slice)
    slicePath.lineTo((21 + dx) * scale, (12 + dy) * scale);
    canvas.drawPath(slicePath, paint);

    // ========== PART 2: The main arc ==========
    // SVG: M21.21 15.89A10 10 0 1 1 8 2.83
    // This is a large arc from (21.21, 15.89) to (8, 2.83)
    // Flags: 1 1 = large-arc-flag=1, sweep-flag=1 (clockwise)
    
    final mainPath = Path();
    mainPath.moveTo(21.21 * scale, 15.89 * scale);
    mainPath.arcToPoint(
      Offset(8 * scale, 2.83 * scale),
      radius: Radius.circular(10 * scale),
      largeArc: true,
      clockwise: true,
    );
    canvas.drawPath(mainPath, paint);
  }

  @override
  bool shouldRepaint(ChartPiePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
