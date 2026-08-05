import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlagOff icon.
class FlagOffIcon extends AnimatedSVGIcon {
  const FlagOffIcon({
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
  String get animationDescription => 'flag sways behind the slash';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlagOffPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlagOffPainter extends CustomPainter {
  const _FlagOffPainter({
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
    canvas.rotate(t * .07);
    canvas.scale(1 + t * .08, 1 - t * .04);
    canvas.translate(-4, -4);
    final cloth = Path()
      ..moveTo(16, 16)
      ..cubicTo(13, 16, 11, 14, 8, 14)
      ..arcToPoint(const Offset(4, 15.528),
          radius: const Radius.circular(6), clockwise: false)
      ..moveTo(7.656, 2)
      ..lineTo(8, 2)
      ..cubicTo(11, 2, 13, 4, 15.333, 4)
      ..quadraticBezierTo(17.333, 4, 18.4, 3.2)
      ..arcToPoint(const Offset(20, 4), radius: const Radius.circular(1))
      ..lineTo(20, 14.347);
    canvas.drawPath(cloth, paint);
    canvas.restore();
    final slash = Path()
      ..moveTo(2, 2)
      ..lineTo(22, 22);
    final metric = slash.computeMetrics().first;
    canvas.drawPath(
      metric.extractPath(0, metric.length * (1 - t * .35)),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlagOffPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
