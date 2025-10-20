import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book X Icon - X drawing animation
class BookXIcon extends AnimatedSVGIcon {
  const BookXIcon({
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
  String get animationDescription => 'BookX: X drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookXPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookXPainter({
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
      _drawAnimatedX(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    
    // First diagonal: m14.5 7-5 5
    canvas.drawLine(
      Offset(14.5 * scale, 7 * scale),
      Offset(9.5 * scale, 12 * scale),
      paint,
    );
    
    // Second diagonal: m9.5 7 5 5
    canvas.drawLine(
      Offset(9.5 * scale, 7 * scale),
      Offset(14.5 * scale, 12 * scale),
      paint,
    );
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

  void _drawAnimatedX(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: First diagonal (\) (0.0 - 0.5)
    if (progress > 0.0) {
      final firstProgress = (progress / 0.5).clamp(0.0, 1.0);
      final start = Offset(14.5 * scale, 7 * scale);
      final end = Offset(9.5 * scale, 12 * scale);
      final current = Offset.lerp(start, end, firstProgress)!;
      
      canvas.drawLine(start, current, paint);
    }

    // Phase 2: Second diagonal (/) (0.5 - 1.0)
    if (progress > 0.5) {
      final secondProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final start = Offset(9.5 * scale, 7 * scale);
      final end = Offset(14.5 * scale, 12 * scale);
      final current = Offset.lerp(start, end, secondProgress)!;
      
      canvas.drawLine(start, current, paint);
    }
  }

  @override
  bool shouldRepaint(_BookXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
