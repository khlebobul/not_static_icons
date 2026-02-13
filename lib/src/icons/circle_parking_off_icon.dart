import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Parking Off Icon - Pulses
class CircleParkingOffIcon extends AnimatedSVGIcon {
  const CircleParkingOffIcon({
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
  String get animationDescription => "Parking off pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleParkingOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Parking Off icon
class CircleParkingOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleParkingOffPainter({
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
    final center = Offset(12 * scale, 12 * scale);

    // Animation - pulse scale
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // P letter partial top: M12.656 7H13a3 3 0 0 1 2.984 3.307
    final pTop = Path();
    pTop.moveTo(12.656 * scale, 7 * scale);
    pTop.lineTo(13 * scale, 7 * scale);
    pTop.arcToPoint(
      Offset(15.984 * scale, 10.307 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    canvas.drawPath(pTop, paint);

    // Horizontal line: M13 13H9
    canvas.drawLine(
      Offset(13 * scale, 13 * scale),
      Offset(9 * scale, 13 * scale),
      paint,
    );

    // Arc: M19.071 19.071A10 10 0 0 1 4.93 4.93
    // large-arc-flag=0, sweep-flag=1 (clockwise, small arc)
    final arc1 = Path();
    arc1.moveTo(19.071 * scale, 19.071 * scale);
    arc1.arcToPoint(
      Offset(4.93 * scale, 4.93 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
      largeArc: false,
    );
    canvas.drawPath(arc1, paint);

    // Diagonal line: m2 2 20 20
    canvas.drawLine(
      Offset(2 * scale, 2 * scale),
      Offset(22 * scale, 22 * scale),
      paint,
    );

    // Arc: M8.357 2.687a10 10 0 0 1 12.956 12.956
    final arc2 = Path();
    arc2.moveTo(8.357 * scale, 2.687 * scale);
    arc2.arcToPoint(
      Offset(21.313 * scale, 15.643 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(arc2, paint);

    // Vertical line for P: M9 17V9
    canvas.drawLine(
      Offset(9 * scale, 17 * scale),
      Offset(9 * scale, 9 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleParkingOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
