import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Captions Icon - Lines appear
class CaptionsIcon extends AnimatedSVGIcon {
  const CaptionsIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Lines appear";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CaptionsPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CaptionsPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  CaptionsPainter({
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

    // Box (Static)
    // rect width="18" height="14" x="3" y="5" rx="2" ry="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 5 * scale, 18 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Lines (Animated)
    // M7 11h2
    // M13 11h4
    // M7 15h4
    // M15 15h2

    final lines = [
      (start: Offset(7, 11), end: Offset(9, 11)),
      (start: Offset(13, 11), end: Offset(17, 11)),
      (start: Offset(7, 15), end: Offset(11, 15)),
      (start: Offset(15, 15), end: Offset(17, 15)),
    ];

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final threshold = i * (1.0 / lines.length);

      if (drawProgress > threshold) {
        // Calculate local progress for this line
        double localProgress =
            ((drawProgress - threshold) / (1.0 / lines.length)).clamp(0.0, 1.0);

        // Draw partial line
        final startX = line.start.dx * scale;
        final startY = line.start.dy * scale;
        final endX = line.end.dx * scale;
        final endY = line.end.dy * scale;

        final currentEndX = startX + (endX - startX) * localProgress;

        canvas.drawLine(
            Offset(startX, startY), Offset(currentEndX, endY), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CaptionsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
