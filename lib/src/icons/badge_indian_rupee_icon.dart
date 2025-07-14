import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Indian Rupee Icon - Outline rotates around the rupee symbol
class BadgeIndianRupeeIcon extends BadgeBaseIcon {
  const BadgeIndianRupeeIcon({
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
      "Badge Indian rupee icon with a rotating outline around the rupee symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeIndianRupeePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Indian Rupee icon
class BadgeIndianRupeePainter extends BadgeBasePainter {
  BadgeIndianRupeePainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw top horizontal line: <path d="M8 8h8"/>
    canvas.drawLine(
      Offset(8 * scale, 8 * scale),
      Offset(16 * scale, 8 * scale),
      paint,
    );

    // Draw middle horizontal line: <path d="M8 12h8"/>
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );

    // Draw the rupee symbol: <path d="m13 17-5-1h1a4 4 0 0 0 0-8"/>
    final rupeePath = Path();
    rupeePath.moveTo(13 * scale, 17 * scale);
    rupeePath.lineTo(8 * scale, 16 * scale);
    rupeePath.lineTo(9 * scale, 16 * scale);

    // a4 4 0 0 0 0-8
    rupeePath.arcToPoint(
      Offset(9 * scale, 8 * scale),
      radius: Radius.circular(4 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: false,
    );

    canvas.drawPath(rupeePath, paint);
  }
}
