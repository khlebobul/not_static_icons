import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Copy Icon - copy sliding animation
class BookCopyIcon extends AnimatedSVGIcon {
  const BookCopyIcon({
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
  String get animationDescription => 'BookCopy: copy sliding animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BookCopyPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BookCopyPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookCopyPainter({
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
      // Draw back book (always visible)
      _drawBackBook(canvas, paint, scale);

      // Draw front book with sliding animation
      _drawAnimatedFrontBook(canvas, paint, scale);
    }
  }

  void _drawCompleteIcon(Canvas canvas, Paint paint, double scale) {
    _drawBackBook(canvas, paint, scale);

    // Draw front book without animation
    final frontPath = Path();
    frontPath.moveTo(9 * scale, 15 * scale);
    frontPath.lineTo(9 * scale, 4 * scale);
    frontPath.arcToPoint(
      Offset(11 * scale, 2 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    frontPath.lineTo(20.5 * scale, 2 * scale);
    frontPath.arcToPoint(
      Offset(21 * scale, 2.5 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    frontPath.lineTo(21 * scale, 16.5 * scale);
    frontPath.arcToPoint(
      Offset(20.5 * scale, 17 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    frontPath.lineTo(11 * scale, 17 * scale);
    frontPath.arcToPoint(
      Offset(11 * scale, 13 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    frontPath.lineTo(21 * scale, 13 * scale);

    canvas.drawPath(frontPath, paint);
  }

  void _drawBackBook(Canvas canvas, Paint paint, double scale) {
    // Path: M5 7a2 2 0 0 0-2 2v11
    final backPath = Path();
    backPath.moveTo(5 * scale, 7 * scale);
    backPath.arcToPoint(
      Offset(3 * scale, 9 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    backPath.lineTo(3 * scale, 20 * scale);

    // Path: M5.803 18H5a2 2 0 0 0 0 4h9.5a.5.5 0 0 0 .5-.5V21
    backPath.moveTo(5.803 * scale, 18 * scale);
    backPath.lineTo(5 * scale, 18 * scale);
    backPath.arcToPoint(
      Offset(5 * scale, 22 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: false,
    );
    backPath.lineTo(14.5 * scale, 22 * scale);
    backPath.arcToPoint(
      Offset(15 * scale, 21.5 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: false,
    );
    backPath.lineTo(15 * scale, 21 * scale);

    canvas.drawPath(backPath, paint);
  }

  void _drawAnimatedFrontBook(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Slide to the right and back
    final slideOffset = progress < 0.5
        ? progress * 2 * 2 * scale // Slide right
        : (1 - (progress - 0.5) * 2) * 2 * scale; // Slide back

    canvas.save();
    canvas.translate(slideOffset, 0);

    // Path: M9 15V4a2 2 0 0 1 2-2h9.5a.5.5 0 0 1 .5.5v14a.5.5 0 0 1-.5.5H11a2 2 0 0 1 0-4h10
    final frontPath = Path();

    frontPath.moveTo(9 * scale, 15 * scale);
    frontPath.lineTo(9 * scale, 4 * scale);
    frontPath.arcToPoint(
      Offset(11 * scale, 2 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    frontPath.lineTo(20.5 * scale, 2 * scale);
    frontPath.arcToPoint(
      Offset(21 * scale, 2.5 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    frontPath.lineTo(21 * scale, 16.5 * scale);
    frontPath.arcToPoint(
      Offset(20.5 * scale, 17 * scale),
      radius: Radius.circular(0.5 * scale),
      clockwise: true,
    );
    frontPath.lineTo(11 * scale, 17 * scale);
    frontPath.arcToPoint(
      Offset(11 * scale, 13 * scale),
      radius: Radius.circular(2 * scale),
      clockwise: true,
    );
    frontPath.lineTo(21 * scale, 13 * scale);

    canvas.drawPath(frontPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookCopyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
