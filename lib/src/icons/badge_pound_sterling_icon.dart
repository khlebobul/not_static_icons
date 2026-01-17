import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Pound Sterling Icon - Outline rotates around the pound symbol
class BadgePoundSterlingIcon extends BadgeBaseIcon {
  const BadgePoundSterlingIcon({
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
      "Badge pound sterling icon with a rotating outline around the pound symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgePoundSterlingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Pound Sterling icon
class BadgePoundSterlingPainter extends BadgeBasePainter {
  BadgePoundSterlingPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw middle horizontal line: <path d="M8 12h4"/>
    canvas.drawLine(
      Offset(8 * scale, 12 * scale),
      Offset(12 * scale, 12 * scale),
      paint,
    );

    // Draw vertical line with curve: <path d="M10 16V9.5a2.5 2.5 0 0 1 5 0"/>
    final verticalPath = Path();
    verticalPath.moveTo(10 * scale, 16 * scale);
    verticalPath.lineTo(10 * scale, 9.5 * scale);

    // a2.5 2.5 0 0 1 5 0
    verticalPath.arcToPoint(
      Offset(15 * scale, 9.5 * scale),
      radius: Radius.circular(2.5 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    canvas.drawPath(verticalPath, paint);

    // Draw bottom horizontal line: <path d="M8 16h7"/>
    canvas.drawLine(
      Offset(8 * scale, 16 * scale),
      Offset(15 * scale, 16 * scale),
      paint,
    );
  }
}
