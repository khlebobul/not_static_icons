import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart No Axes Combined Icon - Line and bars animate together
class ChartNoAxesCombinedIcon extends AnimatedSVGIcon {
  const ChartNoAxesCombinedIcon({
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
  String get animationDescription => "Combined chart line and bars animate";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartNoAxesCombinedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart No Axes Combined icon
class ChartNoAxesCombinedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartNoAxesCombinedPainter({
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

    // ========== ANIMATED ==========
    final oscillation = 4 * animationValue * (1 - animationValue);
    final lift = oscillation * 2.0;

    // Line path: m22 3-8.646 8.646a.5.5 0 0 1-.708 0L9.354 8.354a.5.5 0 0 0-.707 0L2 15
    // Points: (22,3) -> (13.354,11.646) -> (9.354,8.354) -> (2,15)
    final linePath = Path();
    linePath.moveTo(22 * scale, (3 - lift) * scale);
    linePath.lineTo(13.354 * scale, (11.646 - lift) * scale);
    linePath.lineTo(9.354 * scale, (8.354 - lift) * scale);
    linePath.lineTo(2 * scale, (15 - lift) * scale);
    canvas.drawPath(linePath, paint);

    // Columns (from left to right)
    // M4 18v3 (4, 18 to 21)
    final col1Top = 18.0 - oscillation * 1.5;
    canvas.drawLine(
      Offset(4 * scale, 21 * scale),
      Offset(4 * scale, col1Top * scale),
      paint,
    );

    // M8 14v7 (8, 14 to 21)
    final col2Top = 14.0 - oscillation * 1.5;
    canvas.drawLine(
      Offset(8 * scale, 21 * scale),
      Offset(8 * scale, col2Top * scale),
      paint,
    );

    // M12 16v5 (12, 16 to 21)
    final col3Top = 16.0 - oscillation * 1.5;
    canvas.drawLine(
      Offset(12 * scale, 21 * scale),
      Offset(12 * scale, col3Top * scale),
      paint,
    );

    // M16 14v7 (16, 14 to 21)
    final col4Top = 14.0 - oscillation * 1.5;
    canvas.drawLine(
      Offset(16 * scale, 21 * scale),
      Offset(16 * scale, col4Top * scale),
      paint,
    );

    // M20 10v11 (20, 10 to 21)
    final col5Top = 10.0 - oscillation * 1.5;
    canvas.drawLine(
      Offset(20 * scale, 21 * scale),
      Offset(20 * scale, col5Top * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartNoAxesCombinedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
