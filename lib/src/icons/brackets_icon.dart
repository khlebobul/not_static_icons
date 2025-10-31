import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Brackets Icon - opening brackets animation
class BracketsIcon extends AnimatedSVGIcon {
  const BracketsIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1300),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Brackets: opening brackets animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) => _BracketsPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BracketsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BracketsPainter({
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
    _drawLeftBracket(canvas, paint, scale, 0);
    _drawRightBracket(canvas, paint, scale, 0);
  }

  void _drawAnimated(Canvas canvas, Paint paint, double scale) {
    final t = animationValue;
    
    // Brackets open (move outward)
    final spread = math.sin(t * math.pi) * 1.5 * scale;
    
    _drawLeftBracket(canvas, paint, scale, -spread);
    _drawRightBracket(canvas, paint, scale, spread);
  }

  void _drawLeftBracket(Canvas canvas, Paint paint, double scale, double xOffset) {
    canvas.save();
    canvas.translate(xOffset, 0);
    
    // M8 21H5a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h3
    final leftPath = Path()
      ..moveTo(8 * scale, 21 * scale)
      ..lineTo(5 * scale, 21 * scale)
      ..arcToPoint(
        Offset(4 * scale, 20 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(4 * scale, 4 * scale)
      ..arcToPoint(
        Offset(5 * scale, 3 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(8 * scale, 3 * scale);
    canvas.drawPath(leftPath, paint);
    
    canvas.restore();
  }

  void _drawRightBracket(Canvas canvas, Paint paint, double scale, double xOffset) {
    canvas.save();
    canvas.translate(xOffset, 0);
    
    // M16 3h3a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-3
    final rightPath = Path()
      ..moveTo(16 * scale, 3 * scale)
      ..lineTo(19 * scale, 3 * scale)
      ..arcToPoint(
        Offset(20 * scale, 4 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(20 * scale, 20 * scale)
      ..arcToPoint(
        Offset(19 * scale, 21 * scale),
        radius: Radius.circular(1 * scale),
        clockwise: true,
      )
      ..lineTo(16 * scale, 21 * scale);
    canvas.drawPath(rightPath, paint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BracketsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
