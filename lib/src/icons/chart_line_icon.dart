import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Line Icon - Line pulses up and down
class ChartLineIcon extends AnimatedSVGIcon {
  const ChartLineIcon({
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
  String get animationDescription => "Chart line pulses up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartLinePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Line icon
class ChartLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartLinePainter({
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

    // ========== ANIMATED PART - LINE ==========
    // m19 9-5 5-4-4-3 3
    // Points: (19,9) -> (14,14) -> (10,10) -> (7,13)
    final oscillation = 4 * animationValue * (1 - animationValue);
    final lift = oscillation * 2.0;

    final linePath = Path();
    linePath.moveTo(19 * scale, (9 - lift) * scale);
    linePath.lineTo(14 * scale, (14 - lift) * scale);
    linePath.lineTo(10 * scale, (10 - lift) * scale);
    linePath.lineTo(7 * scale, (13 - lift) * scale);

    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(ChartLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
