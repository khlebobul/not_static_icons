import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Activity Icon - Pulsing effect
class ActivityIcon extends AnimatedSVGIcon {
  const ActivityIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
  });

  @override
  String get animationDescription => "Pulsing effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ActivityPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Activity icon
class ActivityPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ActivityPainter({
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

    // Calculate pulsing scale factor
    final pulseScale = 1.0 + 0.2 * sin(animationValue * 2 * pi);

    // Apply pulsing animation
    canvas.save();
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.scale(pulseScale);
    canvas.translate(-center.dx, -center.dy);

    // Draw the activity heartbeat line following the original SVG
    // M22 12h-2.48a2 2 0 0 0-1.93 1.46l-2.35 8.36a.25.25 0 0 1-.48 0L9.24 2.18a.25.25 0 0 0-.48 0l-2.35 8.36A2 2 0 0 1 4.49 12H2

    final path = Path();

    // Start at M22 12 (right side horizontal line)
    path.moveTo(22 * scale, 12 * scale);
    path.lineTo(19.52 * scale, 12 * scale);

    // Gentle curve down (simulating the arc to prepare for the spike)
    path.quadraticBezierTo(
      18.5 * scale,
      12.5 * scale,
      17.59 * scale,
      13.46 * scale,
    );

    // Sharp spike up (first peak of heartbeat) - correcting coordinates to stay within bounds
    path.lineTo(15.24 * scale, 21 * scale);

    // Quick drop to neutral position
    path.lineTo(14.76 * scale, 21 * scale);

    // Main dramatic drop and spike (characteristic heartbeat dip and peak)
    path.lineTo(9.24 * scale, 3 * scale);
    path.lineTo(8.76 * scale, 3 * scale);

    // Return up with smaller spike
    path.lineTo(6.41 * scale, 10.54 * scale);

    // Smooth curve back to baseline
    path.quadraticBezierTo(5.5 * scale, 11.5 * scale, 4.49 * scale, 12 * scale);

    // Left side horizontal line
    path.lineTo(2 * scale, 12 * scale);

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ActivityPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
