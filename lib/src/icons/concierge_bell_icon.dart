import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Concierge Bell Icon - Bell rings
class ConciergeBellIcon extends AnimatedSVGIcon {
  const ConciergeBellIcon({
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
  String get animationDescription => "Bell rings";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ConciergeBellPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ConciergeBellPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ConciergeBellPainter({
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

    // Animation - bell dome bounces up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounce = oscillation * 2.0;

    // Base: M3 20a1 1 0 0 1-1-1v-1a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v1a1 1 0 0 1-1 1Z
    final basePath = Path();
    basePath.moveTo(3 * scale, 20 * scale);
    basePath.lineTo(2 * scale, 20 * scale);
    basePath.arcToPoint(
      Offset(1 * scale, 19 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    // Actually let me re-read the SVG path more carefully
    // M3 20a1 1 0 0 1-1-1v-1a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v1a1 1 0 0 1-1 1Z
    // Start at 3,20
    // arc to (3-1, 20-1) = (2, 19) with r=1
    // v-1 -> go to (2, 18)
    // arc to (2+2, 18-2) wait no... a2 2 0 0 1 2-2 means relative arc endpoint (2,-2) = (4, 16)
    // h16 -> (20, 16)
    // a2 2 0 0 1 2 2 -> (22, 18)
    // v1 -> (22, 19)
    // a1 1 0 0 1-1 1 -> (21, 20)
    // Z -> close back to (3, 20)
    final basePath2 = Path();
    basePath2.moveTo(3 * scale, 20 * scale);
    basePath2.arcToPoint(
      Offset(2 * scale, 19 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    basePath2.lineTo(2 * scale, 18 * scale);
    basePath2.arcToPoint(
      Offset(4 * scale, 16 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    basePath2.lineTo(20 * scale, 16 * scale);
    basePath2.arcToPoint(
      Offset(22 * scale, 18 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    basePath2.lineTo(22 * scale, 19 * scale);
    basePath2.arcToPoint(
      Offset(21 * scale, 20 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    basePath2.close();
    canvas.drawPath(basePath2, paint);

    // Dome (animated): M20 16a8 8 0 1 0-16 0
    final domePath = Path();
    domePath.moveTo(20 * scale, (16 - bounce) * scale);
    domePath.arcToPoint(
      Offset(4 * scale, (16 - bounce) * scale),
      radius: Radius.circular(8 * scale),
      largeArc: true,
      clockwise: false,
    );
    canvas.drawPath(domePath, paint);

    // Button stem (animated): M12 4v4
    canvas.drawLine(
      Offset(12 * scale, (4 - bounce) * scale),
      Offset(12 * scale, (8 - bounce) * scale),
      paint,
    );

    // Button top (animated): M10 4h4
    canvas.drawLine(
      Offset(10 * scale, (4 - bounce) * scale),
      Offset(14 * scale, (4 - bounce) * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(ConciergeBellPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
