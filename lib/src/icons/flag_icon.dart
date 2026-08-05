import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Flag icon.
class FlagIcon extends AnimatedSVGIcon {
  const FlagIcon({
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
  String get animationDescription => 'cloth ripples while the pole stays fixed';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlagPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlagPainter extends CustomPainter {
  const _FlagPainter({
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
    canvas.drawLine(const Offset(4, 22), const Offset(4, 4), paint);
    canvas.save();
    canvas.translate(4, 4);
    canvas.rotate(t * .06);
    canvas.scale(1 + t * .12, 1 - t * .05);
    canvas.translate(-4, -4);
    final cloth = Path()
      ..moveTo(4, 4)
      ..arcToPoint(const Offset(4.4, 3.2), radius: const Radius.circular(1))
      ..arcToPoint(const Offset(8, 2), radius: const Radius.circular(6))
      ..cubicTo(11, 2, 13, 4, 15.333, 4)
      ..quadraticBezierTo(17.333, 4, 18.4, 3.2)
      ..arcToPoint(const Offset(20, 4), radius: const Radius.circular(1))
      ..lineTo(20, 14)
      ..arcToPoint(const Offset(19.6, 14.8), radius: const Radius.circular(1))
      ..arcToPoint(const Offset(16, 16), radius: const Radius.circular(6))
      ..cubicTo(13, 16, 11, 14, 8, 14)
      ..arcToPoint(const Offset(4, 15.528),
          radius: const Radius.circular(6), clockwise: false);
    canvas.drawPath(cloth, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlagPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
