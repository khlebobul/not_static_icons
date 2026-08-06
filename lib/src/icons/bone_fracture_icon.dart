import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated BoneFracture icon.
class BoneFractureIcon extends AnimatedSVGIcon {
  const BoneFractureIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 750),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'fractured halves separate and snap back';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BoneFracturePainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BoneFracturePainter extends CustomPainter {
  const _BoneFracturePainter({
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
    canvas.save();
    canvas.translate(t * .55, -t * .55);
    final upper = Path()
      ..moveTo(14, 4.5)
      ..arcToPoint(const Offset(19, 4.5), radius: const Radius.circular(1))
      ..arcToPoint(const Offset(19.5, 5), radius: const Radius.circular(.5))
      ..arcToPoint(const Offset(19.5, 10), radius: const Radius.circular(1))
      ..relativeCubicTo(-.81, 0, -1.8, -.7, -2.5, 0)
      ..relativeLineTo(-1.958, 1.957)
      ..arcToPoint(const Offset(14.79, 11.885),
          radius: const Radius.circular(.15))
      ..relativeLineTo(-.493, -2.07)
      ..arcToPoint(const Offset(14.186, 9.703),
          radius: const Radius.circular(.15))
      ..relativeLineTo(-2.072, -.494)
      ..arcToPoint(const Offset(12.042, 8.957),
          radius: const Radius.circular(.15))
      ..lineTo(14, 7)
      ..relativeCubicTo(.7, -.7, 0, -1.69, 0, -2.5);
    canvas.drawPath(upper, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(-t * .55, t * .55);
    final lower = Path()
      ..moveTo(9.698, 14.19)
      ..arcToPoint(const Offset(9.81, 14.302),
          radius: const Radius.circular(.15))
      ..relativeLineTo(2.074, .489)
      ..arcToPoint(const Offset(11.956, 15.043),
          radius: const Radius.circular(.15))
      ..lineTo(10, 17)
      ..relativeCubicTo(-.7, .7, 0, 1.69, 0, 2.5)
      ..arcToPoint(const Offset(5, 19.5), radius: const Radius.circular(1))
      ..arcToPoint(
        const Offset(4.5, 19),
        radius: const Radius.circular(.495),
        clockwise: false,
      )
      ..arcToPoint(const Offset(4.5, 14), radius: const Radius.circular(1))
      ..relativeCubicTo(.81, 0, 1.8, .7, 2.5, 0)
      ..relativeLineTo(1.956, -1.957)
      ..arcToPoint(const Offset(9.208, 12.115),
          radius: const Radius.circular(.15))
      ..close();
    canvas.drawPath(lower, paint);
    canvas.restore();

    final rays = Path()
      ..moveTo(16, 20 + t)
      ..lineTo(15, 18)
      ..moveTo(20 + t, 16)
      ..lineTo(18, 15)
      ..moveTo(4 - t, 8)
      ..lineTo(6, 9)
      ..moveTo(8, 4 - t)
      ..lineTo(9, 6);
    canvas.drawPath(rays, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BoneFracturePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
