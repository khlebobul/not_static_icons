import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Russian Ruble Icon - Outline rotates around the ruble symbol
class BadgeRussianRubleIcon extends BadgeBaseIcon {
  const BadgeRussianRubleIcon({
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
      "Badge Russian ruble icon with a rotating outline around the ruble symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeRussianRublePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Russian Ruble icon
class BadgeRussianRublePainter extends BadgeBasePainter {
  BadgeRussianRublePainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw bottom horizontal line: <path d="M9 16h5"/>
    canvas.drawLine(
      Offset(9 * scale, 16 * scale),
      Offset(14 * scale, 16 * scale),
      paint,
    );

    // Draw vertical line with curve: <path d="M9 12h5a2 2 0 1 0 0-4h-3v9"/>
    final verticalPath = Path();
    verticalPath.moveTo(9 * scale, 12 * scale);
    verticalPath.lineTo(14 * scale, 12 * scale);

    // a2 2 0 1 0 0-4
    verticalPath.arcToPoint(
      Offset(14 * scale, 8 * scale),
      radius: Radius.circular(2 * scale),
      rotation: 0,
      largeArc: true,
      clockwise: false,
    );

    verticalPath.lineTo(11 * scale, 8 * scale);
    verticalPath.lineTo(11 * scale, 17 * scale);

    canvas.drawPath(verticalPath, paint);
  }
}
