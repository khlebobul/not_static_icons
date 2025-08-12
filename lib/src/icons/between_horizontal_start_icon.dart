import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Between Horizontal Start - two stacked blocks on the right, arrow at left indicating start (←)
class BetweenHorizontalStartIcon extends AnimatedSVGIcon {
  const BetweenHorizontalStartIcon({
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
  });

  @override
  String get animationDescription =>
      'Arrow nudges to the left to emphasize start direction';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BetweenHorizontalStartPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BetweenHorizontalStartPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BetweenHorizontalStartPainter({
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

    // Right blocks: <rect width="13" height="7" x="8" y="3"/>, y="14"
    final r1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 3 * scale, 13 * scale, 7 * scale),
      Radius.circular(1 * scale),
    );
    final r2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 14 * scale, 13 * scale, 7 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(r1, paint);
    canvas.drawRRect(r2, paint);

    // Arrow: d="m2 9 3 3 -3 3" (points ←). Animate a small nudge to the left.
    final nudge = 1.2 *
        scale *
        (animationValue == 0.0
            ? 0.0
            : (animationValue < 0.5
                ? (animationValue / 0.5)
                : (1 - (animationValue - 0.5) / 0.5)));
    final p = Path()
      ..moveTo((2 - nudge) * scale, 9 * scale)
      ..lineTo((5 - nudge) * scale, 12 * scale)
      ..lineTo((2 - nudge) * scale, 15 * scale);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(_BetweenHorizontalStartPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
