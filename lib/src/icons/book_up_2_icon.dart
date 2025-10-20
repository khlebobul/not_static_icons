import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Up 2 Icon - double arrow animation
class BookUp2Icon extends AnimatedSVGIcon {
  const BookUp2Icon({
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
  });

  @override
  String get animationDescription => 'BookUp2: double arrow animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookUp2Painter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookUp2Painter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookUp2Painter({
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
      _drawAnimatedArrows(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    
    // Vertical line: M12 13V7
    canvas.drawLine(
      Offset(12 * scale, 13 * scale),
      Offset(12 * scale, 7 * scale),
      paint,
    );

    // Upper arrow: m9 5 3-3 3 3
    final upperArrow = Path();
    upperArrow.moveTo(9 * scale, 5 * scale);
    upperArrow.relativeLineTo(3 * scale, -3 * scale);
    upperArrow.relativeLineTo(3 * scale, 3 * scale);
    canvas.drawPath(upperArrow, paint);

    // Lower arrow: m9 10 3-3 3 3
    final lowerArrow = Path();
    lowerArrow.moveTo(9 * scale, 10 * scale);
    lowerArrow.relativeLineTo(3 * scale, -3 * scale);
    lowerArrow.relativeLineTo(3 * scale, 3 * scale);
    canvas.drawPath(lowerArrow, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // M18 2h1a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
    final bookPath = Path();
    bookPath.moveTo(18 * scale, 2 * scale);
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

    // M4 19.5v-15A2.5 2.5 0 0 1 6.5 2
    bookPath.moveTo(4 * scale, 19.5 * scale);
    bookPath.lineTo(4 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(6.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedArrows(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;
    
    // Sequential animation: upper arrow then lower arrow
    final upperJump = progress < 0.5
        ? math.sin(progress * 2 * math.pi) * -1.5 * scale
        : 0.0;
    
    final lowerJump = progress > 0.4
        ? math.sin((progress - 0.4) / 0.6 * math.pi) * -1.5 * scale
        : 0.0;

    // Vertical line
    canvas.drawLine(
      Offset(12 * scale, 13 * scale),
      Offset(12 * scale, 7 * scale),
      paint,
    );

    // Upper arrow
    canvas.save();
    canvas.translate(0, upperJump);
    final upperArrow = Path();
    upperArrow.moveTo(9 * scale, 5 * scale);
    upperArrow.relativeLineTo(3 * scale, -3 * scale);
    upperArrow.relativeLineTo(3 * scale, 3 * scale);
    canvas.drawPath(upperArrow, paint);
    canvas.restore();

    // Lower arrow
    canvas.save();
    canvas.translate(0, lowerJump);
    final lowerArrow = Path();
    lowerArrow.moveTo(9 * scale, 10 * scale);
    lowerArrow.relativeLineTo(3 * scale, -3 * scale);
    lowerArrow.relativeLineTo(3 * scale, 3 * scale);
    canvas.drawPath(lowerArrow, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookUp2Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
