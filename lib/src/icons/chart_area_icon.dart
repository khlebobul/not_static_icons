import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Area Icon - Area pulses up and down
class ChartAreaIcon extends AnimatedSVGIcon {
  const ChartAreaIcon({
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
  String get animationDescription => "Chart area pulses up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartAreaPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Area icon
class ChartAreaPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartAreaPainter({
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
    // M3 3v16a2 2 0 0 0 2 2h16
    final axisPath = Path();
    axisPath.moveTo(3 * scale, 3 * scale);
    axisPath.lineTo(3 * scale, 19 * scale);
    axisPath.quadraticBezierTo(3 * scale, 21 * scale, 5 * scale, 21 * scale);
    axisPath.lineTo(21 * scale, 21 * scale);
    canvas.drawPath(axisPath, paint);

    // ========== ANIMATED PART - CHART AREA ==========
    // Oscillation for smooth bounce effect
    final oscillation = 4 * animationValue * (1 - animationValue);
    final lift = oscillation * 2.5;

    // Original SVG path:
    // M7 11.207a.5.5 0 0 1 .146-.353l2-2a.5.5 0 0 1 .708 0l3.292 3.292a.5.5 0 0 0 .708 0l4.292-4.292a.5.5 0 0 1 .854.353V16a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1z
    //
    // Key points:
    // Start: (7, 11.207)
    // Line to: (9, 9) - up-right (2-2 means +2x, -2y from ~7,11)
    // Line to: (13.292, 12.292) - down-right
    // Line to: (18, 8) - up-right
    // Line down to: (18, 16)
    // Line left with rounded corner to: (8, 16)
    // Back to start with rounded corner

    final areaPath = Path();

    // Starting point (top-left of area)
    areaPath.moveTo(7 * scale, (11 - lift) * scale);

    // Up to first peak (9, 9)
    areaPath.lineTo(9 * scale, (9 - lift) * scale);

    // Down to valley (13, 12)
    areaPath.lineTo(13 * scale, (12 - lift) * scale);

    // Up to second peak (18, 8)
    areaPath.lineTo(18 * scale, (8 - lift) * scale);

    // Down the right side to bottom-right corner (18, 16) with rounded corner
    areaPath.lineTo(18 * scale, 15 * scale);
    areaPath.quadraticBezierTo(18 * scale, 16 * scale, 17 * scale, 16 * scale);

    // Bottom line to left with rounded corner
    areaPath.lineTo(8 * scale, 16 * scale);
    areaPath.quadraticBezierTo(7 * scale, 16 * scale, 7 * scale, 15 * scale);

    // Close back to start
    areaPath.close();

    canvas.drawPath(areaPath, paint);
  }

  @override
  bool shouldRepaint(ChartAreaPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
