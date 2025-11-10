import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Brick Wall Icon - bricks building up animation
class BrickWallIcon extends AnimatedSVGIcon {
  const BrickWallIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Brick Wall: bricks building up animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BrickWallPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BrickWallPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BrickWallPainter({
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

    if (animationValue == 0) {
      _drawCompleteIcon(canvas, paint, scale);
    } else {
      _drawAnimatedBricks(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // rect width="18" height="18" x="3" y="3" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Horizontal lines
    // M3 15h18
    canvas.drawLine(
      Offset(3 * scale, 15 * scale),
      Offset(21 * scale, 15 * scale),
      paint,
    );
    // M3 9h18
    canvas.drawLine(
      Offset(3 * scale, 9 * scale),
      Offset(21 * scale, 9 * scale),
      paint,
    );

    // Vertical lines
    // M12 9v6
    canvas.drawLine(
      Offset(12 * scale, 9 * scale),
      Offset(12 * scale, 15 * scale),
      paint,
    );
    // M16 15v6
    canvas.drawLine(
      Offset(16 * scale, 15 * scale),
      Offset(16 * scale, 21 * scale),
      paint,
    );
    // M16 3v6
    canvas.drawLine(
      Offset(16 * scale, 3 * scale),
      Offset(16 * scale, 9 * scale),
      paint,
    );
    // M8 15v6
    canvas.drawLine(
      Offset(8 * scale, 15 * scale),
      Offset(8 * scale, 21 * scale),
      paint,
    );
    // M8 3v6
    canvas.drawLine(
      Offset(8 * scale, 3 * scale),
      Offset(8 * scale, 9 * scale),
      paint,
    );
  }

  void _drawAnimatedBricks(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;

    // Draw outer rectangle
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Animate horizontal lines appearing from bottom to top
    // Bottom horizontal line (y=15) appears first (0-0.33)
    if (t > 0) {
      final lineT1 = (t * 3).clamp(0.0, 1.0);
      canvas.drawLine(
        Offset(3 * scale, 15 * scale),
        Offset((3 + 18 * lineT1) * scale, 15 * scale),
        paint,
      );
    }

    // Middle horizontal line (y=9) appears second (0.33-0.66)
    if (t > 0.33) {
      final lineT2 = ((t - 0.33) * 3).clamp(0.0, 1.0);
      canvas.drawLine(
        Offset(3 * scale, 9 * scale),
        Offset((3 + 18 * lineT2) * scale, 9 * scale),
        paint,
      );
    }

    // Vertical lines appear last (0.66-1.0)
    if (t > 0.66) {
      final vertT = ((t - 0.66) / 0.34).clamp(0.0, 1.0);

      // Bottom section verticals
      // M16 15v6
      final v1Height = 6 * vertT;
      canvas.drawLine(
        Offset(16 * scale, 15 * scale),
        Offset(16 * scale, (15 + v1Height) * scale),
        paint,
      );
      // M8 15v6
      canvas.drawLine(
        Offset(8 * scale, 15 * scale),
        Offset(8 * scale, (15 + v1Height) * scale),
        paint,
      );

      // Top section verticals
      // M16 3v6
      canvas.drawLine(
        Offset(16 * scale, 3 * scale),
        Offset(16 * scale, (3 + 6 * vertT) * scale),
        paint,
      );
      // M8 3v6
      canvas.drawLine(
        Offset(8 * scale, 3 * scale),
        Offset(8 * scale, (3 + 6 * vertT) * scale),
        paint,
      );

      // Middle vertical
      // M12 9v6
      canvas.drawLine(
        Offset(12 * scale, 9 * scale),
        Offset(12 * scale, (9 + 6 * vertT) * scale),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BrickWallPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
