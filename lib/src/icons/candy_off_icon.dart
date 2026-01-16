import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Candy Off Icon - Slash shakes
class CandyOffIcon extends AnimatedSVGIcon {
  const CandyOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Slash shakes";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    // Shake: sine wave
    final shake = math.sin(animationValue * math.pi * 3) * 0.1;

    return CandyOffPainter(
      color: color,
      shake: shake,
      strokeWidth: strokeWidth,
    );
  }
}

class CandyOffPainter extends CustomPainter {
  final Color color;
  final double shake;
  final double strokeWidth;

  CandyOffPainter({
    required this.color,
    required this.shake,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scale = size.width / 24.0;

    canvas.save();
    canvas.translate(shake * size.width, 0);

    // M10 10v7.9
    canvas.drawLine(Offset(10 * scale, 10 * scale),
        Offset(10 * scale, 17.9 * scale), paint);

    // M11.802 6.145a5 5 0 0 1 6.053 6.053
    final arc1 = Path();
    arc1.moveTo(11.802 * scale, 6.145 * scale);
    arc1.arcToPoint(Offset(17.855 * scale, 12.198 * scale),
        radius: Radius.circular(5 * scale), clockwise: true);
    canvas.drawPath(arc1, paint);

    // M14 6.1v2.243
    canvas.drawLine(Offset(14 * scale, 6.1 * scale),
        Offset(14 * scale, 8.343 * scale), paint);

    // m15.5 15.571-.964.964a5 5 0 0 1-7.071 0 5 5 0 0 1 0-7.07l.964-.965
    final arc2 = Path();
    arc2.moveTo(15.5 * scale, 15.571 * scale);
    arc2.lineTo(14.536 * scale, 16.535 * scale);
    arc2.arcToPoint(Offset(7.465 * scale, 16.535 * scale),
        radius: Radius.circular(5 * scale), clockwise: true);
    arc2.arcToPoint(Offset(7.465 * scale, 9.465 * scale),
        radius: Radius.circular(5 * scale), clockwise: true);
    arc2.lineTo(8.429 * scale, 8.5 * scale);
    canvas.drawPath(arc2, paint);

    // M16 7V3a1 1 0 0 1 1.707-.707 2.5 2.5 0 0 0 2.152.717 1 1 0 0 1 1.131 1.131 2.5 2.5 0 0 0 .717 2.152A1 1 0 0 1 21 8h-4
    final wrapper1 = Path();
    wrapper1.moveTo(16 * scale, 7 * scale);
    wrapper1.lineTo(16 * scale, 3 * scale);
    wrapper1.arcToPoint(Offset(17.707 * scale, 2.293 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.arcToPoint(Offset(19.859 * scale, 3.01 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper1.arcToPoint(Offset(20.99 * scale, 4.141 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.arcToPoint(Offset(21.707 * scale, 6.293 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper1.arcToPoint(Offset(21 * scale, 8 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper1.lineTo(17 * scale, 8 * scale);
    canvas.drawPath(wrapper1, paint);

    // M8 17v4a1 1 0 0 1-1.707.707 2.5 2.5 0 0 0-2.152-.717 1 1 0 0 1-1.131-1.131 2.5 2.5 0 0 0-.717-2.152A1 1 0 0 1 3 16h4
    final wrapper2 = Path();
    wrapper2.moveTo(8 * scale, 17 * scale);
    wrapper2.lineTo(8 * scale, 21 * scale);
    wrapper2.arcToPoint(Offset(6.293 * scale, 21.707 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.arcToPoint(Offset(4.141 * scale, 20.99 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper2.arcToPoint(Offset(3.01 * scale, 19.859 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.arcToPoint(Offset(2.293 * scale, 17.707 * scale),
        radius: Radius.circular(2.5 * scale), clockwise: false);
    wrapper2.arcToPoint(Offset(3 * scale, 16 * scale),
        radius: Radius.circular(1 * scale), clockwise: true);
    wrapper2.lineTo(7 * scale, 16 * scale);
    canvas.drawPath(wrapper2, paint);

    // Slash
    // m2 2 20 20
    canvas.drawLine(
        Offset(2 * scale, 2 * scale), Offset(22 * scale, 22 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CandyOffPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shake != shake ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
