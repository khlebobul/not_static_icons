import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clapperboard Icon - Clapper closes
class ClapperboardIcon extends AnimatedSVGIcon {
  const ClapperboardIcon({
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
  String get animationDescription => "Clapper closes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClapperboardPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClapperboardPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClapperboardPainter({
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

    // Animation - top clapper rotates down
    final oscillation = 4 * animationValue * (1 - animationValue);
    final clapAngle = -oscillation * 0.15;

    // Bottom board: M3 11h18v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z
    final boardPath = Path();
    boardPath.moveTo(3 * scale, 11 * scale);
    boardPath.lineTo(21 * scale, 11 * scale);
    boardPath.lineTo(21 * scale, 19 * scale);
    boardPath.arcToPoint(
      Offset(19 * scale, 21 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.lineTo(5 * scale, 21 * scale);
    boardPath.arcToPoint(
      Offset(3 * scale, 19 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    boardPath.close();
    canvas.drawPath(boardPath, paint);

    // Top clapper with rotation
    canvas.save();
    canvas.translate(3 * scale, 11 * scale);
    canvas.rotate(clapAngle);
    canvas.translate(-3 * scale, -11 * scale);

    // Top clapper: M20.2 6 3 11l-.9-2.4c-.3-1.1.3-2.2 1.3-2.5l13.5-4c1.1-.3 2.2.3 2.5 1.3z
    final clapperPath = Path();
    clapperPath.moveTo(20.2 * scale, 6 * scale);
    clapperPath.lineTo(3 * scale, 11 * scale);
    clapperPath.lineTo(2.1 * scale, 8.6 * scale);
    clapperPath.cubicTo(
      1.8 * scale,
      7.5 * scale,
      2.4 * scale,
      6.4 * scale,
      3.4 * scale,
      6.1 * scale,
    );
    clapperPath.lineTo(16.9 * scale, 2.1 * scale);
    clapperPath.cubicTo(
      18 * scale,
      1.8 * scale,
      19.1 * scale,
      2.4 * scale,
      19.4 * scale,
      3.4 * scale,
    );
    clapperPath.close();
    canvas.drawPath(clapperPath, paint);

    // Stripe 1: m12.296 3.464 3.02 3.956
    canvas.drawLine(
      Offset(12.296 * scale, 3.464 * scale),
      Offset(15.316 * scale, 7.42 * scale),
      paint,
    );

    // Stripe 2: m6.18 5.276 3.1 3.899
    canvas.drawLine(
      Offset(6.18 * scale, 5.276 * scale),
      Offset(9.28 * scale, 9.175 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClapperboardPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
