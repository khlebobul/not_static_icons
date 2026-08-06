import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated BanknoteCheck icon.
class BanknoteCheckIcon extends AnimatedSVGIcon {
  const BanknoteCheckIcon({
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
  String get animationDescription => 'coin pulses as the check confirms';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BanknoteCheckPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BanknoteCheckPainter extends CustomPainter {
  const _BanknoteCheckPainter({
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
    final outline = Path()
      ..moveTo(11.748, 18)
      ..lineTo(4, 18)
      ..arcToPoint(const Offset(2, 16), radius: const Radius.circular(2))
      ..lineTo(2, 8)
      ..arcToPoint(const Offset(4, 6), radius: const Radius.circular(2))
      ..lineTo(20, 6)
      ..arcToPoint(const Offset(22, 8), radius: const Radius.circular(2))
      ..lineTo(22, 12.875);
    canvas.drawPath(outline, paint);
    canvas.drawLine(const Offset(18, 12), const Offset(18.01, 12), paint);
    canvas.drawLine(const Offset(6, 12), const Offset(6.01, 12), paint);

    canvas.save();
    canvas.translate(12, 12);
    canvas.scale(1 + t * .14);
    canvas.translate(-12, -12);
    canvas.drawCircle(const Offset(12, 12), 2, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(18, 19);
    canvas.rotate(-t * .12);
    canvas.scale(1 + t * .18);
    canvas.translate(-18, -19);
    final check = Path()
      ..moveTo(16, 19)
      ..lineTo(18, 21)
      ..lineTo(22, 17);
    canvas.drawPath(check, paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BanknoteCheckPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
