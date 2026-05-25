import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Blender Icon - blade arc rocks as the blender runs
class BlenderIcon extends AnimatedSVGIcon {
  const BlenderIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Blender blade rocks';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BlenderPainter(color, animationValue, strokeWidth);
}

class _BlenderPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BlenderPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = _paint(color, strokeWidth);
    final t = animationValue.clamp(0.0, 1.0);

    // Cup/tray: M8 14a2 2 0 0 0-1.963 1.615l-1.018 5.193A1 1 0 0 0 6 22h12...
    final cup = Path()
      ..moveTo(8 * s, 14 * s)
      ..arcToPoint(Offset(6.037 * s, 15.615 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(5.019 * s, 20.808 * s)
      ..arcToPoint(Offset(6 * s, 22 * s),
          radius: Radius.circular(1 * s), clockwise: false)
      ..lineTo(18 * s, 22 * s)
      ..arcToPoint(Offset(18.981 * s, 20.808 * s),
          radius: Radius.circular(1 * s), clockwise: false)
      ..lineTo(17.963 * s, 15.615 * s)
      ..arcToPoint(Offset(16 * s, 14 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..close();
    canvas.drawPath(cup, paint);

    // Jug sides: m17 2-1 12 and M8.006 14 7 2
    canvas.drawLine(Offset(17 * s, 2 * s), Offset(16 * s, 14 * s), paint);
    canvas.drawLine(Offset(8.006 * s, 14 * s), Offset(7 * s, 2 * s), paint);

    // Top motor frame: M19 2H5a2 2 0 0 0-2 2v5a2 2 0 0 0 .688 1.5
    final frame = Path()
      ..moveTo(19 * s, 2 * s)
      ..lineTo(5 * s, 2 * s)
      ..arcToPoint(Offset(3 * s, 4 * s),
          radius: Radius.circular(2 * s), clockwise: false)
      ..lineTo(3 * s, 9 * s)
      ..arcToPoint(Offset(3.688 * s, 10.5 * s),
          radius: Radius.circular(2 * s), clockwise: false);
    canvas.drawPath(frame, paint);

    // Dot: M12 18h.01
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(12 * s, 18 * s), strokeWidth * 0.6, dotPaint);

    // Blade arc rocking inside jug: M7.565 8.787A5 5 0 0 0 12 8a5 5 0 0 1 4.56-.75
    final bladeCenter = Offset(12 * s, 8 * s);
    canvas.save();
    canvas.translate(bladeCenter.dx, bladeCenter.dy);
    canvas.rotate(math.sin(math.pi * t) * 0.55);
    canvas.translate(-bladeCenter.dx, -bladeCenter.dy);
    final blade = Path()
      ..moveTo(7.565 * s, 8.787 * s)
      ..arcToPoint(Offset(12 * s, 8 * s),
          radius: Radius.circular(5 * s), clockwise: false)
      ..arcToPoint(Offset(16.56 * s, 7.25 * s),
          radius: Radius.circular(5 * s), clockwise: true);
    canvas.drawPath(blade, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BlenderPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}

Paint _paint(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
