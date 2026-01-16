import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Info Icon - Outline rotates around the info symbol
class BadgeInfoIcon extends BadgeBaseIcon {
  const BadgeInfoIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 3000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      "Badge info icon with a rotating outline around the info symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeInfoPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Info icon
class BadgeInfoPainter extends BadgeBasePainter {
  BadgeInfoPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <line x1="12" x2="12" y1="16" y2="12"/>
    canvas.drawLine(
      Offset(centerX, 12 * scale),
      Offset(centerX, 16 * scale),
      paint,
    );

    // Draw dot: <line x1="12" x2="12.01" y1="8" y2="8"/>
    canvas.drawLine(
      Offset(centerX, 8 * scale),
      Offset(centerX + 0.01 * scale, 8 * scale),
      paint,
    );
  }
}
