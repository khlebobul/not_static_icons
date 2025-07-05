import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated App Window Icon - Simple pulsing/scaling effect
class AppWindowIcon extends AnimatedSVGIcon {
  const AppWindowIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Pulsing window scale effect";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AppWindowPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for App Window icon
class AppWindowPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AppWindowPainter({
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

    // Calculate pulsing scale factor
    final pulseScale = 1.0 + 0.1 * math.sin(animationValue * 2 * math.pi);

    // Apply pulsing animation from center
    canvas.save();
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.scale(pulseScale);
    canvas.translate(-center.dx, -center.dy);

    // Draw the main window frame (rounded rectangle)
    // rect x="2" y="4" width="20" height="16" rx="2"
    final rect = RRect.fromLTRBR(
      2 * scale,
      4 * scale,
      22 * scale,
      20 * scale,
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Draw the horizontal divider line
    // path d="M2 8h20"
    canvas.drawLine(
      Offset(2 * scale, 8 * scale),
      Offset(22 * scale, 8 * scale),
      paint,
    );

    // Draw the first vertical line
    // path d="M10 4v4"
    canvas.drawLine(
      Offset(10 * scale, 4 * scale),
      Offset(10 * scale, 8 * scale),
      paint,
    );

    // Draw the second vertical line
    // path d="M6 4v4"
    canvas.drawLine(
      Offset(6 * scale, 4 * scale),
      Offset(6 * scale, 8 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(AppWindowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
