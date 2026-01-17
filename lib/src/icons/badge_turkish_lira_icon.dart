import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Turkish Lira Icon - Outline rotates around the lira symbol
class BadgeTurkishLiraIcon extends BadgeBaseIcon {
  const BadgeTurkishLiraIcon({
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
      "Badge Turkish lira icon with a rotating outline around the lira symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeTurkishLiraPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Turkish Lira icon
class BadgeTurkishLiraPainter extends BadgeBasePainter {
  BadgeTurkishLiraPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line with curve: <path d="M11 7v10a5 5 0 0 0 5-5"/>
    final liraPath = Path();

    // Start with vertical line
    liraPath.moveTo(11 * scale, 7 * scale);
    liraPath.lineTo(11 * scale, 17 * scale);

    // Draw the curve to the right (a5 5 0 0 0 5-5)
    // This is a curve that goes from (11,17) to (16,12)
    liraPath.cubicTo(
      13 * scale, 17 * scale, // first control point
      16 * scale, 15 * scale, // second control point
      16 * scale, 12 * scale, // end point
    );

    canvas.drawPath(liraPath, paint);

    // Draw horizontal strike-through line: <path d="m15 8-6 3"/>
    canvas.drawLine(
      Offset(15 * scale, 8 * scale),
      Offset(9 * scale, 11 * scale),
      paint,
    );
  }
}
