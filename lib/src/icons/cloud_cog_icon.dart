import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Cog Icon - Cog rotates
class CloudCogIcon extends AnimatedSVGIcon {
  const CloudCogIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 2000),
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
    return CloudCogPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudCogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudCogPainter({
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

    // Cloud: M4.2 15.1a7 7 0 1 1 9.93-9.858A7 7 0 0 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.2
    final cloudPath = Path();
    cloudPath.moveTo(4.2 * scale, 15.1 * scale);
    // a7 7 0 1 1 9.93-9.858
    cloudPath.arcToPoint(
      Offset(14.13 * scale, 5.242 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    // A7 7 0 0 1 15.71 8
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
    );
    // h1.79
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    // a4.5 4.5 0 0 1 2.5 8.2
    cloudPath.arcToPoint(
      Offset(20 * scale, 16.2 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Cog with rotation animation
    final rotation = animationValue * math.pi * 2;

    canvas.save();
    canvas.translate(12 * scale, 17 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -17 * scale);

    // Cog body: two semicircles with tooth extensions
    // Path 3: M13.148 19.772a3 3 0 1 0-2.296-5.544l-.383-.923
    final cogPath1 = Path();
    cogPath1.moveTo(13.148 * scale, 19.772 * scale);
    cogPath1.arcToPoint(
      Offset(10.852 * scale, 14.228 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
      largeArc: true,
    );
    cogPath1.lineTo(10.469 * scale, 13.305 * scale);
    canvas.drawPath(cogPath1, paint);

    // Path 4: m13.53 20.696-.382-.924a3 3 0 1 1-2.296-5.544
    final cogPath2 = Path();
    cogPath2.moveTo(13.53 * scale, 20.696 * scale);
    cogPath2.lineTo(13.148 * scale, 19.772 * scale);
    cogPath2.arcToPoint(
      Offset(10.852 * scale, 14.228 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
      largeArc: true,
    );
    canvas.drawPath(cogPath2, paint);

    // Cog teeth lines (6 outer teeth)
    canvas.drawLine(Offset(10.852 * scale, 19.772 * scale),
        Offset(10.469 * scale, 20.696 * scale), paint);
    canvas.drawLine(Offset(13.148 * scale, 14.228 * scale),
        Offset(13.531 * scale, 13.305 * scale), paint);
    canvas.drawLine(Offset(14.772 * scale, 15.852 * scale),
        Offset(15.695 * scale, 15.469 * scale), paint);
    canvas.drawLine(Offset(14.772 * scale, 18.148 * scale),
        Offset(15.695 * scale, 18.531 * scale), paint);
    canvas.drawLine(Offset(9.228 * scale, 15.852 * scale),
        Offset(8.305 * scale, 15.469 * scale), paint);
    canvas.drawLine(Offset(9.228 * scale, 18.148 * scale),
        Offset(8.305 * scale, 18.531 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudCogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
