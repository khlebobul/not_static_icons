import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Flashlight icon.
class FlashlightIcon extends AnimatedSVGIcon {
  const FlashlightIcon({
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
  String get animationDescription => 'switch clicks and beam flashes';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlashlightPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlashlightPainter extends CustomPainter {
  const _FlashlightPainter({
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
      ..moveTo(17, 2)
      ..arcToPoint(const Offset(18, 3), radius: const Radius.circular(1))
      ..lineTo(18, 7)
      ..arcToPoint(const Offset(17.4, 8.8), radius: const Radius.circular(3))
      ..lineTo(16.8, 9.6)
      ..arcToPoint(const Offset(16, 12),
          radius: const Radius.circular(4), clockwise: false)
      ..lineTo(16, 20)
      ..arcToPoint(const Offset(14, 22), radius: const Radius.circular(2))
      ..lineTo(10, 22)
      ..arcToPoint(const Offset(8, 20), radius: const Radius.circular(2))
      ..lineTo(8, 12)
      ..arcToPoint(const Offset(7.2, 9.6),
          radius: const Radius.circular(4), clockwise: false)
      ..lineTo(6.6, 8.8)
      ..arcToPoint(const Offset(6, 7), radius: const Radius.circular(3))
      ..lineTo(6, 3)
      ..arcToPoint(const Offset(7, 2), radius: const Radius.circular(1))
      ..close()
      ..moveTo(6, 6)
      ..lineTo(18, 6);
    canvas.drawPath(path, paint);
    canvas.drawLine(Offset(12, 13 + t), Offset(12, 14 - t * .25), paint);
    if (t > 0) {
      final beamPaint = Paint()
        ..color = color.withValues(alpha: t)
        ..strokeWidth = strokeWidth / scale
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawLine(const Offset(6, 3), Offset(3 - t, 1), beamPaint);
      canvas.drawLine(const Offset(18, 3), Offset(21 + t, 1), beamPaint);
      canvas.drawLine(const Offset(12, 2), Offset(12, 1 - t), beamPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlashlightPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
