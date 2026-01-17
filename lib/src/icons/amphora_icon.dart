import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

class AmphoraIcon extends AnimatedSVGIcon {
  const AmphoraIcon({
    super.key,
    super.size,
    super.color,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      'On hover, the handles of the amphora are drawn sequentially.';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AmphoraPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class AmphoraPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AmphoraPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  // Path functions using exact SVG commands
  Path _createBodyLeftPath(double scale) {
    final path = Path();
    path.moveTo(10 * scale, 2 * scale);
    path.relativeLineTo(0, 5.632 * scale);
    path.relativeCubicTo(
      0,
      0.424 * scale,
      -0.272 * scale,
      0.795 * scale,
      -0.653 * scale,
      0.982 * scale,
    );
    path.arcToPoint(
      Offset(6 * scale, 14 * scale),
      radius: Radius.circular(6 * scale),
      largeArc: false,
      clockwise: false,
    );
    path.relativeCubicTo(
      0.006 * scale,
      4 * scale,
      3 * scale,
      7 * scale,
      5 * scale,
      8 * scale,
    );
    return path;
  }

  Path _createHandleLeftPath(double scale) {
    final path = Path();
    path.moveTo(10 * scale, 5 * scale);
    path.relativeLineTo(-2 * scale, 0);
    path.relativeArcToPoint(
      Offset(0, 4 * scale),
      radius: Radius.circular(2 * scale),
      largeArc: false,
      clockwise: false,
    );
    path.relativeLineTo(0.68 * scale, 0);
    return path;
  }

  Path _createBodyRightPath(double scale) {
    final path = Path();
    path.moveTo(14 * scale, 2 * scale);
    path.relativeLineTo(0, 5.632 * scale);
    path.relativeCubicTo(
      0,
      0.424 * scale,
      0.272 * scale,
      0.795 * scale,
      0.652 * scale,
      0.982 * scale,
    );
    path.arcToPoint(
      Offset(18 * scale, 14 * scale),
      radius: Radius.circular(6 * scale),
      largeArc: false,
      clockwise: true,
    );
    path.relativeCubicTo(
      0,
      4 * scale,
      -3 * scale,
      7 * scale,
      -5 * scale,
      8 * scale,
    );
    return path;
  }

  Path _createHandleRightPath(double scale) {
    final path = Path();
    path.moveTo(14 * scale, 5 * scale);
    path.relativeLineTo(2 * scale, 0);
    path.relativeArcToPoint(
      Offset(0, 4 * scale),
      radius: Radius.circular(2 * scale),
      largeArc: false,
      clockwise: true,
    );
    path.relativeLineTo(-0.68 * scale, 0);
    return path;
  }

  Path _createBasePath(double scale) {
    final path = Path();
    path.moveTo(18 * scale, 22 * scale);
    path.lineTo(6 * scale, 22 * scale);
    return path;
  }

  Path _createTopPath(double scale) {
    final path = Path();
    path.moveTo(9 * scale, 2 * scale);
    path.relativeLineTo(6 * scale, 0);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final bodyLeft = _createBodyLeftPath(scale);
    final handleLeft = _createHandleLeftPath(scale);
    final bodyRight = _createBodyRightPath(scale);
    final handleRight = _createHandleRightPath(scale);
    final base = _createBasePath(scale);
    final top = _createTopPath(scale);

    final allPaths = [bodyLeft, handleLeft, bodyRight, handleRight, base, top];

    // --- Animation Logic ---

    // Stage 1: Fade out (0.0 -> 0.2)
    final fadeOutOpacity = (1 - (animationValue / 0.2)).clamp(0.0, 1.0);
    if (fadeOutOpacity > 0) {
      final fadePaint = Paint()
        ..color = color.withValues(alpha: fadeOutOpacity)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      for (final path in allPaths) {
        canvas.drawPath(path, fadePaint);
      }
    }

    // Stage 2: Draw (0.2 -> 1.0)
    if (animationValue > 0.2) {
      final drawAnimationValue = (animationValue - 0.2) / 0.8;

      // Draw static parts
      canvas.drawPath(bodyLeft, paint);
      canvas.drawPath(bodyRight, paint);
      canvas.drawPath(base, paint);
      canvas.drawPath(top, paint);

      final leftHandleMetric = handleLeft.computeMetrics().first;
      final rightHandleMetric = handleRight.computeMetrics().first;

      // Draw left handle (0.0 -> 0.5)
      final leftHandleProgress = (drawAnimationValue / 0.5).clamp(0.0, 1.0);
      if (leftHandleProgress > 0) {
        final leftPath = leftHandleMetric.extractPath(
          0,
          leftHandleMetric.length * leftHandleProgress,
        );
        canvas.drawPath(leftPath, paint);
      }

      // Draw right handle (0.5 -> 1.0)
      if (drawAnimationValue > 0.5) {
        final rightHandleProgress = ((drawAnimationValue - 0.5) / 0.5).clamp(
          0.0,
          1.0,
        );
        if (rightHandleProgress > 0) {
          final rightPath = rightHandleMetric.extractPath(
            0,
            rightHandleMetric.length * rightHandleProgress,
          );
          canvas.drawPath(rightPath, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(AmphoraPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
