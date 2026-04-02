import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cookie Icon - Cookie bounces
class CookieIcon extends AnimatedSVGIcon {
  const CookieIcon({
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
  String get animationDescription => "Cookie bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CookiePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CookiePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CookiePainter({
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

    // Animation - bounce
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounce = oscillation * 2.0;

    canvas.save();
    canvas.translate(0, -bounce * scale);

    // Cookie outline: M12 2a10 10 0 1 0 10 10 4 4 0 0 1-5-5 4 4 0 0 1-5-5
    final cookiePath = Path();
    cookiePath.moveTo(12 * scale, 2 * scale);
    // Main circle arc (most of the cookie)
    cookiePath.arcToPoint(
      Offset(22 * scale, 12 * scale),
      radius: Radius.circular(10 * scale),
      largeArc: true,
      clockwise: false,
    );
    // Bite marks
    cookiePath.arcToPoint(
      Offset(17 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    cookiePath.arcToPoint(
      Offset(12 * scale, 2 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: true,
    );
    canvas.drawPath(cookiePath, paint);

    // Chocolate chips (dots)
    final dotPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // M8.5 8.5v.01
    canvas.drawLine(
      Offset(8.5 * scale, 8.5 * scale),
      Offset(8.5 * scale, 8.51 * scale),
      dotPaint,
    );
    // M16 15.5v.01
    canvas.drawLine(
      Offset(16 * scale, 15.5 * scale),
      Offset(16 * scale, 15.51 * scale),
      dotPaint,
    );
    // M12 12v.01
    canvas.drawLine(
      Offset(12 * scale, 12 * scale),
      Offset(12 * scale, 12.01 * scale),
      dotPaint,
    );
    // M11 17v.01
    canvas.drawLine(
      Offset(11 * scale, 17 * scale),
      Offset(11 * scale, 17.01 * scale),
      dotPaint,
    );
    // M7 14v.01
    canvas.drawLine(
      Offset(7 * scale, 14 * scale),
      Offset(7 * scale, 14.01 * scale),
      dotPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CookiePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
