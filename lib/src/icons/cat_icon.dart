import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Cat Icon - blinking eyes animation
class CatIcon extends AnimatedSVGIcon {
  const CatIcon({
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
  String get animationDescription => 'Cat: blinking eyes animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _CatPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _CatPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CatPainter({
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
    // Main cat head: M12 5c.67 0 1.35.09 2 .26 1.78-2 5.03-2.84 6.42-2.26 1.4.58-.42 7-.42 7 .57 1.07 1 2.24 1 3.44C21 17.9 16.97 21 12 21s-9-3-9-7.56c0-1.25.5-2.4 1-3.44 0 0-1.89-6.42-.5-7 1.39-.58 4.72.23 6.5 2.23A9.04 9.04 0 0 1 12 5Z
    final headPath = Path()
      ..moveTo(12 * scale, 5 * scale)
      ..cubicTo(
        12.67 * scale, 5 * scale,
        13.35 * scale, 5.09 * scale,
        14 * scale, 5.26 * scale,
      )
      ..cubicTo(
        15.78 * scale, 3.26 * scale,
        19.03 * scale, 2.16 * scale,
        20.42 * scale, 2.74 * scale,
      )
      ..cubicTo(
        21.82 * scale, 3.32 * scale,
        20.58 * scale, 10 * scale,
        20.58 * scale, 10 * scale,
      )
      ..cubicTo(
        21.65 * scale, 11.07 * scale,
        22 * scale, 12.24 * scale,
        22 * scale, 13.44 * scale,
      )
      ..cubicTo(
        22 * scale, 17.9 * scale,
        16.97 * scale, 21 * scale,
        12 * scale, 21 * scale,
      )
      ..cubicTo(
        7.03 * scale, 21 * scale,
        3 * scale, 17.9 * scale,
        3 * scale, 13.44 * scale,
      )
      ..cubicTo(
        3 * scale, 12.19 * scale,
        3.5 * scale, 11.04 * scale,
        4 * scale, 10 * scale,
      )
      ..cubicTo(
        4 * scale, 10 * scale,
        2.11 * scale, 3.58 * scale,
        3.5 * scale, 3 * scale,
      )
      ..cubicTo(
        4.89 * scale, 2.42 * scale,
        8.22 * scale, 3.23 * scale,
        10 * scale, 5.23 * scale,
      )
      ..cubicTo(
        10.65 * scale, 5.09 * scale,
        11.33 * scale, 5 * scale,
        12 * scale, 5 * scale,
      )
      ..close();
    canvas.drawPath(headPath, paint);

    // Left eye: M8 14v.5
    canvas.drawLine(
      Offset(8 * scale, 14 * scale),
      Offset(8 * scale, 14.5 * scale),
      paint,
    );

    // Right eye: M16 14v.5
    canvas.drawLine(
      Offset(16 * scale, 14 * scale),
      Offset(16 * scale, 14.5 * scale),
      paint,
    );

    // Mouth: M11.25 16.25h1.5L12 17l-.75-.75Z
    final mouthPath = Path()
      ..moveTo(11.25 * scale, 16.25 * scale)
      ..lineTo(12.75 * scale, 16.25 * scale)
      ..lineTo(12 * scale, 17 * scale)
      ..lineTo(11.25 * scale, 16.25 * scale)
      ..close();
    canvas.drawPath(mouthPath, paint);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    // Draw static head
    final headPath = Path()
      ..moveTo(12 * scale, 5 * scale)
      ..cubicTo(
        12.67 * scale, 5 * scale,
        13.35 * scale, 5.09 * scale,
        14 * scale, 5.26 * scale,
      )
      ..cubicTo(
        15.78 * scale, 3.26 * scale,
        19.03 * scale, 2.16 * scale,
        20.42 * scale, 2.74 * scale,
      )
      ..cubicTo(
        21.82 * scale, 3.32 * scale,
        20.58 * scale, 10 * scale,
        20.58 * scale, 10 * scale,
      )
      ..cubicTo(
        21.65 * scale, 11.07 * scale,
        22 * scale, 12.24 * scale,
        22 * scale, 13.44 * scale,
      )
      ..cubicTo(
        22 * scale, 17.9 * scale,
        16.97 * scale, 21 * scale,
        12 * scale, 21 * scale,
      )
      ..cubicTo(
        7.03 * scale, 21 * scale,
        3 * scale, 17.9 * scale,
        3 * scale, 13.44 * scale,
      )
      ..cubicTo(
        3 * scale, 12.19 * scale,
        3.5 * scale, 11.04 * scale,
        4 * scale, 10 * scale,
      )
      ..cubicTo(
        4 * scale, 10 * scale,
        2.11 * scale, 3.58 * scale,
        3.5 * scale, 3 * scale,
      )
      ..cubicTo(
        4.89 * scale, 2.42 * scale,
        8.22 * scale, 3.23 * scale,
        10 * scale, 5.23 * scale,
      )
      ..cubicTo(
        10.65 * scale, 5.09 * scale,
        11.33 * scale, 5 * scale,
        12 * scale, 5 * scale,
      )
      ..close();
    canvas.drawPath(headPath, paint);

    // Animate blinking eyes
    final t = animationValue;
    // Blink happens quickly in the middle of animation
    final blinkProgress = math.sin(t * math.pi);
    final eyeHeight = blinkProgress < 0.3 ? 0.0 : 0.5 * scale;

    // Left eye
    if (eyeHeight > 0) {
      canvas.drawLine(
        Offset(8 * scale, 14 * scale),
        Offset(8 * scale, 14 * scale + eyeHeight),
        paint,
      );
    }

    // Right eye
    if (eyeHeight > 0) {
      canvas.drawLine(
        Offset(16 * scale, 14 * scale),
        Offset(16 * scale, 14 * scale + eyeHeight),
        paint,
      );
    }

    // Draw mouth (static)
    final mouthPath = Path()
      ..moveTo(11.25 * scale, 16.25 * scale)
      ..lineTo(12.75 * scale, 16.25 * scale)
      ..lineTo(12 * scale, 17 * scale)
      ..lineTo(11.25 * scale, 16.25 * scale)
      ..close();
    canvas.drawPath(mouthPath, paint);
  }

  @override
  bool shouldRepaint(_CatPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

