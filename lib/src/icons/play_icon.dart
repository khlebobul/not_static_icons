import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Play Icon - Pulses/scales
class PlayIcon extends AnimatedSVGIcon {
  const PlayIcon({
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
  String get animationDescription => "Play icon pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return PlayPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Play icon
class PlayPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  PlayPainter({
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

    // Play triangle: M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z
    final playPath = Path();
    playPath.moveTo(5 * scale, 5 * scale);
    // Top-left rounded corner
    playPath.arcToPoint(
      Offset(8.008 * scale, 3.272 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // Line to right point
    playPath.lineTo(20.005 * scale, 10.27 * scale);
    // Right rounded corner
    playPath.arcToPoint(
      Offset(20.008 * scale, 13.728 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // Line to bottom-left
    playPath.lineTo(8.008 * scale, 20.728 * scale);
    // Bottom-left rounded corner
    playPath.arcToPoint(
      Offset(5 * scale, 19 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    // Close path
    playPath.close();
    canvas.drawPath(playPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(PlayPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
