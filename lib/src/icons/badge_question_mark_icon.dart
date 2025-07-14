import 'package:flutter/material.dart';
import '../core/badge_base_icon.dart';

/// Animated Badge Question Mark Icon - Outline rotates around the question mark symbol
class BadgeQuestionMarkIcon extends BadgeBaseIcon {
  const BadgeQuestionMarkIcon({
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
      "Badge question mark icon with a rotating outline around the question mark symbol.";

  @override
  BadgeBasePainter createBadgePainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return BadgeQuestionMarkPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Badge Question Mark icon
class BadgeQuestionMarkPainter extends BadgeBasePainter {
  BadgeQuestionMarkPainter({
    required super.color,
    required super.animationValue,
    required super.strokeWidth,
  });

  @override
  void drawSymbol(Canvas canvas, Paint paint, double scale, double centerX,
      double centerY) {
    // Draw question mark curve: <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>
    final qPath = Path();
    qPath.moveTo(9.09 * scale, 9 * scale);

    // a3 3 0 0 1 5.83 1
    qPath.arcToPoint(
      Offset(14.92 * scale, 10 * scale),
      radius: Radius.circular(3 * scale),
      rotation: 0,
      largeArc: false,
      clockwise: true,
    );

    // c0 2-3 3-3 3
    qPath.cubicTo(
      14.92 * scale,
      12 * scale,
      11.92 * scale,
      13 * scale,
      11.92 * scale,
      13 * scale,
    );

    canvas.drawPath(qPath, paint);

    // Draw dot: <line x1="12" x2="12.01" y1="17" y2="17"/>
    canvas.drawLine(
      Offset(centerX, 17 * scale),
      Offset(centerX + 0.01 * scale, 17 * scale),
      paint,
    );
  }
}
