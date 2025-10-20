import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Book Heart Icon - heart pulsing animation
class BookHeartIcon extends AnimatedSVGIcon {
  const BookHeartIcon({
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
  String get animationDescription => 'BookHeart: heart pulsing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookHeartPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookHeartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookHeartPainter({
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
      _drawAnimatedHeart(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawHeart(canvas, paint, scale, 1.0);
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

  void _drawAnimatedHeart(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;
    
    // Pulsing effect: 3 beats
    final pulse = math.sin(progress * math.pi * 6) * 0.15 + 1.0;
    
    _drawHeart(canvas, paint, scale, pulse);
  }

  void _drawHeart(Canvas canvas, Paint paint, double scale, double pulseScale) {
    canvas.save();
    
    // Center of heart is approximately at (12, 10)
    final centerX = 12 * scale;
    final centerY = 10 * scale;
    
    canvas.translate(centerX, centerY);
    canvas.scale(pulseScale, pulseScale);
    canvas.translate(-centerX, -centerY);

    // Path: M8.62 9.8A2.25 2.25 0 1 1 12 6.836a2.25 2.25 0 1 1 3.38 2.966l-2.626 2.856a.998.998 0 0 1-1.507 0z
    final heartPath = Path();
    
    // Start at M8.62 9.8
    heartPath.moveTo(8.62 * scale, 9.8 * scale);
    
    // A2.25 2.25 0 1 1 12 6.836 (left arc - large arc, clockwise)
    heartPath.arcToPoint(
      Offset(12 * scale, 6.836 * scale),
      radius: Radius.circular(2.25 * scale),
      clockwise: true,
      largeArc: true,
    );
    
    // a2.25 2.25 0 1 1 3.38 2.966 (right arc - relative, large arc, clockwise)
    heartPath.relativeArcToPoint(
      Offset(3.38 * scale, 2.966 * scale),
      radius: Radius.circular(2.25 * scale),
      clockwise: true,
      largeArc: true,
    );
    
    // l-2.626 2.856 (line to bottom point)
    heartPath.relativeLineTo(-2.626 * scale, 2.856 * scale);
    
    // a.998.998 0 0 1-1.507 0 (small arc at bottom)
    heartPath.relativeArcToPoint(
      Offset(-1.507 * scale, 0),
      radius: Radius.circular(0.998 * scale),
      clockwise: true,
    );
    
    // z (close path)
    heartPath.close();

    canvas.drawPath(heartPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookHeartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
