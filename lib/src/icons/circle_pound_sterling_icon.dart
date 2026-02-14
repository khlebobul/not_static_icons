import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Circle Pound Sterling Icon - Pound symbol pulses
class CirclePoundSterlingIcon extends AnimatedSVGIcon {
  const CirclePoundSterlingIcon({
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
  String get animationDescription => "Pound symbol pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CirclePoundSterlingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Circle Pound Sterling icon
class CirclePoundSterlingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CirclePoundSterlingPainter({
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

    // Animated pound symbol with pulse
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.1;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Pound symbol: path d="M10 16V9.5a1 1 0 0 1 5 0"
    // Main vertical stroke with curve at top
    final path = Path();
    path.moveTo(10 * scale, 16 * scale);
    path.lineTo(10 * scale, 9.5 * scale);
    // Simple curve approximation for the top
    path.quadraticBezierTo(
      10 * scale,
      8 * scale,
      12.5 * scale,
      8 * scale,
    );
    path.quadraticBezierTo(
      15 * scale,
      8 * scale,
      15 * scale,
      9.5 * scale,
    );
    canvas.drawPath(path, paint);

    // Horizontal line through middle: M8 12h4
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );

    // Bottom line: M8 16h7
    canvas.drawLine(
      Offset(8 * scale, 16 * scale),
      Offset(15 * scale, 16 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePoundSterlingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
