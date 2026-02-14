import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Off Icon - Pulses
class CircleOffIcon extends AnimatedSVGIcon {
  const CircleOffIcon({
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
  String get animationDescription => "Circle off pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Off icon
class CircleOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleOffPainter({
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

    // Diagonal line: m2 2 20 20
    canvas.drawLine(
      Offset(2 * scale, 2 * scale),
      Offset(22 * scale, 22 * scale),
      paint,
    );

    // Arc 1: M8.35 2.69A10 10 0 0 1 21.3 15.65
    // From top-left area to right side
    final arc1 = Path();
    arc1.moveTo(8.35 * scale, 2.69 * scale);
    arc1.arcToPoint(
      Offset(21.3 * scale, 15.65 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(arc1, paint);

    // Arc 2: M19.08 19.08A10 10 0 1 1 4.92 4.92
    // large-arc-flag=1, sweep-flag=1 (clockwise, large arc)
    final arc2 = Path();
    arc2.moveTo(19.08 * scale, 19.08 * scale);
    arc2.arcToPoint(
      Offset(4.92 * scale, 4.92 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
      largeArc: true,
    );
    canvas.drawPath(arc2, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
