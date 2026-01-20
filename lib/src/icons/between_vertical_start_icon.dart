import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Between Vertical Start - two columns, arrow at top indicating start (↑)
class BetweenVerticalStartIcon extends AnimatedSVGIcon {
  const BetweenVerticalStartIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription =>
      'Arrow nudges upward to emphasize start direction';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BetweenVerticalStartPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BetweenVerticalStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BetweenVerticalStartPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    // Columns: <rect width="7" height="13" x="3" y="8"/>, x="14"
    final c1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 8 * scale, 7 * scale, 13 * scale),
      Radius.circular(1 * scale),
    );
    final c2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(14 * scale, 8 * scale, 7 * scale, 13 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(c1, paint);
    canvas.drawRRect(c2, paint);

    // Arrow: d="m15 2 -3 3 -3 -3" (points ↑). Animate a small nudge upwards.
    final nudge = 1.2 *
        scale *
        (animationValue == 0.0
            ? 0.0
            : (animationValue < 0.5
                ? (animationValue / 0.5)
                : (1 - (animationValue - 0.5) / 0.5)));
    final p = Path()
      ..moveTo(15 * scale, (2 - nudge) * scale)
      ..lineTo(12 * scale, (5 - nudge) * scale)
      ..lineTo(9 * scale, (2 - nudge) * scale);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(_BetweenVerticalStartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
