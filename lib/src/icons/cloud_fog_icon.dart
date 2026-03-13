import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Fog Icon - Fog lines wave
class CloudFogIcon extends AnimatedSVGIcon {
  const CloudFogIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Fog lines wave";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudFogPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudFogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudFogPainter({
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

    // Cloud
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

    // Fog lines with wave animation
    final waveOffset = math.sin(animationValue * math.pi * 2) * 1.0;

    canvas.save();
    canvas.translate(waveOffset * scale, 0);

    // M16 17H7
    canvas.drawLine(
        Offset(7 * scale, 17 * scale), Offset(16 * scale, 17 * scale), paint);

    canvas.restore();

    canvas.save();
    canvas.translate(-waveOffset * scale, 0);

    // M17 21H9
    canvas.drawLine(
        Offset(9 * scale, 21 * scale), Offset(17 * scale, 21 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudFogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
