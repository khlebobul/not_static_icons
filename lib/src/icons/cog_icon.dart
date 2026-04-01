import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cog Icon - Cog rotates
class CogIcon extends AnimatedSVGIcon {
  const CogIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Cog rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CogPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CogPainter({
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

    // Animation - full rotation
    final rotation = animationValue * math.pi * 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Outer circle: cx="12" cy="12" r="8"
    canvas.drawCircle(center, 8 * scale, paint);

    // Inner circle: cx="12" cy="12" r="2"
    canvas.drawCircle(center, 2 * scale, paint);

    // Spokes (lines from near inner to near outer circle)
    // M12 2v2 (top)
    canvas.drawLine(
      Offset(12 * scale, 2 * scale),
      Offset(12 * scale, 4 * scale),
      paint,
    );

    // M12 22v-2 (bottom - M12 22v-2 is equivalent)
    canvas.drawLine(
      Offset(12 * scale, 22 * scale),
      Offset(12 * scale, 20 * scale),
      paint,
    );

    // M2 12h2 (left - M2 12h2)
    canvas.drawLine(
      Offset(2 * scale, 12 * scale),
      Offset(4 * scale, 12 * scale),
      paint,
    );

    // M14 12h8 (right - but SVG says M14 12h8 which is 14 to 22)
    canvas.drawLine(
      Offset(14 * scale, 12 * scale),
      Offset(22 * scale, 12 * scale),
      paint,
    );

    // Diagonal spokes
    // M17 3.34-1 1.73 (top-right: from 17,3.34 to 16,5.07)
    canvas.drawLine(
      Offset(17 * scale, 3.34 * scale),
      Offset(16 * scale, 5.07 * scale),
      paint,
    );

    // M17 20.66-1-1.73 (bottom-right: from 17,20.66 to 16,18.93)
    canvas.drawLine(
      Offset(17 * scale, 20.66 * scale),
      Offset(16 * scale, 18.93 * scale),
      paint,
    );

    // M3.34 7 1.73 1 (top-left: from 3.34,7 to 5.07,8)
    canvas.drawLine(
      Offset(3.34 * scale, 7 * scale),
      Offset(5.07 * scale, 8 * scale),
      paint,
    );

    // M20.66 7-1.73 1 (top-right diagonal: from 20.66,7 to 18.93,8)
    canvas.drawLine(
      Offset(20.66 * scale, 7 * scale),
      Offset(18.93 * scale, 8 * scale),
      paint,
    );

    // M3.34 17 1.73-1 (bottom-left: from 3.34,17 to 5.07,16)
    canvas.drawLine(
      Offset(3.34 * scale, 17 * scale),
      Offset(5.07 * scale, 16 * scale),
      paint,
    );

    // M20.66 17-1.73-1 (bottom-right diagonal: from 20.66,17 to 18.93,16)
    canvas.drawLine(
      Offset(20.66 * scale, 17 * scale),
      Offset(18.93 * scale, 16 * scale),
      paint,
    );

    // M7 3.34 inner spoke: from 7,3.34 to...
    // SVG: M7 3.34 and M11 10.27 L7 3.34
    // Let me re-read: M11 10.27 L7 3.34 means line from 11,10.27 to 7,3.34
    canvas.drawLine(
      Offset(11 * scale, 10.27 * scale),
      Offset(7 * scale, 3.34 * scale),
      paint,
    );

    // M11 13.73-4 6.93 (from 11,13.73 to 7,20.66)
    canvas.drawLine(
      Offset(11 * scale, 13.73 * scale),
      Offset(7 * scale, 20.66 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
