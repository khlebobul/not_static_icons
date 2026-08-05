import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlagTriangleLeft icon.
class FlagTriangleLeftIcon extends AnimatedSVGIcon {
  const FlagTriangleLeftIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'triangle flag unfurls from its pole';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlagTriangleLeftPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlagTriangleLeftPainter extends CustomPainter {
  const _FlagTriangleLeftPainter({
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
    canvas.drawLine(const Offset(18, 22), const Offset(18, 2.8), paint);
    canvas.save();
    canvas.translate(18, 2.8);
    canvas.scale(1 - t * .28, 1 + t * .08);
    canvas.translate(-18, -2.8);
    final cloth = Path()
      ..moveTo(18, 2.8)
      ..arcToPoint(const Offset(16.83, 2.09),
          radius: const Radius.circular(.8), clockwise: false)
      ..lineTo(5.45, 7.78)
      ..arcToPoint(const Offset(5.45, 9.22),
          radius: const Radius.circular(.8), clockwise: false)
      ..lineTo(18, 15.5);
    canvas.drawPath(cloth, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlagTriangleLeftPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
