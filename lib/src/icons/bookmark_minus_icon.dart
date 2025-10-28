import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bookmark Minus Icon - minus line drawing from center
class BookmarkMinusIcon extends AnimatedSVGIcon {
  const BookmarkMinusIcon({
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
  });

  @override
  String get animationDescription =>
      'BookmarkMinus: minus line drawing from center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookmarkMinusPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookmarkMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkMinusPainter({
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
      _drawAnimatedMinus(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookmarkOutline(canvas, paint, scale);

    // Minus line: x1="15" x2="9" y1="10" y2="10"
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

  void _drawAnimatedMinus(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Draw line from center outwards
    final centerX = 12 * scale;
    final centerY = 10 * scale;

    final leftPoint = Offset.lerp(
      Offset(centerX, centerY),
      Offset(9 * scale, 10 * scale),
      progress,
    )!;

    final rightPoint = Offset.lerp(
      Offset(centerX, centerY),
      Offset(15 * scale, 10 * scale),
      progress,
    )!;

    canvas.drawLine(leftPoint, rightPoint, paint);
  }

  @override
  bool shouldRepaint(_BookmarkMinusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
