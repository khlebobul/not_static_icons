import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Euro Icon - Outline rotates around the euro symbol
class BadgeEuroIcon extends BadgeBaseIcon {
  const BadgeEuroIcon({
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
      "Badge euro icon with a rotating outline around the euro symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeEuroPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Euro icon
class BadgeEuroPainter extends BadgeBasePainter {
  BadgeEuroPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw horizontal line: <path d="M7 12h5"/>
    canvas.drawLine(
      Offset(7 * scale, 12 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );

    // Draw C curve: <path d="M15 9.4a4 4 0 1 0 0 5.2"/>
    final cPath = Path();
    cPath.moveTo(15 * scale, 9.4 * scale);

    // a4 4 0 1 0 0 5.2
    cPath.arcToPoint(
      Offset(15 * scale, 14.6 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: true,
      clockwise: false,
    );

    canvas.drawPath(cPath, paint);
  }
}
