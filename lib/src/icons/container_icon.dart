import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Container Icon - Container wobbles
class ContainerIcon extends AnimatedSVGIcon {
  const ContainerIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Container wobbles";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ContainerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ContainerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ContainerPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - wobble
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rotation = math.sin(oscillation * math.pi) * 0.08;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Main container shape
    // Outer path
    final outerPath = Path();
    outerPath.moveTo(22 * scale, 7.7 * scale);
    // Right side going down
    outerPath.lineTo(22 * scale, 14.3 * scale);
    // This is simplified - draw the main hexagonal container shape
    // Top edge
    outerPath.moveTo(12 * scale, 2.3 * scale);
    outerPath.lineTo(22 * scale, 7.7 * scale);
    outerPath.lineTo(22 * scale, 15.8 * scale);
    outerPath.lineTo(12 * scale, 21.7 * scale);
    outerPath.lineTo(2 * scale, 15.8 * scale);
    outerPath.lineTo(2 * scale, 7.7 * scale);
    outerPath.close();
    canvas.drawPath(outerPath, paint);

    // Inner lines
    // M10 21.9V14L2.1 9.1
    canvas.drawLine(
      Offset(10 * scale, 21.9 * scale),
      Offset(10 * scale, 14 * scale),
      paint,
    );
    canvas.drawLine(
      Offset(10 * scale, 14 * scale),
      Offset(2.1 * scale, 9.1 * scale),
      paint,
    );

    // m10 14 11.9-6.9
    canvas.drawLine(
      Offset(10 * scale, 14 * scale),
      Offset(21.9 * scale, 7.1 * scale),
      paint,
    );

    // M14 19.8v-8.1
    canvas.drawLine(
      Offset(14 * scale, 19.8 * scale),
      Offset(14 * scale, 11.7 * scale),
      paint,
    );

    // M18 17.5V9.4
    canvas.drawLine(
      Offset(18 * scale, 17.5 * scale),
      Offset(18 * scale, 9.4 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ContainerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
