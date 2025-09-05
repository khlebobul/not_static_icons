import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Blocks Icon - square joining animation
class BlocksIcon extends AnimatedSVGIcon {
  const BlocksIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Blocks: square joining animation';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BlocksPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BlocksPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BlocksPainter({
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

    // Draw static main block
    _drawMainBlock(canvas, paint, scale);

    // Draw animated small square
    _drawAnimatedSquare(canvas, paint, scale);
  }

  void _drawMainBlock(Canvas canvas, Paint paint, double scale) {
    // Main block path: M10 22V7a1 1 0 0 0-1-1H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-5a1 1 0 0 0-1-1H2
    final mainPath = Path()
      ..moveTo(10 * scale, 22 * scale)
      ..lineTo(10 * scale, 7 * scale)
      ..arcToPoint(Offset(9 * scale, 6 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(4 * scale, 6 * scale)
      ..arcToPoint(Offset(2 * scale, 8 * scale),
          radius: Radius.circular(2 * scale), clockwise: false)
      ..lineTo(2 * scale, 20 * scale)
      ..arcToPoint(Offset(4 * scale, 22 * scale),
          radius: Radius.circular(2 * scale), clockwise: false)
      ..lineTo(16 * scale, 22 * scale)
      ..arcToPoint(Offset(18 * scale, 20 * scale),
          radius: Radius.circular(2 * scale), clockwise: false)
      ..lineTo(18 * scale, 15 * scale)
      ..arcToPoint(Offset(17 * scale, 14 * scale),
          radius: Radius.circular(1 * scale), clockwise: false)
      ..lineTo(2 * scale, 14 * scale);

    canvas.drawPath(mainPath, paint);
  }

  void _drawAnimatedSquare(Canvas canvas, Paint paint, double scale) {
    final progress = animationValue;

    // Calculate square position and size based on animation
    double squareX, squareY, squareSize;

    if (progress < 0.5) {
      // First half: square moves from original position to fill the gap
      final moveProgress = progress * 2;

      // Original position: x="14" y="2" width="8" height="8"
      final originalX = 14 * scale;
      final originalY = 2 * scale;
      final originalSize = 8 * scale;

      // Target position: exactly where the gap is in the main block
      // The gap is at the top-right corner of the main block
      final targetX = 10 * scale; // Align with the vertical line
      final targetY = 6 * scale; // Fill the gap at the top
      final targetSize = 8 * scale; // Same size as original

      squareX = originalX + (targetX - originalX) * moveProgress;
      squareY = originalY + (targetY - originalY) * moveProgress;
      squareSize = originalSize + (targetSize - originalSize) * moveProgress;
    } else {
      // Second half: square returns to original position
      final returnProgress = (progress - 0.5) * 2;

      // From target position back to original
      final originalX = 14 * scale;
      final originalY = 2 * scale;
      final originalSize = 8 * scale;

      final targetX = 10 * scale;
      final targetY = 6 * scale;
      final targetSize = 8 * scale;

      squareX = targetX + (originalX - targetX) * returnProgress;
      squareY = targetY + (originalY - targetY) * returnProgress;
      squareSize = targetSize + (originalSize - targetSize) * returnProgress;
    }

    // Draw animated square with rounded corners
    final squareRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(squareX, squareY, squareSize, squareSize),
      Radius.circular(1 * scale),
    );

    canvas.drawRRect(squareRect, paint);

    // Add connection line when square is close to main block
    if (progress > 0.3 && progress < 0.7) {
      final connectionAlpha = math.sin((progress - 0.3) / 0.4 * math.pi);
      final connectionPaint = Paint()
        ..color = color.withValues(alpha: connectionAlpha * 0.6)
        ..strokeWidth = strokeWidth * 0.8
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Draw connection line from square to main block
      final connectionStart = Offset(squareX, squareY + squareSize / 2);
      final connectionEnd = Offset(10 * scale, 7 * scale);

      canvas.drawLine(connectionStart, connectionEnd, connectionPaint);
    }
  }

  @override
  bool shouldRepaint(_BlocksPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
