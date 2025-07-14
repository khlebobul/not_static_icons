import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Alert Icon - Outline rotates around the alert symbol
class BadgeAlertIcon extends BadgeBaseIcon {
  const BadgeAlertIcon({
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
      "Badge alert icon with a rotating outline around the alert symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeAlertPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Alert icon
class BadgeAlertPainter extends BadgeBasePainter {
  BadgeAlertPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <line x1="12" x2="12" y1="8" y2="12"/>
    canvas.drawLine(
      Offset(centerX, 8 * scale),
      Offset(centerX, 12 * scale),
      paint,
    );

    // Draw dot: <line x1="12" x2="12.01" y1="16" y2="16"/>
    canvas.drawLine(
      Offset(centerX, 16 * scale),
      Offset(centerX + 0.01 * scale, 16 * scale),
      paint,
    );
  }
}
