import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Bar Icon - Bars pulse with width change
class ChartBarIcon extends AnimatedSVGIcon {
  const ChartBarIcon({
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
  String get animationDescription => "Chart bars pulse with width change";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartBarPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Bar icon
class ChartBarPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartBarPainter({
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
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Top bar (shortest): M7 6h3
    final topBarWidth = 3.0 + oscillation * 1.5;
    canvas.drawLine(
      Offset(7 * scale, 6 * scale),
      Offset((7 + topBarWidth) * scale, 6 * scale),
      paint,
    );

    // Middle bar (longest): M7 11h12
    final middleBarWidth = 12.0 - oscillation * 2.0;
    canvas.drawLine(
      Offset(7 * scale, 11 * scale),
      Offset((7 + middleBarWidth) * scale, 11 * scale),
      paint,
    );

    // Bottom bar: M7 16h8
    final bottomBarWidth = 8.0 + oscillation * 1.5;
    canvas.drawLine(
      Offset(7 * scale, 16 * scale),
      Offset((7 + bottomBarWidth) * scale, 16 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartBarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
