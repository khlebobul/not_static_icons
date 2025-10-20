import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Image Icon - image elements drawing animation
class BookImageIcon extends AnimatedSVGIcon {
  const BookImageIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'BookImage: image elements drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookImagePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookImagePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookImagePainter({
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
      _drawBookOutline(canvas, paint, scale);
      _drawAnimatedImage(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Draw circle: cx="10" cy="8" r="2"
    canvas.drawCircle(
      Offset(10 * scale, 8 * scale),
      2 * scale,
      paint,
    );

    // Draw image path: m20 13.7-2.1-2.1a2 2 0 0 0-2.8 0L9.7 17
    final imagePath = Path();
    imagePath.moveTo(20 * scale, 13.7 * scale);
    imagePath.relativeLineTo(-2.1 * scale, -2.1 * scale);
    imagePath.relativeArcToPoint(
      Offset(-2.8 * scale, 0),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    imagePath.lineTo(9.7 * scale, 17 * scale);
    canvas.drawPath(imagePath, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // Path: M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H19a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
    final bookPath = Path();

    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(19 * scale, 2 * scale);
    bookPath.arcToPoint(
      Offset(20 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 21 * scale);
    bookPath.arcToPoint(
      Offset(19 * scale, 22 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(6.5 * scale, 22 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(20 * scale, 17 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedImage(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: Draw circle (0.0 - 0.4)
    if (progress > 0.0) {
      final circleProgress = (progress / 0.4).clamp(0.0, 1.0);
      _drawCircleProgress(canvas, paint, scale, circleProgress);
    }

    // Phase 2: Draw diagonal line (0.4 - 1.0)
    if (progress > 0.4) {
      final lineProgress = ((progress - 0.4) / 0.6).clamp(0.0, 1.0);
      _drawImageLineProgress(canvas, paint, scale, lineProgress);
    }
  }

  void _drawCircleProgress(
      Canvas canvas, Paint paint, double scale, double progress) {
    final sweepAngle = progress * 2 * 3.14159;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(10 * scale, 8 * scale),
        radius: 2 * scale,
      ),
      -3.14159 / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  void _drawImageLineProgress(
      Canvas canvas, Paint paint, double scale, double progress) {
    // Path: m20 13.7-2.1-2.1a2 2 0 0 0-2.8 0L9.7 17
    final fullPath = Path();
    fullPath.moveTo(20 * scale, 13.7 * scale);
    fullPath.relativeLineTo(-2.1 * scale, -2.1 * scale);
    fullPath.relativeArcToPoint(
      Offset(-2.8 * scale, 0),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    fullPath.lineTo(9.7 * scale, 17 * scale);

    final pathMetrics = fullPath.computeMetrics().toList();
    if (pathMetrics.isNotEmpty) {
      final pathMetric = pathMetrics.first;
      final extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(_BookImagePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
