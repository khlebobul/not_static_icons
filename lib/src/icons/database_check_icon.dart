import 'package:flutter/material.dart';

import '../core/animated_svg_icon_base.dart';

/// Animated DatabaseCheck icon.
class DatabaseCheckIcon extends AnimatedSVGIcon {
  const DatabaseCheckIcon({
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
  String get animationDescription => 'database pulses as the check confirms';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DatabaseCheckPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _DatabaseCheckPainter extends CustomPainter {
  const _DatabaseCheckPainter({
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
      ..moveTo(21, 13.127)
      ..lineTo(21, 5)
      ..moveTo(3, 12)
      ..arcToPoint(
        const Offset(21, 12),
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
    canvas.translate(18, 19);
    canvas.rotate(-t * .14);
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
  bool shouldRepaint(_DatabaseCheckPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.strokeWidth != strokeWidth;
}
