import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Ambulance Icon - Driving motion with bouncing effect
class AmbulanceIcon extends AnimatedSVGIcon {
  const AmbulanceIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Driving motion with bouncing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AmbulancePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Ambulance icon
class AmbulancePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AmbulancePainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scale = size.width / 24.0;

    // Create bouncing effect - simulate driving on road
    final bounceOffset = sin(animationValue * 2 * pi) * 1.5 * scale;

    canvas.save();
    canvas.translate(0, bounceOffset);

    // Cross horizontal line (M10 10H6)
    canvas.drawLine(
      Offset(10 * scale, 10 * scale),
      Offset(6 * scale, 10 * scale),
      paint,
    );

    // Cross vertical line (M8 8v4)
    canvas.drawLine(
      Offset(8 * scale, 8 * scale),
      Offset(8 * scale, 12 * scale),
      paint,
    );

    // Main ambulance body (M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2)
    final mainBodyPath = Path();
    mainBodyPath.moveTo(14 * scale, 18 * scale);
    mainBodyPath.lineTo(14 * scale, 6 * scale);

    // Arc: a2 2 0 0 0-2-2 (from 14,6 to 12,4)
    mainBodyPath.arcToPoint(
      Offset(12 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    mainBodyPath.lineTo(4 * scale, 4 * scale);

    // Arc: a2 2 0 0 0-2 2 (from 4,4 to 2,6)
    mainBodyPath.arcToPoint(
      Offset(2 * scale, 6 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );

    mainBodyPath.lineTo(2 * scale, 17 * scale);

    // Arc: a1 1 0 0 0 1 1 (from 2,17 to 3,18)
    mainBodyPath.arcToPoint(
      Offset(3 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );

    mainBodyPath.lineTo(5 * scale, 18 * scale);

    canvas.drawPath(mainBodyPath, paint);

    // Ambulance rear section - complex path
    final rearPath = Path();
    rearPath.moveTo(19 * scale, 18 * scale);
    rearPath.lineTo(21 * scale, 18 * scale);

    // Arc: a1 1 0 0 0 1-1 (from 21,18 to 22,17)
    rearPath.arcToPoint(
      Offset(22 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );

    rearPath.lineTo(22 * scale, 13.72 * scale);

    // This is a simplified version of the complex rear section
    rearPath.lineTo(19.316 * scale, 12.772 * scale);
    rearPath.lineTo(16.382 * scale, 8 * scale);
    rearPath.lineTo(14 * scale, 8 * scale);

    canvas.drawPath(rearPath, paint);

    // Bottom connection (M9 18h6)
    canvas.drawLine(
      Offset(9 * scale, 18 * scale),
      Offset(15 * scale, 18 * scale),
      paint,
    );

    // Left wheel (circle cx="7" cy="18" r="2")
    canvas.drawCircle(Offset(7 * scale, 18 * scale), 2 * scale, paint);

    // Right wheel (circle cx="17" cy="18" r="2")
    canvas.drawCircle(Offset(17 * scale, 18 * scale), 2 * scale, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(AmbulancePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
