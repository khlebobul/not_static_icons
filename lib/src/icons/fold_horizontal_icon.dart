import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FoldHorizontal icon.
class FoldHorizontalIcon extends AnimatedSVGIcon {
  const FoldHorizontalIcon({
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
  String get animationDescription => 'arrows close as the fold axis contracts';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FoldHorizontalPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FoldHorizontalPainter extends CustomPainter {
  const _FoldHorizontalPainter({
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
    final fixed = Path()
      ..moveTo(12, 2 + t * .4)
      ..lineTo(12, 4 - t * .4)
      ..moveTo(12, 8 + t * .4)
      ..lineTo(12, 10 - t * .4)
      ..moveTo(12, 14 + t * .4)
      ..lineTo(12, 16 - t * .4)
      ..moveTo(12, 20 + t * .4)
      ..lineTo(12, 22 - t * .4);
    canvas.drawPath(fixed, paint);
    canvas.save();
    canvas.translate(t * 1.5, 0);
    canvas.translate(8, 12);
    canvas.scale(1 + t * .08, 1 - t * .08);
    canvas.translate(-8, -12);
    final left = Path()
      ..moveTo(2, 12)
      ..lineTo(8, 12)
      ..moveTo(5, 15)
      ..lineTo(8, 12)
      ..lineTo(5, 9);
    canvas.drawPath(left, paint);
    canvas.restore();
    canvas.save();
    canvas.translate(-t * 1.5, 0);
    canvas.translate(16, 12);
    canvas.scale(1 + t * .08, 1 - t * .08);
    canvas.translate(-16, -12);
    final right = Path()
      ..moveTo(22, 12)
      ..lineTo(16, 12)
      ..moveTo(19, 9)
      ..lineTo(16, 12)
      ..lineTo(19, 15);
    canvas.drawPath(right, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FoldHorizontalPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
