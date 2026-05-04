import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Beef Off Icon - forbidden shake (left-right jitter) on hover/tap
class BeefOffIcon extends AnimatedSVGIcon {
  const BeefOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
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
  String get animationDescription => 'Forbidden left-right shake';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeefOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeefOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeefOffPainter({
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

    final double s = size.width / 24.0;
    final double t = animationValue.clamp(0.0, 1.0);

    // Dampened left-right shake: fast at start, settles to 0
    final double shake = math.sin(t * math.pi * 6) * (1.0 - t) * 2.0 * s;

    canvas.save();
    canvas.translate(shake, 0);

    // Path 1 (inner arc): M11.771 6.109a2.5 2.5 0 0 1 3.12 3.12
    final Path p1 = Path()
      ..moveTo(11.771 * s, 6.109 * s)
      ..relativeArcToPoint(
        Offset(3.12 * s, 3.12 * s),
        radius: Radius.circular(2.5 * s),
        clockwise: true,
      );
    canvas.drawPath(p1, paint);

    // Path 2 (main arc): M17.852 12.185a6.5 6.5 0 0 0-9.035-9.04
    final Path p2 = Path()
      ..moveTo(17.852 * s, 12.185 * s)
      ..relativeArcToPoint(
        Offset(-9.035 * s, -9.04 * s),
        radius: Radius.circular(6.5 * s),
        clockwise: false,
      );
    canvas.drawPath(p2, paint);

    // Path 3 (lower): M18.013 18.013C15.029 20.349 10.831 22 7 22a3 3 0 0 1-2.68-1.66L2.4 16.5
    final Path p3 = Path()
      ..moveTo(18.013 * s, 18.013 * s)
      ..cubicTo(15.029 * s, 20.349 * s, 10.831 * s, 22 * s, 7 * s, 22 * s)
      ..relativeArcToPoint(
        Offset(-2.68 * s, -1.66 * s),
        radius: Radius.circular(3 * s),
        clockwise: true,
      )
      ..lineTo(2.4 * s, 16.5 * s);
    canvas.drawPath(p3, paint);

    // Path 4 (arm): m18.5 6 2.19 4.5a6.48 6.48 0 0 1-.139 4.393
    final Path p4 = Path()
      ..moveTo(18.5 * s, 6 * s)
      ..relativeLineTo(2.19 * s, 4.5 * s)
      ..relativeArcToPoint(
        Offset(-0.139 * s, 4.393 * s),
        radius: Radius.circular(6.48 * s),
        clockwise: true,
      );
    canvas.drawPath(p4, paint);

    // Path 5 (slash): m2 2 20 20
    canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);

    // Path 6 (lower curve):
    // M6.355 6.37a7 7 0 0 0-.075.23c-1.1 3.13-.78 3.9-3.18 6.08
    //   A3 3 0 0 0 5 18c3.356 0 6.993-1.267 9.85-3.151
    final Path p6 = Path()
      ..moveTo(6.355 * s, 6.37 * s)
      ..relativeArcToPoint(
        Offset(-0.075 * s, 0.23 * s),
        radius: Radius.circular(7 * s),
        clockwise: false,
      )
      ..relativeCubicTo(
          -1.1 * s, 3.13 * s, -0.78 * s, 3.9 * s, -3.18 * s, 6.08 * s)
      ..arcToPoint(
        Offset(5 * s, 18 * s),
        radius: Radius.circular(3 * s),
        clockwise: false,
      )
      ..relativeCubicTo(
          3.356 * s, 0, 6.993 * s, -1.267 * s, 9.85 * s, -3.151 * s);
    canvas.drawPath(p6, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BeefOffPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
