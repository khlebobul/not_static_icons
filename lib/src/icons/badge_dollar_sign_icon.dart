import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Dollar Sign Icon - Outline rotates around the dollar sign symbol
class BadgeDollarSignIcon extends BadgeBaseIcon {
  const BadgeDollarSignIcon({
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
      "Badge dollar sign icon with a rotating outline around the dollar sign symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeDollarSignPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Dollar Sign icon
class BadgeDollarSignPainter extends BadgeBasePainter {
  BadgeDollarSignPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw vertical line: <path d="M12 18V6"/>
    canvas.drawLine(
      Offset(12 * scale, 6 * scale),
      Offset(12 * scale, 18 * scale),
      paint,
    );

    // Draw S curve using Bezier curves for accuracy
    // Path: <path d="M16 8h-6a2 2 0 1 0 0 4h4a2 2 0 1 1 0 4H8"/>
    final sCurvePath = Path();
    sCurvePath.moveTo(16 * scale, 8 * scale);
    sCurvePath.lineTo(10 * scale, 8 * scale);

    // Top curve
    sCurvePath.cubicTo(
        8 * scale, 8 * scale, 8 * scale, 12 * scale, 10 * scale, 12 * scale);

    // Middle line
    sCurvePath.lineTo(14 * scale, 12 * scale);

    // Bottom curve
    sCurvePath.cubicTo(
        16 * scale, 12 * scale, 16 * scale, 16 * scale, 14 * scale, 16 * scale);

    // Final line
    sCurvePath.lineTo(8 * scale, 16 * scale);

    canvas.drawPath(sCurvePath, paint);
  }
}
