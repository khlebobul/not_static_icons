import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Minus Icon - Outline rotates around the minus symbol
class BadgeMinusIcon extends BadgeBaseIcon {
  const BadgeMinusIcon({
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
      "Badge minus icon with a rotating outline around the minus symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeMinusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Minus icon
class BadgeMinusPainter extends BadgeBasePainter {
  BadgeMinusPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw horizontal line: <line x1="8" x2="16" y1="12" y2="12"/>
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(16 * scale, 12 * scale),
      paint,
    );
  }
}
