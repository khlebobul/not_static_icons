import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Rain Wind Icon - Rain slants with wind
class CloudRainWindIcon extends AnimatedSVGIcon {
  const CloudRainWindIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Rain slants with wind";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudRainWindPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudRainWindPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudRainWindPainter({
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

    // Cloud: M4 14.899A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.242
    final cloudPath = Path();
    cloudPath.moveTo(4 * scale, 14.899 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(20 * scale, 16.242 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Rain with wind slant animation
    final windOffset = math.sin(animationValue * math.pi * 2) * 1.5;

    canvas.save();
    canvas.translate(windOffset * scale, 0);

    // m9.2 22 3-7
    canvas.drawLine(Offset(9.2 * scale, 22 * scale),
        Offset(12.2 * scale, 15 * scale), paint);

    canvas.restore();

    canvas.save();
    canvas.translate((windOffset * 0.7) * scale, 0);

    // m9 13-3 7
    canvas.drawLine(
        Offset(9 * scale, 13 * scale), Offset(6 * scale, 20 * scale), paint);

    canvas.restore();

    canvas.save();
    canvas.translate((windOffset * 0.85) * scale, 0);

    // m17 13-3 7
    canvas.drawLine(
        Offset(17 * scale, 13 * scale), Offset(14 * scale, 20 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudRainWindPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
