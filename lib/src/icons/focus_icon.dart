import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated Focus icon.
class FocusIcon extends AnimatedSVGIcon {
  const FocusIcon({
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
  String get animationDescription => 'corners lock onto a pulsing target';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FocusPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _FocusPainter extends CustomPainter {
  const _FocusPainter({
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
    canvas.drawCircle(const Offset(12, 12), 3 + t * .35, paint);
    if (t > 0) {
      final ringPaint = Paint()
        ..color = color.withValues(alpha: t * .55)
        ..strokeWidth = strokeWidth / scale
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(const Offset(12, 12), 3 + t * 2, ringPaint);
    }
    final topLeft = Path()
      ..moveTo(3, 7)
      ..lineTo(3, 5)
      ..arcToPoint(const Offset(5, 3), radius: const Radius.circular(2))
      ..lineTo(7, 3);
    canvas.save();
    canvas.translate(t, t);
    canvas.drawPath(topLeft, paint);
    canvas.restore();
    final topRight = Path()
      ..moveTo(17, 3)
      ..lineTo(19, 3)
      ..arcToPoint(const Offset(21, 5), radius: const Radius.circular(2))
      ..lineTo(21, 7);
    canvas.save();
    canvas.translate(-t, t);
    canvas.drawPath(topRight, paint);
    canvas.restore();
    final bottomRight = Path()
      ..moveTo(21, 17)
      ..lineTo(21, 19)
      ..arcToPoint(const Offset(19, 21), radius: const Radius.circular(2))
      ..lineTo(17, 21);
    canvas.save();
    canvas.translate(-t, -t);
    canvas.drawPath(bottomRight, paint);
    canvas.restore();
    final bottomLeft = Path()
      ..moveTo(7, 21)
      ..lineTo(5, 21)
      ..arcToPoint(const Offset(3, 19), radius: const Radius.circular(2))
      ..lineTo(3, 17);
    canvas.save();
    canvas.translate(t, -t);
    canvas.drawPath(bottomLeft, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FocusPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
