import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Rain Icon - Rain drops fall
class CloudRainIcon extends AnimatedSVGIcon {
  const CloudRainIcon({
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
  String get animationDescription => "Rain drops fall";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudRainPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudRainPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudRainPainter({
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
      largeArc: false,
    );
    canvas.drawPath(cloudPath, paint);

    // Rain drops with falling animation
    final dropOffset = math.sin(animationValue * math.pi * 2) * 2.0;

    canvas.save();
    canvas.translate(0, dropOffset * scale);

    // Rain lines: M16 14v6, M8 14v6, M12 16v6
    canvas.drawLine(
        Offset(16 * scale, 14 * scale), Offset(16 * scale, 20 * scale), paint);
    canvas.drawLine(
        Offset(8 * scale, 14 * scale), Offset(8 * scale, 20 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 16 * scale), Offset(12 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudRainPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
