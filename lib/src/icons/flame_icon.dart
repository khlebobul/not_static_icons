import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Flame icon.
class FlameIcon extends AnimatedSVGIcon {
  const FlameIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 650),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'tip bends while an ember rises';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlamePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlamePainter extends CustomPainter {
  const _FlamePainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  final Color color;
  final double animationValue;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth / scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.scale(scale);
    final t = 4 * animationValue * (1 - animationValue);
    final path = Path()
      ..moveTo(12 + t * 1.2, 3 - t)
      ..quadraticBezierTo(13 + t * .5, 7, 16, 9.5)
      ..quadraticBezierTo(19, 12, 19, 15)
      ..arcToPoint(const Offset(5, 15), radius: const Radius.circular(1))
      ..arcToPoint(const Offset(6, 12), radius: const Radius.circular(5))
      ..arcToPoint(const Offset(11, 12),
          radius: const Radius.circular(1), clockwise: false)
      ..cubicTo(11, 10, 9.5, 9, 9.5, 7)
      ..quadraticBezierTo(9.5, 5, 12 + t * 1.2, 3 - t)
      ..close();
    canvas.drawPath(path, paint);
    if (t > 0) {
      final emberPaint = Paint()
        ..color = color.withValues(alpha: t)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(8.5 + t, 13 - t * 4), .45, emberPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlamePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
