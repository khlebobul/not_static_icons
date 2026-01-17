import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Column Decreasing Icon - Columns shrink showing decreasing trend
class ChartColumnDecreasingIcon extends AnimatedSVGIcon {
  const ChartColumnDecreasingIcon({
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
  String get animationDescription =>
      "Chart columns animate with decreasing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartColumnDecreasingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Column Decreasing icon
class ChartColumnDecreasingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartColumnDecreasingPainter({
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
    // Decreasing order: tallest on left, shortest on right
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Left column (tallest): M8 17V5 (from 17 to 5, height 12)
    final col1Height = 12.0 - oscillation * 3.0;
    canvas.drawLine(
      Offset(8 * scale, 17 * scale),
      Offset(8 * scale, (17 - col1Height) * scale),
      paint,
    );

    // Middle column: M13 17V9 (from 17 to 9, height 8)
    final col2Height = 8.0 - oscillation * 2.0;
    canvas.drawLine(
      Offset(13 * scale, 17 * scale),
      Offset(13 * scale, (17 - col2Height) * scale),
      paint,
    );

    // Right column (shortest): M18 17v-3 (from 17 to 14, height 3)
    final col3Height = 3.0 - oscillation * 1.0;
    canvas.drawLine(
      Offset(18 * scale, 17 * scale),
      Offset(18 * scale, (17 - col3Height) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartColumnDecreasingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
