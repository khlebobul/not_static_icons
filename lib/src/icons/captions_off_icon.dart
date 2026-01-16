import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Captions Off Icon - Slash shakes
class CaptionsOffIcon extends AnimatedSVGIcon {
  const CaptionsOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Slash shakes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Shake: sine wave
    final shake = math.sin(animationValue * math.pi * 3) * 0.1;

    return CaptionsOffPainter(
      color: color,
      shake: shake,
      strokeWidth: strokeWidth,
    );
  }
}

class CaptionsOffPainter extends CustomPainter {
  final Color color;
  final double shake;
  final double strokeWidth;

  CaptionsOffPainter({
    required this.color,
    required this.shake,
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

    canvas.save();
    canvas.translate(shake * size.width, 0);

    // M10.5 5H19a2 2 0 0 1 2 2v8.5
    final path1 = Path();
    path1.moveTo(10.5 * scale, 5 * scale);
    path1.lineTo(19 * scale, 5 * scale);
    path1.arcToPoint(Offset(21 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path1.lineTo(21 * scale, 15.5 * scale);
    canvas.drawPath(path1, paint);

    // M17 11h-.5
    canvas.drawLine(Offset(17 * scale, 11 * scale),
        Offset(16.5 * scale, 11 * scale), paint);

    // M19 19H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2
    final path2 = Path();
    path2.moveTo(19 * scale, 19 * scale);
    path2.lineTo(5 * scale, 19 * scale);
    path2.arcToPoint(Offset(3 * scale, 17 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    path2.lineTo(3 * scale, 7 * scale);
    path2.arcToPoint(Offset(5 * scale, 5 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canvas.drawPath(path2, paint);

    // M7 11h4
    canvas.drawLine(
        Offset(7 * scale, 11 * scale), Offset(11 * scale, 11 * scale), paint);

    // M7 15h2.5
    canvas.drawLine(
        Offset(7 * scale, 15 * scale), Offset(9.5 * scale, 15 * scale), paint);

    // Slash
    // m2 2 20 20
    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CaptionsOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shake != shake ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
