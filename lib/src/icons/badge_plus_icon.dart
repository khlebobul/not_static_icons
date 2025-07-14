import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Plus Icon - Outline rotates around the plus symbol
class BadgePlusIcon extends BadgeBaseIcon {
  const BadgePlusIcon({
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
      "Badge plus icon with a rotating outline around the plus symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgePlusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Plus icon
class BadgePlusPainter extends BadgeBasePainter {
  BadgePlusPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <line x1="12" x2="12" y1="8" y2="16"/>
    canvas.drawLine(
      Offset(centerX, 8 * scale),
      Offset(centerX, 16 * scale),
      paint,
    );

    // Draw horizontal line: <line x1="8" x2="16" y1="12" y2="12"/>
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );
  }
}
