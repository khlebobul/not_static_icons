import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Slash Icon - Diagonal line draws from top-right to bottom-left
class SlashIcon extends AnimatedSVGIcon {
  const SlashIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Diagonal line draws from top-right to bottom-left";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return SlashPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class SlashPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  SlashPainter({
    required this.color,
    required this.progress,
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

    double drawProgress = progress;

    if (progress == 0) {
      drawProgress = 1.0;
    }

    // Slash line: M22 2 L2 22
    // Draws from top-right (22, 2) to bottom-left (2, 22)

    if (drawProgress > 0) {
      final startX = 22 * scale;
      final startY = 2 * scale;
      final endX = 2 * scale;
      final endY = 22 * scale;

      // Interpolate the end point based on progress
      final currentEndX = startX + (endX - startX) * drawProgress;
      final currentEndY = startY + (endY - startY) * drawProgress;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(currentEndX, currentEndY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SlashPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
