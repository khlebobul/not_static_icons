import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Biceps Flexed Icon - arm path breathes (slight inflate/deflate) while keeping geometry
class BicepsFlexedIcon extends AnimatedSVGIcon {
  const BicepsFlexedIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 900),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Biceps: subtle breathe (inflate/deflate) then return';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _BicepsFlexedPainter(
        color: color,
        animationValue: animationValue,
        strokeWidth: strokeWidth,
      );
}

class _BicepsFlexedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BicepsFlexedPainter({
    required this.color,
    required this.animationValue,
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

    // Apply a very subtle vertical scale to simulate flex
    final center = Offset(12 * scale, 12 * scale);
    final s = animationValue == 0.0
        ? 1.0
        : (1.0 +
            0.06 *
                (animationValue < 0.5
                    ? (animationValue / 0.5)
                    : (1 - (animationValue - 0.5) / 0.5)));
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, s);
    canvas.translate(-center.dx, -center.dy);

    // Path1: M12.409 13.017 A5 5 0 0 1 22 15 c0 3.866 -4 7 -9 7 -4.077 0 -8.153 -.82 -10.371 -2.462
    //        -.426 -.316 -.631 -.832 -.62 -1.362 C2.118 12.723 2.627 2 10 2 a3 3 0 0 1 3 3 2 2 0 0 1 -2 2
    //        c-1.105 0 -1.64 -.444 -2 -1
    final p1 = Path()
      ..moveTo(12.409 * scale, 13.017 * scale)
      ..arcToPoint(Offset(22 * scale, 15 * scale),
          radius: Radius.circular(5 * scale), clockwise: true)
      ..relativeCubicTo(
          0, 3.866 * scale, -4 * scale, 7 * scale, -9 * scale, 7 * scale)
      ..relativeCubicTo(-4.077 * scale, 0, -8.153 * scale, -0.82 * scale,
          -10.371 * scale, -2.462 * scale)
      ..relativeCubicTo(-0.426 * scale, -0.316 * scale, -0.631 * scale,
          -0.832 * scale, -0.62 * scale, -1.362 * scale)
      ..relativeCubicTo(1.12 * scale, -5.453 * scale, 1.629 * scale,
          -16.176 * scale, 8.992 * scale, -16.176 * scale)
      ..relativeCubicTo(
          1.657 * scale, 0, 3 * scale, 1.343 * scale, 3 * scale, 3 * scale)
      ..relativeCubicTo(
          0, 1.105 * scale, -0.895 * scale, 2 * scale, -2 * scale, 2 * scale)
      ..relativeCubicTo(-1.105 * scale, 0, -1.64 * scale, -0.444 * scale,
          -2 * scale, -1 * scale);
    canvas.drawPath(p1, paint);

    // Path2: M15 14 a5 5 0 0 0 -7.584 2
    final p2 = Path()
      ..moveTo(15 * scale, 14 * scale)
      ..arcToPoint(Offset((15 - 7.584) * scale, (14 + 2) * scale),
          radius: Radius.circular(5 * scale), clockwise: false);
    canvas.drawPath(p2, paint);

    // Path3: M9.964 6.825 C8.019 7.977 9.5 13 8 15
    final p3 = Path()
      ..moveTo(9.964 * scale, 6.825 * scale)
      ..cubicTo(8.019 * scale, 7.977 * scale, 9.5 * scale, 13 * scale,
          8 * scale, 15 * scale);
    canvas.drawPath(p3, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BicepsFlexedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
