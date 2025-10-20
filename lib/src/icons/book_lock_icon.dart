import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Lock Icon - lock closing animation
class BookLockIcon extends AnimatedSVGIcon {
  const BookLockIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1400),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'BookLock: lock closing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookLockPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookLockPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookLockPainter({
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
      _drawLockBody(canvas, paint, scale);
      _drawAnimatedShackle(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawLockBody(canvas, paint, scale);

    // Draw complete shackle: M18 6V4a2 2 0 1 0-4 0v2
    final shacklePath = Path();
    shacklePath.moveTo(18 * scale, 6 * scale);
    shacklePath.lineTo(18 * scale, 4 * scale);
    shacklePath.arcToPoint(
      Offset(14 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
      largeArc: true,
    );
    shacklePath.lineTo(14 * scale, 6 * scale);
    canvas.drawPath(shacklePath, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // M20 15v6a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
    final bookPath = Path();
    bookPath.moveTo(20 * scale, 15 * scale);
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

    // M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H10
    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(10 * scale, 2 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawLockBody(Canvas canvas, Paint paint, double scale) {
    // rect x="12" y="6" width="8" height="5" rx="1"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(12 * scale, 6 * scale, 8 * scale, 5 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rect, paint);
  }

  void _drawAnimatedShackle(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Create the full path for the shackle
    final shacklePath = Path();
    shacklePath.moveTo(18 * scale, 6 * scale);
    shacklePath.lineTo(18 * scale, 4 * scale);
    shacklePath.arcToPoint(
      Offset(14 * scale, 4 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
      largeArc: true,
    );
    shacklePath.lineTo(14 * scale, 6 * scale);

    // Animate the drawing of the path
    final pathMetrics = shacklePath.computeMetrics().toList();
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
  bool shouldRepaint(_BookLockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
