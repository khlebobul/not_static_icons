import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FlaskConicalOff icon.
class FlaskConicalOffIcon extends AnimatedSVGIcon {
  const FlaskConicalOffIcon({
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
  String get animationDescription => 'liquid drains behind the slash';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlaskConicalOffPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlaskConicalOffPainter extends CustomPainter {
  const _FlaskConicalOffPainter({
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
      ..moveTo(10, 2)
      ..lineTo(10, 4.343)
      ..moveTo(14, 2)
      ..lineTo(14, 8.343)
      ..moveTo(20, 20)
      ..arcToPoint(const Offset(18, 22), radius: const Radius.circular(2))
      ..lineTo(6, 22)
      ..arcToPoint(const Offset(4.245, 19.04), radius: const Radius.circular(2))
      ..lineTo(9.472, 9.477)
      ..moveTo(8.5, 2)
      ..lineTo(15.5, 2);
    canvas.drawPath(path, paint);
    final liquid = Path()
      ..moveTo(6.453, 15)
      ..quadraticBezierTo(10.7, 15 + t, 15 + t * 1.5, 15);
    canvas.drawPath(liquid, paint);
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
  bool shouldRepaint(_FlaskConicalOffPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
