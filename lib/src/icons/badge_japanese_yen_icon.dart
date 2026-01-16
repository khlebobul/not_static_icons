import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Japanese Yen Icon - Outline rotates around the yen symbol
class BadgeJapaneseYenIcon extends BadgeBaseIcon {
  const BadgeJapaneseYenIcon({
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
      "Badge Japanese yen icon with a rotating outline around the yen symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeJapaneseYenPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Japanese Yen icon
class BadgeJapaneseYenPainter extends BadgeBasePainter {
  BadgeJapaneseYenPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw left diagonal: <path d="m9 8 3 3v7"/>
    final leftPath = Path();
    leftPath.moveTo(9 * scale, 8 * scale);
    leftPath.lineTo(12 * scale, 11 * scale);
    leftPath.lineTo(12 * scale, 18 * scale);
    canvas.drawPath(leftPath, paint);

    // Draw right diagonal: <path d="m12 11 3-3"/>
    canvas.drawLine(
      Offset(12 * scale, 11 * scale),
      Offset(15 * scale, 8 * scale),
      paint,
    );

    // Draw top horizontal line: <path d="M9 12h6"/>
    canvas.drawLine(
      Offset(9 * scale, 12 * scale),
      Offset(15 * scale, 12 * scale),
      paint,
    );

    // Draw bottom horizontal line: <path d="M9 16h6"/>
    canvas.drawLine(
      Offset(9 * scale, 16 * scale),
      Offset(15 * scale, 16 * scale),
      paint,
    );
  }
}
