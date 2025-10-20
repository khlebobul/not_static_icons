import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Plus Icon - plus drawing from center animation
class BookPlusIcon extends AnimatedSVGIcon {
  const BookPlusIcon({
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
  String get animationDescription =>
      'BookPlus: plus drawing from center animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookPlusPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookPlusPainter({
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
      _drawAnimatedPlus(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Vertical line: M12 7v6
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 13 * scale),
      paint,
    );

    // Horizontal line: M9 10h6
    canvas.drawLine(
      Offset(9 * scale, 10 * scale),
      Offset(15 * scale, 10 * scale),
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

  void _drawAnimatedPlus(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    final centerX = 12 * scale;
    final centerY = 10 * scale;

    // Phase 1: Vertical line expands from center (0.0 - 0.5)
    if (progress > 0.0) {
      final verticalProgress = (progress / 0.5).clamp(0.0, 1.0);

      final topPoint = Offset.lerp(
        Offset(centerX, centerY),
        Offset(12 * scale, 7 * scale),
        verticalProgress,
      )!;

      final bottomPoint = Offset.lerp(
        Offset(centerX, centerY),
        Offset(12 * scale, 13 * scale),
        verticalProgress,
      )!;

      canvas.drawLine(topPoint, bottomPoint, paint);
    }

    // Phase 2: Horizontal line expands from center (0.5 - 1.0)
    if (progress > 0.5) {
      final horizontalProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);

      final leftPoint = Offset.lerp(
        Offset(centerX, centerY),
        Offset(9 * scale, 10 * scale),
        horizontalProgress,
      )!;

      final rightPoint = Offset.lerp(
        Offset(centerX, centerY),
        Offset(15 * scale, 10 * scale),
        horizontalProgress,
      )!;

      canvas.drawLine(leftPoint, rightPoint, paint);
    }
  }

  @override
  bool shouldRepaint(_BookPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
