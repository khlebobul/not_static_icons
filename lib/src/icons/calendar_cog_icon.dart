import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar Cog Icon - Cog rotates
class CalendarCogIcon extends AnimatedSVGIcon {
  const CalendarCogIcon({
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
  String get animationDescription => "Cog rotates";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Rotate 180 degrees
    final angle = animationValue * math.pi;

    return CalendarCogPainter(
      color: color,
      angle: angle,
      strokeWidth: strokeWidth,
    );
  }
}

class CalendarCogPainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  CalendarCogPainter({
    required this.color,
    required this.angle,
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

    // Calendar Body (Static)
    // M21 10.592V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h6
    final bodyPath = Path();
    bodyPath.moveTo(21 * scale, 10.592 * scale);
    bodyPath.lineTo(21 * scale, 6 * scale);
    bodyPath.arcToPoint(Offset(19 * scale, 4 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(5 * scale, 4 * scale);
    bodyPath.arcToPoint(Offset(3 * scale, 6 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(3 * scale, 20 * scale);
    bodyPath.arcToPoint(Offset(5 * scale, 22 * scale),
        radius: Radius.circular(2 * scale), clockwise: false);
    bodyPath.lineTo(11 * scale, 22 * scale);
    canvas.drawPath(bodyPath, paint);

    // M3 10h18
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Cog (Animated)
    // Center 18, 18.

    canvas.save();
    canvas.translate(18 * scale, 18 * scale);
    canvas.rotate(angle);
    canvas.translate(-18 * scale, -18 * scale);

    // circle cx="18" cy="18" r="3"
    canvas.drawCircle(Offset(18 * scale, 18 * scale), 3 * scale, paint);

    // Teeth
    // m15.228 16.852-.923-.383
    // m15.228 19.148-.923.383
    // m16.47 14.305.382.923
    // m16.852 20.772-.383.924
    // m19.148 15.228.383-.923
    // m19.53 21.696-.382-.924
    // m20.772 16.852.924-.383
    // m20.772 19.148.924.383

    // These are little lines sticking out.
    void drawTooth(double x1, double y1, double x2, double y2) {
      canvas.drawLine(Offset(x1 * scale, y1 * scale),
          Offset(x2 * scale, y2 * scale), paint);
    }

    drawTooth(15.228, 16.852, 14.305, 16.469); // .923 .383 diff
    drawTooth(15.228, 19.148, 14.305, 19.531);
    drawTooth(16.47, 14.305, 16.852, 15.228); // Wait, SVG path is relative?
    // m16.47 14.305 .382 .923 -> L 16.852 15.228.
    // Yes, these are lines from outer to inner or vice versa.
    // Let's just draw them as lines.

    // 1
    canvas.drawLine(Offset(15.228 * scale, 16.852 * scale),
        Offset((15.228 - 0.923) * scale, (16.852 - 0.383) * scale), paint);
    // 2
    canvas.drawLine(Offset(15.228 * scale, 19.148 * scale),
        Offset((15.228 - 0.923) * scale, (19.148 + 0.383) * scale), paint);
    // 3
    canvas.drawLine(Offset(16.47 * scale, 14.305 * scale),
        Offset((16.47 + 0.382) * scale, (14.305 + 0.923) * scale), paint);
    // 4
    canvas.drawLine(Offset(16.852 * scale, 20.772 * scale),
        Offset((16.852 - 0.383) * scale, (20.772 + 0.924) * scale), paint);
    // 5
    canvas.drawLine(Offset(19.148 * scale, 15.228 * scale),
        Offset((19.148 + 0.383) * scale, (15.228 - 0.923) * scale), paint);
    // 6
    canvas.drawLine(Offset(19.53 * scale, 21.696 * scale),
        Offset((19.53 - 0.382) * scale, (21.696 - 0.924) * scale), paint);
    // 7
    canvas.drawLine(Offset(20.772 * scale, 16.852 * scale),
        Offset((20.772 + 0.924) * scale, (16.852 - 0.383) * scale), paint);
    // 8
    canvas.drawLine(Offset(20.772 * scale, 19.148 * scale),
        Offset((20.772 + 0.924) * scale, (19.148 + 0.383) * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CalendarCogPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.angle != angle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
