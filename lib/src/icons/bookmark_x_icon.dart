import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bookmark X Icon - X drawing animation
class BookmarkXIcon extends AnimatedSVGIcon {
  const BookmarkXIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
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
  String get animationDescription => 'BookmarkX: X drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookmarkXPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookmarkXPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkXPainter({
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
      _drawBookmarkOutline(canvas, paint, scale);
      _drawAnimatedX(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookmarkOutline(canvas, paint, scale);

    // First diagonal: m14.5 7.5-5 5
    canvas.drawLine(
      Offset(14.5 * scale, 7.5 * scale),
      Offset(9.5 * scale, 12.5 * scale),
      paint,
    );

    // Second diagonal: m9.5 7.5 5 5
    canvas.drawLine(
      Offset(9.5 * scale, 7.5 * scale),
      Offset(14.5 * scale, 12.5 * scale),
      paint,
    );
  }

  void _drawBookmarkOutline(Canvas canvas, Paint paint, double scale) {
    // Path: m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2Z
    final bookmarkPath = Path();

    bookmarkPath.moveTo(19 * scale, 21 * scale);
    bookmarkPath.relativeLineTo(-7 * scale, -4 * scale);
    bookmarkPath.relativeLineTo(-7 * scale, 4 * scale);
    bookmarkPath.lineTo(5 * scale, 5 * scale);
    bookmarkPath.arcToPoint(
      Offset(7 * scale, 3 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bookmarkPath.lineTo(17 * scale, 3 * scale);
    bookmarkPath.arcToPoint(
      Offset(19 * scale, 5 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    bookmarkPath.close();

    canvas.drawPath(bookmarkPath, paint);
  }

  void _drawAnimatedX(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Phase 1: First diagonal (\) (0.0 - 0.5)
    if (progress > 0.0) {
      final firstProgress = (progress / 0.5).clamp(0.0, 1.0);
      final start = Offset(14.5 * scale, 7.5 * scale);
      final end = Offset(9.5 * scale, 12.5 * scale);
      final current = Offset.lerp(start, end, firstProgress)!;

      canvas.drawLine(start, current, paint);
    }

    // Phase 2: Second diagonal (/) (0.5 - 1.0)
    if (progress > 0.5) {
      final secondProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final start = Offset(9.5 * scale, 7.5 * scale);
      final end = Offset(14.5 * scale, 12.5 * scale);
      final current = Offset.lerp(start, end, secondProgress)!;

      canvas.drawLine(start, current, paint);
    }
  }

  @override
  bool shouldRepaint(_BookmarkXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
