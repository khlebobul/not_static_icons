import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Balloon Icon - Balloon floats up and down
class BalloonIcon extends AnimatedSVGIcon {
  const BalloonIcon({
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
  String get animationDescription => "Balloon floats up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BalloonPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Balloon icon
class BalloonPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BalloonPainter({
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

    // Animation - balloon floats up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final floatOffset = oscillation * 1.5;

    // ========== BALLOON BODY ==========
    // M18 8c0 4-3.5 8-6 8s-6-4-6-8a6 6 0 0 1 12 0
    // This is an oval/balloon shape: top is a semicircle (radius 6), bottom tapers to a point
    
    final balloonPath = Path();
    // Start at right side of balloon
    balloonPath.moveTo(18 * scale, (8 - floatOffset) * scale);
    // Curve down to bottom point (12, 16)
    balloonPath.cubicTo(
      18 * scale, (12 - floatOffset) * scale,
      14.5 * scale, (16 - floatOffset) * scale,
      12 * scale, (16 - floatOffset) * scale,
    );
    // Curve up to left side
    balloonPath.cubicTo(
      9.5 * scale, (16 - floatOffset) * scale,
      6 * scale, (12 - floatOffset) * scale,
      6 * scale, (8 - floatOffset) * scale,
    );
    // Arc back to start (top semicircle) - a6 6 0 0 1 12 0
    balloonPath.arcToPoint(
      Offset(18 * scale, (8 - floatOffset) * scale),
      radius: Radius.circular(6 * scale),
      clockwise: true,
    );
    canvas.drawPath(balloonPath, paint);

    // ========== HIGHLIGHT ==========
    // M12 6a2 2 0 0 1 2 2
    final highlightPath = Path();
    highlightPath.moveTo(12 * scale, (6 - floatOffset) * scale);
    highlightPath.arcToPoint(
      Offset(14 * scale, (8 - floatOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    canvas.drawPath(highlightPath, paint);

    // ========== STRING ==========
    // M12 16v1a2 2 0 0 0 2 2h1a2 2 0 0 1 2 2v1
    final stringPath = Path();
    // Vertical line from balloon bottom
    stringPath.moveTo(12 * scale, (16 - floatOffset) * scale);
    stringPath.lineTo(12 * scale, (17 - floatOffset) * scale);
    // Arc to right
    stringPath.arcToPoint(
      Offset(14 * scale, (19 - floatOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    // Horizontal line
    stringPath.lineTo(15 * scale, (19 - floatOffset) * scale);
    // Arc down
    stringPath.arcToPoint(
      Offset(17 * scale, (21 - floatOffset) * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // Final vertical line
    stringPath.lineTo(17 * scale, (22 - floatOffset) * scale);
    canvas.drawPath(stringPath, paint);
  }

  @override
  bool shouldRepaint(BalloonPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
