import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Columns 3 Cog Icon - Cog rotates
class Columns3CogIcon extends AnimatedSVGIcon {
  const Columns3CogIcon({
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
    return Columns3CogPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Columns3CogPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Columns3CogPainter({
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

    // Static part - table frame
    // M10.5 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v5.5
    final framePath = Path();
    framePath.moveTo(10.5 * scale, 21 * scale);
    framePath.lineTo(5 * scale, 21 * scale);
    framePath.arcToPoint(
      Offset(3 * scale, 19 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(3 * scale, 5 * scale);
    framePath.arcToPoint(
      Offset(5 * scale, 3 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(19 * scale, 3 * scale);
    framePath.arcToPoint(
      Offset(21 * scale, 5 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(21 * scale, 10.5 * scale);
    canvas.drawPath(framePath, paint);

    // Left divider: M9 3v18
    canvas.drawLine(
      Offset(9 * scale, 3 * scale),
      Offset(9 * scale, 21 * scale),
      paint,
    );

    // Right divider (partial): M15 3v7.5
    canvas.drawLine(
      Offset(15 * scale, 3 * scale),
      Offset(15 * scale, 10.5 * scale),
      paint,
    );

    // Animated cog part
    final cogCenter = Offset(18 * scale, 18 * scale);
    final rotation = animationValue * math.pi * 2;

    canvas.save();
    canvas.translate(cogCenter.dx, cogCenter.dy);
    canvas.rotate(rotation);
    canvas.translate(-cogCenter.dx, -cogCenter.dy);

    // Cog circle: cx="18" cy="18" r="3"
    canvas.drawCircle(cogCenter, 3 * scale, paint);

    // Cog spokes (the path lines around the cog)
    // M14.3 19.6 l1 -0.4
    canvas.drawLine(
      Offset(14.3 * scale, 19.6 * scale),
      Offset(15.3 * scale, 19.2 * scale),
      paint,
    );
    // M15.2 16.9 l-0.9 -0.3
    canvas.drawLine(
      Offset(15.2 * scale, 16.9 * scale),
      Offset(14.3 * scale, 16.6 * scale),
      paint,
    );
    // M16.6 21.7 l0.3 -0.9
    canvas.drawLine(
      Offset(16.6 * scale, 21.7 * scale),
      Offset(16.9 * scale, 20.8 * scale),
      paint,
    );
    // M16.8 15.3 l-0.4 -1
    canvas.drawLine(
      Offset(16.8 * scale, 15.3 * scale),
      Offset(16.4 * scale, 14.3 * scale),
      paint,
    );
    // M19.1 15.2 l0.3 -0.9
    canvas.drawLine(
      Offset(19.1 * scale, 15.2 * scale),
      Offset(19.4 * scale, 14.3 * scale),
      paint,
    );
    // M19.6 21.7 l-0.4 -1
    canvas.drawLine(
      Offset(19.6 * scale, 21.7 * scale),
      Offset(19.2 * scale, 20.7 * scale),
      paint,
    );
    // M20.7 16.8 l1 -0.4
    canvas.drawLine(
      Offset(20.7 * scale, 16.8 * scale),
      Offset(21.7 * scale, 16.4 * scale),
      paint,
    );
    // M21.7 19.4 l-0.9 -0.3
    canvas.drawLine(
      Offset(21.7 * scale, 19.4 * scale),
      Offset(20.8 * scale, 19.1 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(Columns3CogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
