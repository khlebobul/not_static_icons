import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Cent Icon - Outline rotates around the cent symbol
class BadgeCentIcon extends BadgeBaseIcon {
  const BadgeCentIcon({
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
  String get animationDescription =>
      "Badge cent icon with a rotating outline around the cent symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeCentPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Cent icon
class BadgeCentPainter extends BadgeBasePainter {
  BadgeCentPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <path d="M12 7v10"/>
    canvas.drawLine(
      Offset(centerX, 7 * scale),
      Offset(centerX, 17 * scale),
      paint,
    );

    // Draw C curve: <path d="M15.4 10a4 4 0 1 0 0 4"/>
    final cPath = Path();
    cPath.moveTo(15.4 * scale, 10 * scale);

    // a4 4 0 1 0 0 4
    cPath.arcToPoint(
      Offset(15.4 * scale, 14 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: true,
      clockwise: false,
    );

    canvas.drawPath(cPath, paint);
  }
}
