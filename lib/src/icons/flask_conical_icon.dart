import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlaskConical icon.
class FlaskConicalIcon extends AnimatedSVGIcon {
  const FlaskConicalIcon({
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
  String get animationDescription => 'liquid sloshes and bubbles rise';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlaskConicalPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlaskConicalPainter extends CustomPainter {
  const _FlaskConicalPainter({
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
    final outline = Path()
      ..moveTo(14, 2)
      ..lineTo(14, 8)
      ..arcToPoint(const Offset(14.245, 8.96),
          radius: const Radius.circular(2), clockwise: false)
      ..lineTo(19.755, 19.04)
      ..arcToPoint(const Offset(18, 22), radius: const Radius.circular(2))
      ..lineTo(6, 22)
      ..arcToPoint(const Offset(4.245, 19.04), radius: const Radius.circular(2))
      ..lineTo(9.755, 8.96)
      ..arcToPoint(const Offset(10, 8),
          radius: const Radius.circular(2), clockwise: false)
      ..lineTo(10, 2)
      ..moveTo(8.5, 2)
      ..lineTo(15.5, 2);
    canvas.drawPath(outline, paint);
    final liquid = Path()
      ..moveTo(6.453, 15)
      ..quadraticBezierTo(12, 15 + t * 1.3, 17.547, 15);
    canvas.drawPath(liquid, paint);
    if (t > 0) {
      final bubblePaint = Paint()
        ..color = color.withValues(alpha: t)
        ..strokeWidth = strokeWidth / scale
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(10, 18 - t * 3), .45, bubblePaint);
      canvas.drawCircle(Offset(14.5, 19 - t * 4.5), .6, bubblePaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlaskConicalPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
