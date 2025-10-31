import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Braces Icon - opening braces animation
class BracesIcon extends AnimatedSVGIcon {
  const BracesIcon({
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
  String get animationDescription => 'Braces: opening braces animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BracesPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BracesPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BracesPainter({
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
    _drawLeftBrace(canvas, paint, scale, 0);
    _drawRightBrace(canvas, paint, scale, 0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    
    // Braces open (move outward)
    final spread = math.sin(t * math.pi) * 1.5 * scale;
    
    _drawLeftBrace(canvas, paint, scale, -spread);
    _drawRightBrace(canvas, paint, scale, spread);
  }

  void _drawLeftBrace(Canvas canvas, Paint paint, double scale, double xOffset) {
    canvas.save();
    canvas.translate(xOffset, 0);
    
    // M8 3H7a2 2 0 0 0-2 2v5a2 2 0 0 1-2 2 2 2 0 0 1 2 2v5c0 1.1.9 2 2 2h1
    final leftPath = Path()
      ..moveTo(8 * scale, 3 * scale)
      ..lineTo(7 * scale, 3 * scale)
      ..arcToPoint(
        Offset(5 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(5 * scale, 10 * scale)
      ..arcToPoint(
        Offset(3 * scale, 12 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(5 * scale, 14 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(5 * scale, 19 * scale)
      ..arcToPoint(
        Offset(7 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(8 * scale, 21 * scale);
    canvas.drawPath(leftPath, paint);
    
    canvas.restore();
  }

  void _drawRightBrace(Canvas canvas, Paint paint, double scale, double xOffset) {
    canvas.save();
    canvas.translate(xOffset, 0);
    
    // M16 21h1a2 2 0 0 0 2-2v-5c0-1.1.9-2 2-2a2 2 0 0 1-2-2V5a2 2 0 0 0-2-2h-1
    final rightPath = Path()
      ..moveTo(16 * scale, 21 * scale)
      ..lineTo(17 * scale, 21 * scale)
      ..arcToPoint(
        Offset(19 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(19 * scale, 14 * scale)
      ..arcToPoint(
        Offset(21 * scale, 12 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..arcToPoint(
        Offset(19 * scale, 10 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: true,
      )
      ..lineTo(19 * scale, 5 * scale)
      ..arcToPoint(
        Offset(17 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(16 * scale, 3 * scale);
    canvas.drawPath(rightPath, paint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BracesPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
