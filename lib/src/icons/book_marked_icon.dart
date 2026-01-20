import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Marked Icon - bookmark sliding animation
class BookMarkedIcon extends AnimatedSVGIcon {
  const BookMarkedIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'BookMarked: bookmark sliding animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookMarkedPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookMarkedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookMarkedPainter({
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
      _drawAnimatedBookmark(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBookOutline(canvas, paint, scale);
    _drawBookmark(canvas, paint, scale, 0);
  }

  void _drawBookOutline(Canvas canvas, Paint paint, double scale) {
    // M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H19a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H6.5a1 1 0 0 1 0-5H20
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

  void _drawAnimatedBookmark(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Bookmark slides down and back up with reduced amplitude
    final slideOffset = progress < 0.5
        ? progress * 2 * 1 * scale // Slide down (amplitude reduced from 2 to 1)
        : (1 - (progress - 0.5) * 2) * 1 * scale; // Slide back up

    _drawBookmark(canvas, paint, scale, slideOffset);
  }

  void _drawBookmark(Canvas canvas, Paint paint, double scale, double yOffset) {
    canvas.save();
    canvas.translate(0, yOffset);

    // Path: M10 2v8l3-3 3 3V2
    final bookmarkPath = Path();
    bookmarkPath.moveTo(10 * scale, 2 * scale);
    bookmarkPath.lineTo(10 * scale, 10 * scale);
    bookmarkPath.relativeLineTo(3 * scale, -3 * scale);
    bookmarkPath.relativeLineTo(3 * scale, 3 * scale);
    bookmarkPath.lineTo(16 * scale, 2 * scale);

    canvas.drawPath(bookmarkPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookMarkedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
