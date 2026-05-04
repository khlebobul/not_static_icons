import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Creative Commons Icon - CC marks draw in sequentially on hover/tap
class CreativeCommonsIcon extends AnimatedSVGIcon {
  const CreativeCommonsIcon({
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
  String get animationDescription => 'CC marks draw in sequentially';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CreativeCommonsPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CreativeCommonsPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CreativeCommonsPainter({
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

    // Outer circle always drawn
    canvas.drawCircle(Offset(12 * s, 12 * s), 10 * s, paint);

    // Left C: M10 9.3a2.8 2.8 0 0 0-3.5 1 3.1 3.1 0 0 0 0 3.4 2.7 2.7 0 0 0 3.5 1
    final Path leftC = Path()
      ..moveTo(10 * s, 9.3 * s)
      ..relativeArcToPoint(
        Offset(-3.5 * s, 1 * s),
        radius: Radius.circular(2.8 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(0, 3.4 * s),
        radius: Radius.circular(3.1 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(3.5 * s, 1 * s),
        radius: Radius.circular(2.7 * s),
        clockwise: false,
      );

    // Right C: M17 9.3a2.8 2.8 0 0 0-3.5 1 3.1 3.1 0 0 0 0 3.4 2.7 2.7 0 0 0 3.5 1
    final Path rightC = Path()
      ..moveTo(17 * s, 9.3 * s)
      ..relativeArcToPoint(
        Offset(-3.5 * s, 1 * s),
        radius: Radius.circular(2.8 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(0, 3.4 * s),
        radius: Radius.circular(3.1 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(3.5 * s, 1 * s),
        radius: Radius.circular(2.7 * s),
        clockwise: false,
      );

    if (t == 0.0) {
      canvas.drawPath(leftC, paint);
      canvas.drawPath(rightC, paint);
      return;
    }

    Path extractPortion(Path path, double fraction) {
      fraction = fraction.clamp(0.0, 1.0);
      final out = Path();
      for (final metric in path.computeMetrics()) {
        final double end = metric.length * fraction;
        if (end > 0) out.addPath(metric.extractPath(0, end), Offset.zero);
      }
      return out;
    }

    double seg(double x, double a, double b) =>
        ((x - a) / (b - a)).clamp(0.0, 1.0);

    // Left C: 0 → 0.5, Right C: 0.5 → 1.0
    canvas.drawPath(extractPortion(leftC, seg(t, 0, 0.5)), paint);
    canvas.drawPath(extractPortion(rightC, seg(t, 0.5, 1.0)), paint);
  }

  @override
  bool shouldRepaint(_CreativeCommonsPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
