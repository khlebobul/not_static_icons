import 'package:flutter/material.dart';
import 'animated_svg_icon_base.dart';
import 'dart:math';

/// Base class for all badge icons with rotating outline
abstract class BadgeBaseIcon extends AnimatedSVGIcon {
  const BadgeBaseIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 3000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return createBadgePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }

  /// Create the specific badge painter
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  });
}

/// Base painter for all badge icons
abstract class BadgeBasePainter extends CustomPainter {
  final Color color;
  final double animationValue; // 0.0 to 1.0
  final double strokeWidth;

  BadgeBasePainter({
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

    // Center of the icon
    final centerX = 12.0 * scale;
    final centerY = 12.0 * scale;

    // Draw the static symbol in the center
    drawSymbol(canvas, paint, scale, centerX, centerY);

    // Draw the rotating outline
    drawRotatingOutline(canvas, paint, scale, centerX, centerY, animationValue);
  }

  /// Draw the specific symbol for each badge type
  void drawSymbol(
      Canvas canvas, Paint paint, double scale, double centerX, double centerY);

  /// Draw the rotating outline - same for all badge icons
  void drawRotatingOutline(Canvas canvas, Paint paint, double scale,
      double centerX, double centerY, double animValue) {
    // Save the canvas state
    canvas.save();

    // Translate to center, rotate, then translate back
    canvas.translate(centerX, centerY);
    canvas.rotate(animValue * 2 * pi);
    canvas.translate(-centerX, -centerY);

    // Draw the octagonal outline
    // <path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/>
    final outlinePath = Path();
    outlinePath.moveTo(3.85 * scale, 8.62 * scale);

    // a4 4 0 0 1 4.78-4.77
    outlinePath.arcToPoint(
      Offset(8.63 * scale, 3.85 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1 6.74 0
    outlinePath.arcToPoint(
      Offset(15.37 * scale, 3.85 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1 4.78 4.78
    outlinePath.arcToPoint(
      Offset(20.15 * scale, 8.63 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1 0 6.74
    outlinePath.arcToPoint(
      Offset(20.15 * scale, 15.37 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1-4.77 4.78
    outlinePath.arcToPoint(
      Offset(15.38 * scale, 20.15 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1-6.75 0
    outlinePath.arcToPoint(
      Offset(8.63 * scale, 20.15 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1-4.78-4.77
    outlinePath.arcToPoint(
      Offset(3.85 * scale, 15.38 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // a4 4 0 0 1 0-6.76
    outlinePath.arcToPoint(
      Offset(3.85 * scale, 8.62 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // Z
    outlinePath.close();

    canvas.drawPath(outlinePath, paint);

    // Restore the canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(BadgeBasePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
