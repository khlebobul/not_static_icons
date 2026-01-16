import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Building Icon - Windows light up
class BuildingIcon extends AnimatedSVGIcon {
  const BuildingIcon({
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
  String get animationDescription => "Windows light up sequentially";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BuildingPainter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class BuildingPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  BuildingPainter({
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

    // Logic:
    // If progress is 0 (idle), draw full icon (all windows).
    // If progress > 0, animate windows appearing.

    double drawProgress = progress;
    if (progress == 0) {
      drawProgress = 1.0;
    }

    // Main Building Body
    // rect x="4" y="2" width="16" height="20" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4 * scale, 2 * scale, 16 * scale, 20 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Door
    // M9 22v-3a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v3
    final doorPath = Path();
    doorPath.moveTo(9 * scale, 22 * scale);
    doorPath.lineTo(9 * scale, 19 * scale);
    doorPath.arcToPoint(
      Offset(10 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    doorPath.lineTo(14 * scale, 18 * scale);
    doorPath.arcToPoint(
      Offset(15 * scale, 19 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    doorPath.lineTo(15 * scale, 22 * scale);
    canvas.drawPath(doorPath, paint);

    // Windows
    // 3 rows, 3 columns?
    // SVG:
    // M12 10h.01, M12 14h.01, M12 6h.01 (Center col)
    // M16 10h.01, M16 14h.01, M16 6h.01 (Right col)
    // M8 10h.01, M8 14h.01, M8 6h.01 (Left col)

    // Let's animate them appearing.
    // Order: Bottom-up or random?
    // Let's do row by row from bottom up? Or top down?
    // Top down: Row 6, Row 10, Row 14.

    // Row 1 (y=6): 0.0 - 0.33
    // Row 2 (y=10): 0.33 - 0.66
    // Row 3 (y=14): 0.66 - 1.0

    void drawWindow(double x, double y, double threshold) {
      if (drawProgress > threshold) {
        // Scale effect for pop-in
        double localProgress =
            ((drawProgress - threshold) / 0.1).clamp(0.0, 1.0);
        // Overshoot?
        double s = localProgress;

        if (s > 0) {
          // Windows are dots (h.01).
          // Let's draw them as small lines/dots.
          // strokeWidth handles the size.

          // Animate opacity or scale?
          // Scale is hard for a point.
          // Let's just draw them if progress > threshold.
          // Or maybe animate stroke width?

          final windowPaint = Paint()
            ..color = color.withValues(alpha: localProgress)
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;

          canvas.drawLine(
            Offset(x * scale, y * scale),
            Offset((x + 0.01) * scale, y * scale),
            windowPaint,
          );
        }
      }
    }

    // Row 1 (Top)
    drawWindow(8, 6, 0.0);
    drawWindow(12, 6, 0.1);
    drawWindow(16, 6, 0.2);

    // Row 2 (Middle)
    drawWindow(8, 10, 0.3);
    drawWindow(12, 10, 0.4);
    drawWindow(16, 10, 0.5);

    // Row 3 (Bottom)
    drawWindow(8, 14, 0.6);
    drawWindow(12, 14, 0.7);
    drawWindow(16, 14, 0.8);
  }

  @override
  bool shouldRepaint(BuildingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
