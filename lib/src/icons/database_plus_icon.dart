import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated DatabasePlus icon.
class DatabasePlusIcon extends AnimatedSVGIcon {
  const DatabasePlusIcon({
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
  String get animationDescription => 'database pulses as the plus turns';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabasePlusPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _DatabasePlusPainter extends CustomPainter {
  const _DatabasePlusPainter({
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
    canvas.drawOval(
      Rect.fromCenter(
          center: const Offset(12, 5), width: 18, height: 6 + t * .5),
      paint,
    );
    final database = Path()
      ..moveTo(21, 12.536)
      ..lineTo(21, 5)
      ..moveTo(3, 12)
      ..arcToPoint(
        const Offset(15.1824, 14.8061),
        radius: const Radius.elliptical(9, 3),
        clockwise: false,
      )
      ..moveTo(3, 5)
      ..lineTo(3, 19)
      ..arcToPoint(
        const Offset(13.318, 21.968),
        radius: const Radius.elliptical(9, 3),
        clockwise: false,
      );
    canvas.drawPath(database, paint);
    canvas.save();
    canvas.translate(19, 19);
    canvas.rotate(t * .8);
    canvas.translate(-19, -19);
    canvas.drawLine(const Offset(19, 16), const Offset(19, 22), paint);
    canvas.drawLine(const Offset(22, 19), const Offset(16, 19), paint);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DatabasePlusPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
