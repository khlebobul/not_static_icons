import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Bitcoin Icon - coin shine animation
class BitcoinIcon extends AnimatedSVGIcon {
  const BitcoinIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Bitcoin: sparkle stars animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BitcoinPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BitcoinPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BitcoinPainter({
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

    // Draw complete static icon
    _drawCompleteIcon(canvas, paint, scale);

    // Add shine animation
    if (animationValue > 0.0) {
      _drawShineEffect(canvas, size, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Parse the SVG path step by step:
    // M11.767 19.089c4.924.868 6.14-6.025 1.216-6.894m-1.216 6.894L5.86 18.047m5.908 1.042-.347 1.97m1.563-8.864c4.924.869 6.14-6.025 1.215-6.893m-1.215 6.893-3.94-.694m5.155-6.2L8.29 4.26m5.908 1.042.348-1.97M7.48 20.364l3.126-17.727

    final path = Path();

    // M11.767 19.089c4.924.868 6.14-6.025 1.216-6.894
    path.moveTo(11.767 * scale, 19.089 * scale);
    path.relativeCubicTo(4.924 * scale, 0.868 * scale, 6.14 * scale,
        -6.025 * scale, 1.216 * scale, -6.894 * scale);

    // m-1.216 6.894L5.86 18.047
    path.relativeMoveTo(-1.216 * scale, 6.894 * scale);
    path.lineTo(5.86 * scale, 18.047 * scale);

    // m5.908 1.042-.347 1.97
    path.relativeMoveTo(5.908 * scale, 1.042 * scale);
    path.relativeLineTo(-0.347 * scale, 1.97 * scale);

    // m1.563-8.864c4.924.869 6.14-6.025 1.215-6.893
    path.relativeMoveTo(1.563 * scale, -8.864 * scale);
    path.relativeCubicTo(4.924 * scale, 0.869 * scale, 6.14 * scale,
        -6.025 * scale, 1.215 * scale, -6.893 * scale);

    // m-1.215 6.893-3.94-.694
    path.relativeMoveTo(-1.215 * scale, 6.893 * scale);
    path.relativeLineTo(-3.94 * scale, -0.694 * scale);

    // m5.155-6.2L8.29 4.26
    path.relativeMoveTo(5.155 * scale, -6.2 * scale);
    path.lineTo(8.29 * scale, 4.26 * scale);

    // m5.908 1.042.348-1.97
    path.relativeMoveTo(5.908 * scale, 1.042 * scale);
    path.relativeLineTo(0.348 * scale, -1.97 * scale);

    // M7.48 20.364l3.126-17.727
    path.moveTo(7.48 * scale, 20.364 * scale);
    path.relativeLineTo(3.126 * scale, -17.727 * scale);

    canvas.drawPath(path, paint);
  }

  void _drawShineEffect(Canvas canvas, Size size, double scale) {
    final progress = animationValue;

    // Add sparkle effect
    if (progress > 0.3) {
      final sparkleProgress = (progress - 0.3) / 0.7;
      final sparkleAlpha = math.sin(sparkleProgress * math.pi * 2) * 0.8 + 0.2;

      final sparklePaint = Paint()
        ..color = color.withValues(alpha: sparkleAlpha)
        ..strokeWidth = strokeWidth * 0.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Draw small sparkles around the icon
      final sparklePositions = [
        Offset(size.width * 0.2, size.height * 0.3), // Left star
        Offset(size.width * 0.8, size.height * 0.2), // Right star 1
        Offset(size.width * 0.9, size.height * 0.5), // Right star 2
      ];

      for (final pos in sparklePositions) {
        // Draw small cross sparkle
        canvas.drawLine(
          Offset(pos.dx - 2 * scale, pos.dy),
          Offset(pos.dx + 2 * scale, pos.dy),
          sparklePaint,
        );
        canvas.drawLine(
          Offset(pos.dx, pos.dy - 2 * scale),
          Offset(pos.dx, pos.dy + 2 * scale),
          sparklePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_BitcoinPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
