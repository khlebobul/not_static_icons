import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Column Increasing Icon - Columns grow showing increasing trend
class ChartColumnIncreasingIcon extends AnimatedSVGIcon {
  const ChartColumnIncreasingIcon({
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
  String get animationDescription => "Chart columns animate with increasing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartColumnIncreasingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Column Increasing icon
class ChartColumnIncreasingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartColumnIncreasingPainter({
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

    // ========== STATIC PART - AXES ==========
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - COLUMNS ==========
    // Increasing order: shortest on left, tallest on right
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Left column (shortest): M8 17v-3 (from 17 to 14, height 3)
    final col1Height = 3.0 + oscillation * 1.0;
    canvas.drawLine(
      Offset(8 * scale, 17 * scale),
      Offset(8 * scale, (17 - col1Height) * scale),
      paint,
    );

    // Middle column: M13 17V9 (from 17 to 9, height 8)
    final col2Height = 8.0 + oscillation * 2.0;
    canvas.drawLine(
      Offset(13 * scale, 17 * scale),
      Offset(13 * scale, (17 - col2Height) * scale),
      paint,
    );

    // Right column (tallest): M18 17V5 (from 17 to 5, height 12)
    final col3Height = 12.0 + oscillation * 3.0;
    canvas.drawLine(
      Offset(18 * scale, 17 * scale),
      Offset(18 * scale, (17 - col3Height) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartColumnIncreasingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
