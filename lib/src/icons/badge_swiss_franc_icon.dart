import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Swiss Franc Icon - Outline rotates around the franc symbol
class BadgeSwissFrancIcon extends BadgeBaseIcon {
  const BadgeSwissFrancIcon({
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
      "Badge Swiss franc icon with a rotating outline around the franc symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeSwissFrancPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Swiss Franc icon
class BadgeSwissFrancPainter extends BadgeBasePainter {
  BadgeSwissFrancPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <path d="M11 17V8h4"/>
    final verticalPath = Path();
    verticalPath.moveTo(11 * scale, 17 * scale);
    verticalPath.lineTo(11 * scale, 8 * scale);
    verticalPath.lineTo(15 * scale, 8 * scale);

    canvas.drawPath(verticalPath, paint);

    // Draw middle horizontal line: <path d="M11 12h3"/>
    canvas.drawLine(
      Offset(11 * scale, 12 * scale),
      Offset(14 * scale, 12 * scale),
      paint,
    );

    // Draw bottom horizontal line: <path d="M9 16h4"/>
    canvas.drawLine(
      Offset(9 * scale, 16 * scale),
      Offset(13 * scale, 16 * scale),
      paint,
    );
  }
}
