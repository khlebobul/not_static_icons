import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Grid 2x2 Icon - Grid pulses
class Grid2x2Icon extends AnimatedSVGIcon {
  const Grid2x2Icon({
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
  String get animationDescription => "Grid pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Grid2x2Painter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Grid 2x2 icon
class Grid2x2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  Grid2x2Painter({
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

    // Outer frame: rect x="3" y="3" width="18" height="18" rx="2"
    final framePath = Path();
    framePath.moveTo(5 * scale, 3 * scale);
    framePath.lineTo(19 * scale, 3 * scale);
    framePath.arcToPoint(
      Offset(21 * scale, 5 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(21 * scale, 19 * scale);
    framePath.arcToPoint(
      Offset(19 * scale, 21 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(5 * scale, 21 * scale);
    framePath.arcToPoint(
      Offset(3 * scale, 19 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    framePath.lineTo(3 * scale, 5 * scale);
    framePath.arcToPoint(
      Offset(5 * scale, 3 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    canvas.drawPath(framePath, paint);

    // Vertical line: M12 3v18
    canvas.drawLine(
      Offset(12 * scale, 3 * scale),
      Offset(12 * scale, 21 * scale),
      paint,
    );

    // Horizontal line: M3 12h18
    canvas.drawLine(
      Offset(3 * scale, 12 * scale),
      Offset(21 * scale, 12 * scale),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(Grid2x2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
