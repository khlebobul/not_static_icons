import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Percent Icon - Outline rotates around the percent symbol
class BadgePercentIcon extends BadgeBaseIcon {
  const BadgePercentIcon({
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
      "Badge percent icon with a rotating outline around the percent symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgePercentPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Percent icon
class BadgePercentPainter extends BadgeBasePainter {
  BadgePercentPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw diagonal line: <path d="m15 9-6 6"/>
    canvas.drawLine(
      Offset(15 * scale, 9 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );

    // Draw top dot: <path d="M9 9h.01"/>
    canvas.drawLine(
      Offset(9 * scale, 9 * scale),
      Offset(9.01 * scale, 9 * scale),
      paint,
    );

    // Draw bottom dot: <path d="M15 15h.01"/>
    canvas.drawLine(
      Offset(15 * scale, 15 * scale),
      Offset(15.01 * scale, 15 * scale),
      paint,
    );
  }
}
