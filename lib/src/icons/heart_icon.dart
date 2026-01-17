import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Heart Icon - Beats/pulses
class HeartIcon extends AnimatedSVGIcon {
  const HeartIcon({
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
  String get animationDescription => "Heart beats";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return HeartPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Heart icon
class HeartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  HeartPainter({
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

    // Animation - heartbeat pulse
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Heart shape
    // SVG: M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5
    final heartPath = Path();
    heartPath.moveTo(2 * scale, 9.5 * scale);
    // Left half arc
    heartPath.arcToPoint(
      Offset(11.591 * scale, 5.824 * scale),
      radius: Radius.circular(5.5 * scale),
      clockwise: true,
    );
    // Small arc at top center
    heartPath.arcToPoint(
      Offset(12.409 * scale, 5.824 * scale),
      radius: Radius.circular(0.56 * scale),
      clockwise: false,
    );
    // Right half arc
    heartPath.arcToPoint(
      Offset(22 * scale, 9.5 * scale),
      radius: Radius.circular(5.49 * scale),
      clockwise: true,
    );
    // Right side down
    heartPath.cubicTo(
      22 * scale,
      11.79 * scale,
      20.5 * scale,
      13.5 * scale,
      19 * scale,
      15 * scale,
    );
    // Bottom right curve to point
    heartPath.lineTo(13.508 * scale, 20.313 * scale);
    // Bottom arc
    heartPath.arcToPoint(
      Offset(10.508 * scale, 20.332 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // Bottom left to left side
    heartPath.lineTo(5 * scale, 15 * scale);
    // Left side up
    heartPath.cubicTo(
      3.5 * scale,
      13.5 * scale,
      2 * scale,
      11.8 * scale,
      2 * scale,
      9.5 * scale,
    );
    canvas.drawPath(heartPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
