import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cuboid Icon - gentle horizontal compress simulating 3D rotation on hover/tap
class CuboidIcon extends AnimatedSVGIcon {
  const CuboidIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Simulated 3D rotation via horizontal compression';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CuboidPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CuboidPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CuboidPainter({
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

    // Horizontal scale oscillates: 1 → 0.75 → 1 (simulates rotation)
    final double scaleX = 1.0 - 0.25 * math.sin(math.pi * t);

    canvas.save();
    canvas.translate(12 * s, 12 * s);
    canvas.scale(scaleX, 1.0);
    canvas.translate(-12 * s, -12 * s);

    // Vertical edge: M10 22v-8
    canvas.drawLine(Offset(10 * s, 22 * s), Offset(10 * s, 14 * s), paint);

    // Middle cross: M2.336 8.89 10 14l11.715-7.029
    final Path midLine = Path()
      ..moveTo(2.336 * s, 8.89 * s)
      ..lineTo(10 * s, 14 * s)
      ..lineTo(21.715 * s, 6.971 * s);
    canvas.drawPath(midLine, paint);

    // Outline: M22 14a2 2 0 0 1-.971 1.715l-10 6a2 2 0 0 1-2.138-.05l-6-4
    //          A2 2 0 0 1 2 16v-6a2 2 0 0 1 .971-1.715l10-6a2 2 0 0 1 2.138.05l6 4
    //          A2 2 0 0 1 22 8z
    final Path outline = Path()
      ..moveTo(22 * s, 14 * s)
      ..relativeArcToPoint(
        Offset(-0.971 * s, 1.715 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(-10 * s, 6 * s)
      ..relativeArcToPoint(
        Offset(-2.138 * s, -0.05 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(-6 * s, -4 * s)
      ..arcToPoint(
        Offset(2 * s, 16 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(0, -6 * s)
      ..relativeArcToPoint(
        Offset(0.971 * s, -1.715 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(10 * s, -6 * s)
      ..relativeArcToPoint(
        Offset(2.138 * s, 0.05 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(6 * s, 4 * s)
      ..arcToPoint(
        Offset(22 * s, 8 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..close();
    canvas.drawPath(outline, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CuboidPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
