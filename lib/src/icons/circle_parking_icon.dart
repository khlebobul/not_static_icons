import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Parking Icon - P letter pulses
class CircleParkingIcon extends AnimatedSVGIcon {
  const CircleParkingIcon({
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
  String get animationDescription => "Parking P pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CircleParkingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Parking icon
class CircleParkingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CircleParkingPainter({
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

    // Circle: cx="12" cy="12" r="10"
    canvas.drawCircle(center, 10 * scale, paint);

    // Animated P letter with pulse
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // P letter: path d="M9 17V7h4a3 3 0 0 1 0 6H9"
    // Vertical line
    canvas.drawLine(
      Offset(9 * scale, 17 * scale),
      Offset(9 * scale, 7 * scale),
      paint,
    );

    // Top horizontal and curve
    final path = Path();
    path.moveTo(9 * scale, 7 * scale);
    path.lineTo(13 * scale, 7 * scale);
    path.arcToPoint(
      Offset(13 * scale, 13 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    path.lineTo(9 * scale, 13 * scale);
    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircleParkingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
