import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chart Network Icon - Nodes pulse/scale
class ChartNetworkIcon extends AnimatedSVGIcon {
  const ChartNetworkIcon({
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
  String get animationDescription => "Network nodes pulse and scale";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChartNetworkPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chart Network icon
class ChartNetworkPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChartNetworkPainter({
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

    // ========== ANIMATED PART ==========
    final oscillation = 4 * animationValue * (1 - animationValue);
    final nodeScale = 1.0 + oscillation * 0.3;

    // Connection lines (static)
    // m13.11 7.664 1.78 2.672 -> from ~(13,7.6) to ~(14.9,10.3)
    canvas.drawLine(
      Offset(13.11 * scale, 7.664 * scale),
      Offset(14.89 * scale, 10.336 * scale),
      paint,
    );

    // m14.162 12.788-3.324 1.424 -> from ~(14.2,12.8) to ~(10.8,14.2)
    canvas.drawLine(
      Offset(14.162 * scale, 12.788 * scale),
      Offset(10.838 * scale, 14.212 * scale),
      paint,
    );

    // m20 4-6.06 1.515 -> from (20,4) to ~(13.9,5.5)
    canvas.drawLine(
      Offset(20 * scale, 4 * scale),
      Offset(13.94 * scale, 5.515 * scale),
      paint,
    );

    // Circles (nodes) - animated with scale
    // Circle at (12, 6) r=2
    canvas.drawCircle(
      Offset(12 * scale, 6 * scale),
      2 * scale * nodeScale,
      paint,
    );

    // Circle at (16, 12) r=2
    canvas.drawCircle(
      Offset(16 * scale, 12 * scale),
      2 * scale * nodeScale,
      paint,
    );

    // Circle at (9, 15) r=2
    canvas.drawCircle(
      Offset(9 * scale, 15 * scale),
      2 * scale * nodeScale,
      paint,
    );
  }

  @override
  bool shouldRepaint(ChartNetworkPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
