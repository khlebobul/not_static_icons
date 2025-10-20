import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Check Icon - checkmark drawing animation
class BookCheckIcon extends AnimatedSVGIcon {
  const BookCheckIcon({
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
  String get animationDescription => 'BookCheck: checkmark drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookCheckPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookCheckPainter({
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
      // Draw complete book outline
      _drawBookOutline(canvas, paint, scale);

      // Draw animated checkmark
      _drawAnimatedCheckmark(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Path: m9 9.5 2 2 4-4
    final checkPath = Path()
      ..moveTo(9 * scale, 9.5 * scale)
      ..lineTo(11 * scale, 11.5 * scale)
      ..lineTo(15 * scale, 7.5 * scale);

    canvas.drawPath(checkPath, paint);
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

  void _drawAnimatedCheckmark(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Path: m9 9.5 2 2 4-4
    // First part: 9,9.5 to 11,11.5 (0.0 - 0.5)
    if (progress > 0.0) {
      final firstProgress = (progress / 0.5).clamp(0.0, 1.0);
      final start = Offset(9 * scale, 9.5 * scale);
      final mid = Offset(11 * scale, 11.5 * scale);
      final current = Offset.lerp(start, mid, firstProgress)!;

      canvas.drawLine(start, current, paint);
    }

    // Second part: 11,11.5 to 15,7.5 (0.5 - 1.0)
    if (progress > 0.5) {
      final secondProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final mid = Offset(11 * scale, 11.5 * scale);
      final end = Offset(15 * scale, 7.5 * scale);
      final current = Offset.lerp(mid, end, secondProgress)!;

      canvas.drawLine(mid, current, paint);
    }
  }

  @override
  bool shouldRepaint(_BookCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
