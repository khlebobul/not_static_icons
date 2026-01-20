import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bookmark Check Icon - checkmark drawing animation
class BookmarkCheckIcon extends AnimatedSVGIcon {
  const BookmarkCheckIcon({
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
  String get animationDescription =>
      'BookmarkCheck: checkmark drawing animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookmarkCheckPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookmarkCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkCheckPainter({
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
      _drawAnimatedCheckmark(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookmarkOutline(canvas, paint, scale);

    // Checkmark: m9 10 2 2 4-4
    final checkPath = Path();
    checkPath.moveTo(9 * scale, 10 * scale);
    checkPath.relativeLineTo(2 * scale, 2 * scale);
    checkPath.relativeLineTo(4 * scale, -4 * scale);
    canvas.drawPath(checkPath, paint);
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

  void _drawAnimatedCheckmark(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // First stroke: bottom-left to middle (0.0 - 0.5)
    if (progress > 0.0) {
      final firstProgress = (progress / 0.5).clamp(0.0, 1.0);
      final start = Offset(9 * scale, 10 * scale);
      final end = Offset(11 * scale, 12 * scale);
      final current = Offset.lerp(start, end, firstProgress)!;

      canvas.drawLine(start, current, paint);
    }

    // Second stroke: middle to top-right (0.5 - 1.0)
    if (progress > 0.5) {
      final secondProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
      final start = Offset(11 * scale, 12 * scale);
      final end = Offset(15 * scale, 8 * scale);
      final current = Offset.lerp(start, end, secondProgress)!;

      canvas.drawLine(start, current, paint);
    }
  }

  @override
  bool shouldRepaint(_BookmarkCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
