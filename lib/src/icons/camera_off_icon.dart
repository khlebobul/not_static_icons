import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Camera Off Icon - Slash shakes
class CameraOffIcon extends AnimatedSVGIcon {
  const CameraOffIcon({
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
  String get animationDescription => "Slash shakes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Shake: sine wave
    final shake = math.sin(animationValue * math.pi * 3) * 0.1;

    return CameraOffPainter(
      color: color,
      shake: shake,
      strokeWidth: strokeWidth,
    );
  }
}

class CameraOffPainter extends CustomPainter {
  final Color color;
  final double shake;
  final double strokeWidth;

  CameraOffPainter({
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

    // M14.564 14.558a3 3 0 1 1-4.122-4.121
    final arcPath = Path();
    arcPath.moveTo(14.564 * scale, 14.558 * scale);
    arcPath.arcToPoint(
      Offset(10.442 * scale, 10.437 * scale), // 14.564-4.122, 14.558-4.121
      radius: Radius.circular(3 * scale),
      largeArc: true,
      clockwise: true,
    );
    canvas.drawPath(arcPath, paint);

    // M20 20H4a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1.997a2 2 0 0 0 .819-.175
    final bodyPath1 = Path();
    bodyPath1.moveTo(20 * scale, 20 * scale);
    bodyPath1.lineTo(4 * scale, 20 * scale);
    bodyPath1.arcToPoint(Offset(2 * scale, 18 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath1.lineTo(2 * scale, 9 * scale);
    bodyPath1.arcToPoint(Offset(4 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath1.lineTo(5.997 * scale, 7 * scale);
    bodyPath1.arcToPoint(Offset(6.816 * scale, 6.825 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    canvas.drawPath(bodyPath1, paint);

    // M9.695 4.024A2 2 0 0 1 10.004 4h3.993a2 2 0 0 1 1.76 1.05l.486.9A2 2 0 0 0 18.003 7H20a2 2 0 0 1 2 2v7.344
    final bodyPath2 = Path();
    bodyPath2.moveTo(9.695 * scale, 4.024 * scale);
    bodyPath2.arcToPoint(Offset(10.004 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath2.lineTo(13.997 * scale, 4 * scale);
    bodyPath2.arcToPoint(Offset(15.757 * scale, 5.05 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath2.lineTo(16.243 * scale, 5.95 * scale); // .486 .9
    bodyPath2.arcToPoint(Offset(18.003 * scale, 7 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath2.lineTo(20 * scale, 7 * scale);
    bodyPath2.arcToPoint(Offset(22 * scale, 9 * scale),
        radius: Radius.circular(2 * scale), clockwise: true);
    bodyPath2.lineTo(22 * scale, 16.344 * scale);
    canvas.drawPath(bodyPath2, paint);

    // Slash
    // m2 2 20 20
    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CameraOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shake != shake ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
