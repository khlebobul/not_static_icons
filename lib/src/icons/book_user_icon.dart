import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book User Icon - user icon drawing animation
class BookUserIcon extends AnimatedSVGIcon {
  const BookUserIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1600),
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
  String get animationDescription => 'BookUser: user icon drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookUserPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookUserPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookUserPainter({
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
      _drawAnimatedUser(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Circle: cx="12" cy="8" r="2"
    canvas.drawCircle(
      Offset(12 * scale, 8 * scale),
      2 * scale,
      paint,
    );

    // Arc: M15 13a3 3 0 1 0-6 0
    final arcPath = Path();
    arcPath.moveTo(15 * scale, 13 * scale);
    arcPath.arcToPoint(
      Offset(9 * scale, 13 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: false,
      largeArc: true,
    );
    canvas.drawPath(arcPath, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
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

  void _drawAnimatedUser(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: Draw circle (head) (0.0 - 0.5)
    if (progress > 0.0) {
      final circleProgress = (progress / 0.5).clamp(0.0, 1.0);
      final sweepAngle = circleProgress * 2 * 3.14159;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(12 * scale, 8 * scale),
          radius: 2 * scale,
        ),
        -3.14159 / 2,
        sweepAngle,
        false,
        paint,
      );
    }

    // Phase 2: Draw arc (shoulders) (0.5 - 1.0)
    if (progress > 0.5) {
      final arcProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);

      final arcPath = Path();
      arcPath.moveTo(15 * scale, 13 * scale);
      arcPath.arcToPoint(
        Offset(9 * scale, 13 * scale),
        radius: Radius.circular(3 * scale),
        clockwise: false,
        largeArc: true,
      );

      final pathMetrics = arcPath.computeMetrics().toList();
      if (pathMetrics.isNotEmpty) {
        final pathMetric = pathMetrics.first;
        final extractPath = pathMetric.extractPath(
          0.0,
          pathMetric.length * arcProgress,
        );
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_BookUserPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
