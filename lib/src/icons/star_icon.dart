import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Star Icon - Star pulses/scales
class StarIcon extends AnimatedSVGIcon {
  const StarIcon({
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
  String get animationDescription => "Star pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return StarPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Star icon
class StarPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  StarPainter({
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
    final scaleAnim = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scaleAnim);
    canvas.translate(-center.dx, -center.dy);

    // Star shape - 5 pointed star
    // Using simplified points based on SVG path
    final starPath = Path();

    // Top point
    starPath.moveTo(12 * scale, 2 * scale);
    // To right upper
    starPath.lineTo(14.5 * scale, 8.5 * scale);
    // To right point
    starPath.lineTo(21.5 * scale, 9.5 * scale);
    // To right lower
    starPath.lineTo(16.5 * scale, 14 * scale);
    // To bottom right point
    starPath.lineTo(18 * scale, 21 * scale);
    // To center bottom
    starPath.lineTo(12 * scale, 17.5 * scale);
    // To bottom left point
    starPath.lineTo(6 * scale, 21 * scale);
    // To left lower
    starPath.lineTo(7.5 * scale, 14 * scale);
    // To left point
    starPath.lineTo(2.5 * scale, 9.5 * scale);
    // To left upper
    starPath.lineTo(9.5 * scale, 8.5 * scale);
    // Close to top
    starPath.close();

    canvas.drawPath(starPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
