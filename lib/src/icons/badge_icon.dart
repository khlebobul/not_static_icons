import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Icon - Just a rotating outline
class BadgeIcon extends BadgeBaseIcon {
  const BadgeIcon({
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
  String get animationDescription => "Badge icon with a rotating outline.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge icon
class BadgePainter extends BadgeBasePainter {
  BadgePainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // No symbol to draw for the basic badge
  }
}
