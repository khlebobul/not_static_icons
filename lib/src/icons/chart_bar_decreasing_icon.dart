import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Bar Decreasing Icon - Bars animate with shrinking effect
class ChartBarDecreasingIcon extends AnimatedSVGIcon {
  const ChartBarDecreasingIcon({
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
      "Chart bars animate with decreasing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartBarDecreasingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Bar Decreasing icon
class ChartBarDecreasingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartBarDecreasingPainter({
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

    // ========== ANIMATED PART - BARS ==========
    // Oscillating animation - bars shrink and return
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Top bar (longest): M7 6h12 - shrinks most
    final topBarWidth = 12.0 - oscillation * 3.0;
    canvas.drawLine(
      Offset(7 * scale, 6 * scale),
      Offset((7 + topBarWidth) * scale, 6 * scale),
      paint,
    );

    // Middle bar: M7 11h8 - shrinks medium
    final middleBarWidth = 8.0 - oscillation * 2.0;
    canvas.drawLine(
      Offset(7 * scale, 11 * scale),
      Offset((7 + middleBarWidth) * scale, 11 * scale),
      paint,
    );

    // Bottom bar (shortest): M7 16h3 - shrinks least
    final bottomBarWidth = 3.0 - oscillation * 1.0;
    canvas.drawLine(
      Offset(7 * scale, 16 * scale),
      Offset((7 + bottomBarWidth) * scale, 16 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartBarDecreasingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
