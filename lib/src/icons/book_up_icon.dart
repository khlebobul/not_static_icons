import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Up Icon - arrow jumping up animation
class BookUpIcon extends AnimatedSVGIcon {
  const BookUpIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'BookUp: arrow jumping up animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookUpPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookUpPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookUpPainter({
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
      _drawAnimatedArrow(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawArrow(canvas, paint, scale, 0);
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

  void _drawAnimatedArrow(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Jump up and return
    final jumpOffset = math.sin(progress * math.pi) * -2 * scale;

    _drawArrow(canvas, paint, scale, jumpOffset);
  }

  void _drawArrow(Canvas canvas, Paint paint, double scale, double yOffset) {
    canvas.save();
    canvas.translate(0, yOffset);

    // Vertical line: M12 13V7
    canvas.drawLine(
      Offset(12 * scale, 13 * scale),
      Offset(12 * scale, 7 * scale),
      paint,
    );

    // Arrow head: m9 10 3-3 3 3
    final arrowPath = Path();
    arrowPath.moveTo(9 * scale, 10 * scale);
    arrowPath.relativeLineTo(3 * scale, -3 * scale);
    arrowPath.relativeLineTo(3 * scale, 3 * scale);
    canvas.drawPath(arrowPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookUpPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
