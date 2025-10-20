import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Text Icon - text lines drawing animation
class BookTextIcon extends AnimatedSVGIcon {
  const BookTextIcon({
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
  String get animationDescription => 'BookText: text lines drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookTextPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookTextPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookTextPainter({
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
      _drawAnimatedText(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    
    // Top line: M8 7h6
    canvas.drawLine(
      Offset(8 * scale, 7 * scale),
      Offset(14 * scale, 7 * scale),
      paint,
    );
    
    // Bottom line: M8 11h8
    canvas.drawLine(
      Offset(8 * scale, 11 * scale),
      Offset(16 * scale, 11 * scale),
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

  void _drawAnimatedText(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Top line draws first (0.0 - 0.5)
    if (progress > 0.0) {
      final topProgress = (progress / 0.5).clamp(0.0, 1.0);
      final topEnd = Offset.lerp(
        Offset(8 * scale, 7 * scale),
        Offset(14 * scale, 7 * scale),
        topProgress,
      )!;
      
      canvas.drawLine(
        Offset(8 * scale, 7 * scale),
        topEnd,
        paint,
      );
    }

    // Bottom line draws second (0.5 - 1.0)
    if (progress > 0.5) {
      final bottomProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final bottomEnd = Offset.lerp(
        Offset(8 * scale, 11 * scale),
        Offset(16 * scale, 11 * scale),
        bottomProgress,
      )!;
      
      canvas.drawLine(
        Offset(8 * scale, 11 * scale),
        bottomEnd,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BookTextPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
