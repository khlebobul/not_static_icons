import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated FoldVertical icon.
class FoldVerticalIcon extends AnimatedSVGIcon {
  const FoldVerticalIcon({
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
      _FoldVerticalPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FoldVerticalPainter extends CustomPainter {
  const _FoldVerticalPainter({
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
      ..moveTo(4 - t * .4, 12)
      ..lineTo(2 + t * .4, 12)
      ..moveTo(10 - t * .4, 12)
      ..lineTo(8 + t * .4, 12)
      ..moveTo(16 - t * .4, 12)
      ..lineTo(14 + t * .4, 12)
      ..moveTo(22 - t * .4, 12)
      ..lineTo(20 + t * .4, 12);
    canvas.drawPath(fixed, paint);
    canvas.save();
    canvas.translate(0, -t * 1.5);
    canvas.translate(12, 16);
    canvas.scale(1 - t * .08, 1 + t * .08);
    canvas.translate(-12, -16);
    final bottom = Path()
      ..moveTo(12, 22)
      ..lineTo(12, 16)
      ..moveTo(15, 19)
      ..lineTo(12, 16)
      ..lineTo(9, 19);
    canvas.drawPath(bottom, paint);
    canvas.restore();
    canvas.save();
    canvas.translate(0, t * 1.5);
    canvas.translate(12, 8);
    canvas.scale(1 - t * .08, 1 + t * .08);
    canvas.translate(-12, -8);
    final top = Path()
      ..moveTo(12, 8)
      ..lineTo(12, 2)
      ..moveTo(15, 5)
      ..lineTo(12, 8)
      ..lineTo(9, 5);
    canvas.drawPath(top, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FoldVerticalPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
