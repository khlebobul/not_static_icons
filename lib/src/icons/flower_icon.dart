import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Flower icon.
class FlowerIcon extends AnimatedSVGIcon {
  const FlowerIcon({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'petal ring turns around a pulsing center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FlowerPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FlowerPainter extends CustomPainter {
  const _FlowerPainter({
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
    canvas.translate(12, 12);
    canvas.rotate(t * .3);
    canvas.scale(1 + t * .06);
    canvas.translate(-12, -12);
    final path = Path()
      ..moveTo(12, 16.5)
      ..arcToPoint(const Offset(7.5, 12),
          radius: const Radius.circular(4.5), largeArc: true)
      ..arcToPoint(const Offset(12, 7.5),
          radius: const Radius.circular(4.5), largeArc: true)
      ..arcToPoint(const Offset(16.5, 12),
          radius: const Radius.circular(4.5), largeArc: true)
      ..arcToPoint(const Offset(12, 16.5),
          radius: const Radius.circular(4.5), largeArc: true)
      ..moveTo(12, 7.5)
      ..lineTo(12, 9)
      ..moveTo(7.5, 12)
      ..lineTo(9, 12)
      ..moveTo(16.5, 12)
      ..lineTo(15, 12)
      ..moveTo(12, 16.5)
      ..lineTo(12, 15)
      ..moveTo(8, 8)
      ..lineTo(9.88, 9.88)
      ..moveTo(14.12, 9.88)
      ..lineTo(16, 8)
      ..moveTo(8, 16)
      ..lineTo(9.88, 14.12)
      ..moveTo(14.12, 14.12)
      ..lineTo(16, 16);
    canvas.drawPath(path, paint);
    canvas.restore();
    canvas.drawCircle(const Offset(12, 12), 3 + t * .35, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlowerPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
