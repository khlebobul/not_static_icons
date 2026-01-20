import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';
import 'dart:math' as math;

/// Animated Bookmark Icon - sliding down animation
class BookmarkIcon extends AnimatedSVGIcon {
  const BookmarkIcon({
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
  String get animationDescription => 'Bookmark: sliding down animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookmarkPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookmarkPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkPainter({
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
      _drawAnimatedBookmark(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookmark(canvas, paint, scale, 0);
  }

  void _drawAnimatedBookmark(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Slide down and return with sine wave
    final slideOffset = math.sin(progress * math.pi) * -1.5 * scale;

    _drawBookmark(canvas, paint, scale, slideOffset);
  }

  void _drawBookmark(Canvas canvas, Paint paint, double scale, double yOffset) {
    canvas.save();
    canvas.translate(0, yOffset);

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
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookmarkPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
