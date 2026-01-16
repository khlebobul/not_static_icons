import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Book Search Icon - Magnifying glass pulses
class BookSearchIcon extends AnimatedSVGIcon {
  const BookSearchIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Magnifying glass pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BookSearchPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Book Search icon
class BookSearchPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  BookSearchPainter({
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

    // Animation
    final oscillation = 4 * animationValue * (1 - animationValue);

    // ========== BOOK ==========
    // M3 19.5v-15A2.5 2.5 0 0 1 5.5 2H18a1 1 0 0 1 1 1v8
    final bookPath = Path();
    bookPath.moveTo(3 * scale, 19.5 * scale);
    bookPath.lineTo(3 * scale, 4.5 * scale);
    bookPath.arcToPoint(
      Offset(5.5 * scale, 2 * scale),
      radius: Radius.circular(2.5 * scale),
      clockwise: true,
    );
    bookPath.lineTo(18 * scale, 2 * scale);
    bookPath.arcToPoint(
      Offset(19 * scale, 3 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bookPath.lineTo(19 * scale, 11 * scale);
    canvas.drawPath(bookPath, paint);

    // M11 22H5.5a1 1 0 0 1 0-5h4.501
    final bottomPath = Path();
    bottomPath.moveTo(11 * scale, 22 * scale);
    bottomPath.lineTo(5.5 * scale, 22 * scale);
    bottomPath.arcToPoint(
      Offset(5.5 * scale, 17 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: true,
    );
    bottomPath.lineTo(10 * scale, 17 * scale);
    canvas.drawPath(bottomPath, paint);

    // ========== MAGNIFYING GLASS ==========
    // circle cx="17" cy="18" r="3" - animated scale
    final magScale = 1.0 + oscillation * 0.2;
    canvas.drawCircle(
      Offset(17 * scale, 18 * scale),
      3 * scale * magScale,
      paint,
    );

    // m21 22-1.879-1.878 - handle
    canvas.drawLine(
      Offset(21 * scale, 22 * scale),
      Offset(19.121 * scale, 20.122 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(BookSearchPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
