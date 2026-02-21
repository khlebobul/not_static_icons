import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Ship Icon - Ship rocks on waves
class ShipIcon extends AnimatedSVGIcon {
  const ShipIcon({
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
  String get animationDescription => "Ship rocks on waves";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ShipPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ShipPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ShipPainter({
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

    // Animation - ship rocks slightly
    final oscillation = 4 * animationValue * (1 - animationValue);
    final rockAngle = oscillation * 0.05;

    final center = Offset(12 * scale, 12 * scale);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rockAngle);
    canvas.translate(-center.dx, -center.dy);

    // Mast top: M12 2v3
    canvas.drawLine(
      Offset(12 * scale, 2 * scale),
      Offset(12 * scale, 5 * scale),
      paint,
    );

    // Mast bottom: M12 10.189V14
    canvas.drawLine(
      Offset(12 * scale, 10.189 * scale),
      Offset(12 * scale, 14 * scale),
      paint,
    );

    // Cabin: M19 13V7a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v6
    final cabinPath = Path();
    cabinPath.moveTo(19 * scale, 13 * scale);
    cabinPath.lineTo(19 * scale, 7 * scale);
    cabinPath.arcToPoint(
      Offset(17 * scale, 5 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    cabinPath.lineTo(7 * scale, 5 * scale);
    cabinPath.arcToPoint(
      Offset(5 * scale, 7 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    cabinPath.lineTo(5 * scale, 13 * scale);
    canvas.drawPath(cabinPath, paint);

    // Hull: M19.38 20A11.6 11.6 0 0 0 21 14l-8.188-3.639a2 2 0 0 0-1.624 0L3 14a11.6 11.6 0 0 0 2.81 7.76
    final hullPath = Path();
    hullPath.moveTo(19.38 * scale, 20 * scale);
    hullPath.cubicTo(
      20.5 * scale, 18 * scale,
      21 * scale, 16 * scale,
      21 * scale, 14 * scale,
    );
    hullPath.lineTo(12.812 * scale, 10.361 * scale);
    hullPath.arcToPoint(
      Offset(11.188 * scale, 10.361 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    hullPath.lineTo(3 * scale, 14 * scale);
    hullPath.cubicTo(
      3.5 * scale, 16.5 * scale,
      4.5 * scale, 19 * scale,
      5.81 * scale, 21.76 * scale,
    );
    canvas.drawPath(hullPath, paint);

    // Waves: M2 21c.6.5 1.2 1 2.5 1 2.5 0 2.5-2 5-2 1.3 0 1.9.5 2.5 1s1.2 1 2.5 1c2.5 0 2.5-2 5-2 1.3 0 1.9.5 2.5 1
    final wavePath = Path();
    wavePath.moveTo(2 * scale, 21 * scale);
    wavePath.cubicTo(
      2.6 * scale, 21.5 * scale,
      3.2 * scale, 22 * scale,
      4.5 * scale, 22 * scale,
    );
    wavePath.cubicTo(
      6 * scale, 22 * scale,
      6.5 * scale, 20.5 * scale,
      9.5 * scale, 20 * scale,
    );
    wavePath.cubicTo(
      10.8 * scale, 20 * scale,
      11.4 * scale, 20.5 * scale,
      12 * scale, 21 * scale,
    );
    wavePath.cubicTo(
      12.6 * scale, 21.5 * scale,
      13.2 * scale, 22 * scale,
      14.5 * scale, 22 * scale,
    );
    wavePath.cubicTo(
      16 * scale, 22 * scale,
      16.5 * scale, 20.5 * scale,
      19.5 * scale, 20 * scale,
    );
    wavePath.cubicTo(
      20.8 * scale, 20 * scale,
      21.4 * scale, 20.5 * scale,
      22 * scale, 21 * scale,
    );
    canvas.drawPath(wavePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ShipPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
