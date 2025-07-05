import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Album Icon - Bookmark moves up and down
class AlbumIcon extends AnimatedSVGIcon {
  const AlbumIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Bookmark moves up and down";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AlbumPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Album icon
class AlbumPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AlbumPainter({
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

    // ========== STATIC PART - ALBUM RECTANGLE ==========
    // rect width="18" height="18" x="3" y="3" rx="2" ry="2"
    final albumRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 3 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(albumRect, paint);

    // ========== ANIMATED PART - BOOKMARK ==========
    // Calculate vertical movement offset, limited to stay within album bounds
    // Album: y=3 to y=21, bookmark: y=3 to y=11 (height=8)
    // Maximum downward movement: album bottom (21) - bookmark bottom (11) = 10
    // But keep it subtle: use only 1 pixel downward movement
    final moveRange = 1.0; // pixels of downward movement (safe range)
    final moveOffset = (sin(animationValue * 2 * pi) + 1) * 0.5 * moveRange;

    // Create bookmark path with constrained animation offset
    // polyline points="11 3 11 11 14 8 17 11 17 3"
    final bookmarkPath = Path();
    bookmarkPath.moveTo(11 * scale, (3 + moveOffset) * scale);
    bookmarkPath.lineTo(11 * scale, (11 + moveOffset) * scale);
    bookmarkPath.lineTo(14 * scale, (8 + moveOffset) * scale);
    bookmarkPath.lineTo(17 * scale, (11 + moveOffset) * scale);
    bookmarkPath.lineTo(17 * scale, (3 + moveOffset) * scale);

    canvas.drawPath(bookmarkPath, paint);
  }

  @override
  bool shouldRepaint(AlbumPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
