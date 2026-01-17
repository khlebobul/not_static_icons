import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Check Icon - Outline rotates around the check symbol
class BadgeCheckIcon extends BadgeBaseIcon {
  const BadgeCheckIcon({
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
      "Badge check icon with a rotating outline around the check mark.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Check icon
class BadgeCheckPainter extends BadgeBasePainter {
  BadgeCheckPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw check mark: <path d="m9 12 2 2 4-4"/>
    final checkPath = Path();
    checkPath.moveTo(9 * scale, 12 * scale);
    checkPath.lineTo(11 * scale, 14 * scale);
    checkPath.lineTo(15 * scale, 10 * scale);

    canvas.drawPath(checkPath, paint);
  }
}
