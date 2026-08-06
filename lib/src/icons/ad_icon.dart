import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Ad icon.
class AdIcon extends AnimatedSVGIcon {
  const AdIcon({
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
  String get animationDescription => 'letters pop inside the ad frame';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _AdPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _AdPainter extends CustomPainter {
  const _AdPainter({
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
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(2, 5, 20, 14),
        const Radius.circular(2),
      ),
      paint,
    );

    canvas.save();
    canvas.translate(8, 13);
    canvas.scale(1 + t * .12, 1 - t * .12);
    canvas.translate(-8, -13);
    final a = Path()
      ..moveTo(10, 13)
      ..lineTo(6, 13)
      ..moveTo(10, 15)
      ..lineTo(10, 11)
      ..arcToPoint(
        const Offset(6, 11),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(6, 15);
    canvas.drawPath(a, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(16, 12);
    canvas.scale(1 - t * .16, 1 + t * .1);
    canvas.translate(-16, -12);
    final d = Path()
      ..moveTo(14, 14.5)
      ..arcToPoint(
        const Offset(14.5, 15),
        radius: const Radius.circular(.5),
        clockwise: false,
      )
      ..lineTo(15.5, 15)
      ..arcToPoint(
        const Offset(18, 12.5),
        radius: const Radius.circular(2.5),
        clockwise: false,
      )
      ..lineTo(18, 11.5)
      ..arcToPoint(
        const Offset(15.5, 9),
        radius: const Radius.circular(2.5),
        clockwise: false,
      )
      ..lineTo(14.5, 9)
      ..arcToPoint(
        const Offset(14, 9.5),
        radius: const Radius.circular(.5),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(d, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AdPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
