import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Caravan Icon - Caravan bounces
class CaravanIcon extends AnimatedSVGIcon {
  const CaravanIcon({
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
  String get animationDescription => "Caravan bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Bounce: sine wave translation Y
    final bounce = math.sin(animationValue * math.pi * 2) * 1.0;

    return CaravanPainter(
      color: color,
      bounce: bounce,
      strokeWidth: strokeWidth,
    );
  }
}

class CaravanPainter extends CustomPainter {
  final Color color;
  final double bounce;
  final double strokeWidth;

  CaravanPainter({
    required this.color,
    required this.bounce,
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

    // Body
    // M18 19V9a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v8a2 2 0 0 0 2 2h2
    // M2 9h3a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1H2
    // M22 17v1a1 1 0 0 1-1 1H10v-9a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v9

    canvas.save();
    canvas.translate(0, -bounce * scale);

    final bodyPath = Path();
    bodyPath.moveTo(18 * scale, 19 * scale);
    bodyPath.lineTo(18 * scale, 9 * scale);
    bodyPath.arcToPoint(Offset(14 * scale, 5 * scale),
        radius: Radius.circular(4 * scale), clockwise: false);
    bodyPath.lineTo(6 * scale, 5 * scale);
    bodyPath.arcToPoint(Offset(2 * scale, 9 * scale),
        radius: Radius.circular(4 * scale), clockwise: false);
    bodyPath.lineTo(2 * scale, 17 * scale);
    bodyPath.arcToPoint(Offset(4 * scale, 19 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(6 * scale, 19 * scale);
    canvas.drawPath(bodyPath, paint);

    // Window
    final windowPath = Path();
    windowPath.moveTo(2 * scale, 9 * scale);
    windowPath.lineTo(5 * scale, 9 * scale);
    windowPath.arcToPoint(Offset(6 * scale, 10 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    windowPath.lineTo(6 * scale, 12 * scale);
    windowPath.arcToPoint(Offset(5 * scale, 13 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    windowPath.lineTo(2 * scale, 13 * scale);
    canvas.drawPath(windowPath, paint);

    // Door/Hitch?
    final hitchPath = Path();
    hitchPath.moveTo(22 * scale, 17 * scale);
    hitchPath.lineTo(22 * scale, 18 * scale);
    hitchPath.arcToPoint(Offset(21 * scale, 19 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    hitchPath.lineTo(10 * scale, 19 * scale);
    hitchPath.lineTo(10 * scale, 10 * scale);
    hitchPath.arcToPoint(Offset(11 * scale, 9 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    hitchPath.lineTo(13 * scale, 9 * scale);
    hitchPath.arcToPoint(Offset(14 * scale, 10 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    hitchPath.lineTo(14 * scale, 19 * scale);
    canvas.drawPath(hitchPath, paint);

    canvas.restore();

    // Wheel (Static)
    // circle cx="8" cy="19" r="2"
    canvas.drawCircle(Offset(8 * scale, 19 * scale), 2 * scale, paint);
  }

  @override
  bool shouldRepaint(CaravanPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bounce != bounce ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
