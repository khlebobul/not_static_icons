import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Lightning Icon - Lightning bolt flashes
class CloudLightningIcon extends AnimatedSVGIcon {
  const CloudLightningIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Lightning bolt flashes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudLightningPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudLightningPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudLightningPainter({
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

    // Cloud shake animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final shakeX = math.sin(animationValue * math.pi * 6) * oscillation * 1.0;

    canvas.save();
    canvas.translate(shakeX * scale, 0);

    // Cloud: M6 16.326A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 .5 8.973
    final cloudPath = Path();
    cloudPath.moveTo(6 * scale, 16.326 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(18 * scale, 16.973 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    canvas.restore();

    // Lightning: m13 12-3 5h4l-3 5 (always fully visible)
    final lightning = Path();
    lightning.moveTo(13 * scale, 12 * scale);
    lightning.lineTo(10 * scale, 17 * scale);
    lightning.lineTo(14 * scale, 17 * scale);
    lightning.lineTo(11 * scale, 22 * scale);
    canvas.drawPath(lightning, paint);
  }

  @override
  bool shouldRepaint(CloudLightningPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
