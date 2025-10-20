import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Open Check Icon - checkmark drawing animation
class BookOpenCheckIcon extends AnimatedSVGIcon {
  const BookOpenCheckIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'BookOpenCheck: checkmark drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookOpenCheckPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookOpenCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookOpenCheckPainter({
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
      _drawAnimatedCheckmark(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);

    // Draw complete checkmark: m16 12 2 2 4-4
    final checkPath = Path();
    checkPath.moveTo(16 * scale, 12 * scale);
    checkPath.relativeLineTo(2 * scale, 2 * scale);
    checkPath.relativeLineTo(4 * scale, -4 * scale);
    canvas.drawPath(checkPath, paint);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // Center spine: M12 21V7
    canvas.drawLine(
      Offset(12 * scale, 21 * scale),
      Offset(12 * scale, 7 * scale),
      paint,
    );

    // Path: M22 6V4a1 1 0 0 0-1-1h-5a4 4 0 0 0-4 4 4 4 0 0 0-4-4H3a1 1 0 0 0-1 1v13a1 1 0 0 0 1 1h6a3 3 0 0 1 3 3 3 3 0 0 1 3-3h6a1 1 0 0 0 1-1v-1.3
    final bookPath = Path();

    // Right side
    bookPath.moveTo(22 * scale, 6 * scale);
    bookPath.lineTo(22 * scale, 4 * scale);
    bookPath.arcToPoint(
      Offset(21 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bookPath.lineTo(16 * scale, 3 * scale);
    bookPath.arcToPoint(
      Offset(12 * scale, 7 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );

    // Left top
    bookPath.arcToPoint(
      Offset(8 * scale, 3 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    bookPath.lineTo(3 * scale, 3 * scale);
    bookPath.arcToPoint(
      Offset(2 * scale, 4 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bookPath.lineTo(2 * scale, 17 * scale);
    bookPath.arcToPoint(
      Offset(3 * scale, 18 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bookPath.lineTo(9 * scale, 18 * scale);
    bookPath.arcToPoint(
      Offset(12 * scale, 21 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );

    // Bottom right
    bookPath.arcToPoint(
      Offset(15 * scale, 18 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    bookPath.lineTo(21 * scale, 18 * scale);
    bookPath.arcToPoint(
      Offset(22 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    bookPath.lineTo(22 * scale, 15.7 * scale);

    canvas.drawPath(bookPath, paint);
  }

  void _drawAnimatedCheckmark(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Path: m16 12 2 2 4-4
    // Phase 1: First part of check (0.0 - 0.5)
    if (progress > 0.0) {
      final firstProgress = (progress / 0.5).clamp(0.0, 1.0);
      final start = Offset(16 * scale, 12 * scale);
      final mid = Offset(18 * scale, 14 * scale);
      final current = Offset.lerp(start, mid, firstProgress)!;

      canvas.drawLine(start, current, paint);
    }

    // Phase 2: Second part of check (0.5 - 1.0)
    if (progress > 0.5) {
      final secondProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final mid = Offset(18 * scale, 14 * scale);
      final end = Offset(22 * scale, 10 * scale);
      final current = Offset.lerp(mid, end, secondProgress)!;

      canvas.drawLine(mid, current, paint);
    }
  }

  @override
  bool shouldRepaint(_BookOpenCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
