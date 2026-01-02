import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Moon Icon - Moon pulses/glows
class MoonIcon extends AnimatedSVGIcon {
  const MoonIcon({
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
  String get animationDescription => "Moon pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return MoonPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Moon icon
class MoonPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  MoonPainter({
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

    // Moon crescent shape
    // SVG: M20.985 12.486a9 9 0 1 1-9.473-9.472c.405-.022.617.46.402.803a6 6 0 0 0 8.268 8.268c.344-.215.825-.004.803.401
    final moonPath = Path();
    moonPath.moveTo(20.985 * scale, 12.486 * scale);
    // Main circle arc (almost full circle)
    moonPath.arcToPoint(
      Offset(11.512 * scale, 3.014 * scale),
      radius: Radius.circular(9 * scale),
      largeArc: true,
      clockwise: true,
    );
    // Small curve at top
    moonPath.cubicTo(
      11.917 * scale, 2.992 * scale,
      12.129 * scale, 3.474 * scale,
      11.914 * scale, 3.817 * scale,
    );
    // Inner crescent arc (6 radius)
    moonPath.arcToPoint(
      Offset(20.182 * scale, 12.085 * scale),
      radius: Radius.circular(6 * scale),
      clockwise: false,
    );
    // Small curve at end
    moonPath.cubicTo(
      20.526 * scale, 11.87 * scale,
      21.007 * scale, 12.081 * scale,
      20.985 * scale, 12.486 * scale,
    );
    canvas.drawPath(moonPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MoonPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
