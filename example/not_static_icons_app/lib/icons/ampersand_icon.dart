import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AmpersandIcon extends AnimatedSVGIcon {
  const AmpersandIcon({super.key, super.size, super.color});

  @override
  String get animationDescription =>
      'Initial static display, then fades out and redraws on hover.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
  }) {
    return AmpersandPainter(color: color, animationValue: animationValue);
  }
}

class AmpersandPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AmpersandPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    // Manually scaled paths to keep stroke width consistent
    final path1 = Path();
    path1.moveTo(17.5 * scale, 12 * scale);
    path1.relativeCubicTo(
      0,
      4.4 * scale,
      -3.6 * scale,
      8 * scale,
      -8 * scale,
      8 * scale,
    );
    path1.arcToPoint(
      Offset(5 * scale, 15.5 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
      largeArc: false,
    );
    path1.relativeCubicTo(
      0,
      -6 * scale,
      8 * scale,
      -4 * scale,
      8 * scale,
      -8.5 * scale,
    );
    path1.arcToPoint(
      Offset(7.5 * scale, 7.0 * scale), // Target for arc
      radius: Radius.circular(3 * scale),
      clockwise: false,
      largeArc: false,
    );
    path1.relativeCubicTo(
      0,
      3 * scale,
      2.5 * scale,
      8.5 * scale,
      12 * scale,
      13 * scale,
    );

    final path2 = Path()
      ..moveTo(16 * scale, 12 * scale)
      ..relativeLineTo(3 * scale, 0);

    // --- Animation Logic ---

    // Stage 1: Fade out the initial icon (animation 0.0 -> 0.2)
    // The icon is fully visible at animationValue=0 and fades out as it approaches 0.2.
    final fadeOutOpacity = (1 - (animationValue / 0.2)).clamp(0.0, 1.0);
    if (fadeOutOpacity > 0) {
      final fadePaint = Paint()
        ..color = color.withValues(alpha: fadeOutOpacity)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path1, fadePaint);
      canvas.drawPath(path2, fadePaint);
    }

    // Stage 2: Draw the icon (animation 0.2 -> 1.0)
    if (animationValue > 0.2) {
      // Remap animationValue from (0.2..1.0) to (0.0..1.0) for drawing
      final drawAnimationValue = (animationValue - 0.2) / 0.8;

      final paint = Paint()
        ..color = color
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path1Metrics = path1.computeMetrics().first;
      final path2Metrics = path2.computeMetrics().first;
      final totalLength = path1Metrics.length + path2Metrics.length;
      final currentLength = drawAnimationValue * totalLength;

      if (currentLength <= path1Metrics.length) {
        final animatedPath = path1Metrics.extractPath(0, currentLength);
        canvas.drawPath(animatedPath, paint);
      } else {
        canvas.drawPath(path1, paint); // Draw the first path completely
        final remainingLength = currentLength - path1Metrics.length;
        if (remainingLength > 0) {
          final animatedPath = path2Metrics.extractPath(0, remainingLength);
          canvas.drawPath(animatedPath, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(AmpersandPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
