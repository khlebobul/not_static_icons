import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bookmark Plus Icon - plus drawing from center
class BookmarkPlusIcon extends AnimatedSVGIcon {
  const BookmarkPlusIcon({
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
  String get animationDescription => 'BookmarkPlus: plus drawing from center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookmarkPlusPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookmarkPlusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkPlusPainter({
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
      _drawAnimatedPlus(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookmarkOutline(canvas, paint, scale);

    // Vertical line: x1="12" x2="12" y1="7" y2="13"
    canvas.drawLine(
      Offset(12 * scale, 7 * scale),
      Offset(12 * scale, 13 * scale),
      paint,
    );

    // Horizontal line: x1="15" x2="9" y1="10" y2="10"
    canvas.drawLine(
      Offset(9 * scale, 10 * scale),
      Offset(15 * scale, 10 * scale),
      paint,
    );
  }

  void _drawBookmarkOutline(Canvas canvas, Paint paint, double scale) {
    // Path: m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z
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
  bool shouldRepaint(_BookmarkPlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
