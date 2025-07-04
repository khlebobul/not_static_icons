import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AmpersandsIcon extends AnimatedSVGIcon {
  const AmpersandsIcon({
    super.key,
    super.size,
    super.color,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
  });

  @override
  String get animationDescription =>
      'Initial static display, then fades out and redraws one after another on hover.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AmpersandsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class AmpersandsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AmpersandsPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  Path _createPath1(double scale) {
    final path = Path();
    path.moveTo(10 * scale, 17 * scale);
    path.relativeCubicTo(
      -5 * scale,
      -3 * scale,
      -7 * scale,
      -7 * scale,
      -7 * scale,
      -9 * scale,
    );
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      largeArc: false,
      clockwise: true,
    );
    path.relativeCubicTo(
      0,
      2.5 * scale,
      -5 * scale,
      2.5 * scale,
      -5 * scale,
      6 * scale,
    );
    path.relativeCubicTo(
      0,
      1.7 * scale,
      1.3 * scale,
      3 * scale,
      3 * scale,
      3 * scale,
    );
    path.relativeCubicTo(
      2.8 * scale,
      0,
      5 * scale,
      -2.2 * scale,
      5 * scale,
      -5 * scale,
    );
    return path;
  }

  Path _createPath2(double scale) {
    final path = Path();
    path.moveTo(22 * scale, 17 * scale);
    path.relativeCubicTo(
      -5 * scale,
      -3 * scale,
      -7 * scale,
      -7 * scale,
      -7 * scale,
      -9 * scale,
    );
    path.relativeArcToPoint(
      Offset(4 * scale, 0),
      radius: Radius.circular(2 * scale),
      largeArc: false,
      clockwise: true,
    );
    path.relativeCubicTo(
      0,
      2.5 * scale,
      -5 * scale,
      2.5 * scale,
      -5 * scale,
      6 * scale,
    );
    path.relativeCubicTo(
      0,
      1.7 * scale,
      1.3 * scale,
      3 * scale,
      3 * scale,
      3 * scale,
    );
    path.relativeCubicTo(
      2.8 * scale,
      0,
      5 * scale,
      -2.2 * scale,
      5 * scale,
      -5 * scale,
    );
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    final path1 = _createPath1(scale);
    final path2 = _createPath2(scale);

    // --- Animation Logic ---

    // Stage 1: Fade out the initial icon (animation 0.0 -> 0.2)
    final fadeOutOpacity = (1 - (animationValue / 0.2)).clamp(0.0, 1.0);
    if (fadeOutOpacity > 0) {
      final fadePaint = Paint()
        ..color = color.withValues(alpha: fadeOutOpacity)
        ..strokeWidth = strokeWidth
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
        ..strokeWidth = strokeWidth
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
  bool shouldRepaint(AmpersandsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
