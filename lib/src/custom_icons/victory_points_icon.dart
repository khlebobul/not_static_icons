import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Victory Points Icon - Card with +1 pulses
class VictoryPointsIcon extends AnimatedSVGIcon {
  const VictoryPointsIcon({
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
  String get animationDescription => "Victory points card pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return VictoryPointsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class VictoryPointsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  VictoryPointsPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;
    final center = Offset(12 * scale, 12 * scale);

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Card outline (rounded rectangle)
    final cardPath = Path();

    // Start from top-left corner (after radius)
    cardPath.moveTo(5 * scale, 4 * scale);
    cardPath.lineTo(5 * scale, 20 * scale);
    // Bottom-left corner
    cardPath.quadraticBezierTo(5 * scale, 22 * scale, 7 * scale, 22 * scale);
    cardPath.lineTo(17 * scale, 22 * scale);
    // Bottom-right corner
    cardPath.quadraticBezierTo(19 * scale, 22 * scale, 19 * scale, 20 * scale);
    cardPath.lineTo(19 * scale, 4 * scale);
    // Top-right corner
    cardPath.quadraticBezierTo(19 * scale, 2 * scale, 17 * scale, 2 * scale);
    cardPath.lineTo(7 * scale, 2 * scale);
    // Top-left corner
    cardPath.quadraticBezierTo(5 * scale, 2 * scale, 5 * scale, 4 * scale);
    cardPath.close();

    canvas.drawPath(cardPath, strokePaint);

    // Draw "+1" text using paths
    // Plus sign (+)
    // Horizontal line of plus
    canvas.drawLine(
      Offset(8.5 * scale, 12 * scale),
      Offset(11.3 * scale, 12 * scale),
      strokePaint..strokeWidth = strokeWidth * 0.6,
    );
    // Vertical line of plus
    canvas.drawLine(
      Offset(9.9 * scale, 10.5 * scale),
      Offset(9.9 * scale, 13.5 * scale),
      strokePaint..strokeWidth = strokeWidth * 0.6,
    );

    // Number "1"
    final onePath = Path();
    onePath.moveTo(13.1 * scale, 10.4 * scale);
    onePath.lineTo(14.1 * scale, 10.1 * scale);
    onePath.lineTo(14.1 * scale, 13.3 * scale);
    onePath.moveTo(13 * scale, 13.3 * scale);
    onePath.lineTo(15.2 * scale, 13.3 * scale);

    canvas.drawPath(onePath, strokePaint..strokeWidth = strokeWidth * 0.6);

    // Reset stroke width
    strokePaint.strokeWidth = strokeWidth;

    canvas.restore();
  }

  @override
  bool shouldRepaint(VictoryPointsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
