import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Bar Stacked Icon - Bars pulse with scale effect
class ChartBarStackedIcon extends AnimatedSVGIcon {
  const ChartBarStackedIcon({
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
  String get animationDescription => "Stacked bars pulse with scale effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartBarStackedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Bar Stacked icon
class ChartBarStackedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartBarStackedPainter({
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

    // Bottom bar: rect x="7" y="13" width="9" height="4" rx="1"
    final bottomBarWidth = 9.0 + oscillation * 2.0;
    final bottomBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(7 * scale, 13 * scale, bottomBarWidth * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(bottomBar, paint);

    // Top bar: rect x="7" y="5" width="12" height="4" rx="1"
    final topBarWidth = 12.0 - oscillation * 2.0;
    final topBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(7 * scale, 5 * scale, topBarWidth * scale, 4 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(topBar, paint);

    // Divider line in bottom bar: M11 13v4
    canvas.drawLine(
      Offset(11 * scale, 13 * scale),
      Offset(11 * scale, 17 * scale),
      paint,
    );

    // Divider line in top bar: M15 5v4
    canvas.drawLine(
      Offset(15 * scale, 5 * scale),
      Offset(15 * scale, 9 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartBarStackedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
