import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge X Icon - Outline rotates around the X symbol
class BadgeXIcon extends BadgeBaseIcon {
  const BadgeXIcon({
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
      "Badge X icon with a rotating outline around the X symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeXPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge X icon
class BadgeXPainter extends BadgeBasePainter {
  BadgeXPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw first diagonal line: <line x1="15" x2="9" y1="9" y2="15"/>
    canvas.drawLine(
      Offset(15 * scale, 9 * scale),
      Offset(9 * scale, 15 * scale),
      paint,
    );

    // Draw second diagonal line: <line x1="9" x2="15" y1="9" y2="15"/>
    canvas.drawLine(
      Offset(9 * scale, 9 * scale),
      Offset(15 * scale, 15 * scale),
      paint,
    );
  }
}
