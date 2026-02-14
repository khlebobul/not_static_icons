import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Power Icon - Power symbol pulses
class CirclePowerIcon extends AnimatedSVGIcon {
  const CirclePowerIcon({
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
  String get animationDescription => "Power symbol pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CirclePowerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Power icon
class CirclePowerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CirclePowerPainter({
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

    // Outer circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Vertical line (power button stem): M12 7v4
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 11 * scale),
      paint,
    );

    // Power arc: M7.998 9.003a5 5 0 1 0 8-.005
    // Arc with radius 5, almost complete circle with gap at top
    final powerArc = Path();
    powerArc.moveTo(7.998 * scale, 9.003 * scale);
    powerArc.arcToPoint(
      Offset(15.998 * scale, 8.998 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(powerArc, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePowerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
