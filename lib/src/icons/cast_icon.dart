import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Cast Icon - expanding signal waves animation
class CastIcon extends AnimatedSVGIcon {
  const CastIcon({
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
  String get animationDescription => 'Cast: pulsing signal paths animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _CastPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CastPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CastPainter({
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
      _drawAnimated(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    // Screen path: M2 8V6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-6
    final screenPath = Path()
      ..moveTo(2 * scale, 8 * scale)
      ..lineTo(2 * scale, 6 * scale)
      ..arcToPoint(
        Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..relativeLineTo(16 * scale, 0)
      ..arcToPoint(
        Offset(22 * scale, 6 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(22 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(14 * scale, 20 * scale);
    canvas.drawPath(screenPath, paint);

    // Signal paths (static)
    _drawSignalPaths(canvas, paint, scale, 1.0);
  }

  void _drawSignalPaths(
      Canvas canvas, Paint paint, double scale, double alpha) {
    final signalPaint = Paint()
      ..color = color.withValues(alpha: alpha)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // M2 12a9 9 0 0 1 8 8
    final signal1 = Path()
      ..moveTo(2 * scale, 12 * scale)
      ..arcToPoint(
        Offset(10 * scale, 20 * scale),
        radius: Radius.circular(9 * scale),
        clockwise: true,
      );
    canvas.drawPath(signal1, signalPaint);

    // M2 16a5 5 0 0 1 4 4
    final signal2 = Path()
      ..moveTo(2 * scale, 16 * scale)
      ..arcToPoint(
        Offset(6 * scale, 20 * scale),
        radius: Radius.circular(5 * scale),
        clockwise: true,
      );
    canvas.drawPath(signal2, signalPaint);

    // M2 20 L2.01 20
    canvas.drawLine(
      Offset(2 * scale, 20 * scale),
      Offset(2.01 * scale, 20 * scale),
      signalPaint,
    );
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    // Draw screen (static)
    final screenPath = Path()
      ..moveTo(2 * scale, 8 * scale)
      ..lineTo(2 * scale, 6 * scale)
      ..arcToPoint(
        Offset(4 * scale, 4 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..relativeLineTo(16 * scale, 0)
      ..arcToPoint(
        Offset(22 * scale, 6 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(22 * scale, 18 * scale)
      ..arcToPoint(
        Offset(20 * scale, 20 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(14 * scale, 20 * scale);
    canvas.drawPath(screenPath, paint);

    // Pulsing signal paths - more noticeable animation like bluetooth_searching
    final progress = animationValue;
    final pulse = math.sin(progress * math.pi * 3) * 0.5 + 0.5;
    final alpha = 0.3 + pulse * 0.7; // Alpha from 0.3 to 1.0
    _drawSignalPaths(canvas, paint, scale, alpha);
  }

  @override
  bool shouldRepaint(_CastPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
