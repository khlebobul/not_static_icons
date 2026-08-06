import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated ClockArrowRight icon.
class ClockArrowRightIcon extends AnimatedSVGIcon {
  const ClockArrowRightIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 850),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'clock hands turn as time moves right';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _ClockArrowRightPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _ClockArrowRightPainter extends CustomPainter {
  const _ClockArrowRightPainter({
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
    final clock = Path()
      ..moveTo(13.5, 21.885)
      ..arcToPoint(
        const Offset(22, 12),
        radius: const Radius.circular(10),
        largeArc: true,
      );
    canvas.drawPath(clock, paint);

    canvas.save();
    canvas.translate(12, 12);
    canvas.rotate(t * .55);
    canvas.translate(-12, -12);
    final hands = Path()
      ..moveTo(12, 6)
      ..lineTo(12, 12)
      ..lineTo(14, 13);
    canvas.drawPath(hands, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(t * .7, 0);
    final arrow = Path()
      ..moveTo(14, 18)
      ..lineTo(22, 18)
      ..moveTo(18, 22)
      ..lineTo(22, 18)
      ..lineTo(18, 14);
    canvas.drawPath(arrow, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ClockArrowRightPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
