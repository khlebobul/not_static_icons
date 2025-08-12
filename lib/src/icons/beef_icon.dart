import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Beef Icon - initial state matches lucide beef; on animate the icon draws in
class BeefIcon extends AnimatedSVGIcon {
  const BeefIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1100),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription => 'Stroke-reveal drawing of the whole icon';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeefPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeefPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeefPainter({
    required this.color,
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final double s = size.width / 24.0;

    // Path 1: M16.4 13.7 A6.5 6.5 0 1 0 6.28 6.6 c-1.1 3.13-.78 3.9-3.18 6.08
    //         A3 3 0 0 0 5 18 c4 0 8.4-1.8 11.4-4.3
    final Path p1 = Path()
      ..moveTo(16.4 * s, 13.7 * s)
      ..arcToPoint(
        Offset(6.28 * s, 6.6 * s),
        radius: Radius.circular(6.5 * s),
        rotation: 0,
        largeArc: true,
        clockwise: false,
      )
      ..relativeCubicTo(
          -1.1 * s, 3.13 * s, -0.78 * s, 3.9 * s, -3.18 * s, 6.08 * s)
      ..arcToPoint(
        Offset(5 * s, 18 * s),
        radius: Radius.circular(3 * s),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      )
      ..relativeCubicTo(4 * s, 0, 8.4 * s, -1.8 * s, 11.4 * s, -4.3 * s);
    // Defer drawing to animation phase below

    // Path 2: m18.5 6 2.19 4.5 a6.48 6.48 0 0 1 -2.29 7.2 C15.4 20.2 11 22 7 22
    //         a3 3 0 0 1 -2.68 -1.66 L2.4 16.5
    final Path p2 = Path()
      ..moveTo(18.5 * s, 6 * s)
      ..lineTo((18.5 + 2.19) * s, (6 + 4.5) * s)
      ..arcToPoint(
        Offset((18.5 + 2.19 - 2.29) * s, (6 + 4.5 + 7.2) * s),
        radius: Radius.circular(6.48 * s),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      )
      ..cubicTo(15.4 * s, 20.2 * s, 11 * s, 22 * s, 7 * s, 22 * s)
      ..arcToPoint(
        Offset((7 - 2.68) * s, (22 - 1.66) * s),
        radius: Radius.circular(3 * s),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      )
      ..lineTo(2.4 * s, 16.5 * s);
    // Defer drawing to animation phase below

    // Circle path for reveal: cx=12.5 cy=8.5 r=2.5
    final Path circlePath = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(12.5 * s, 8.5 * s), radius: 2.5 * s));

    // Animation: stroke-reveal drawing
    final double t = animationValue.clamp(0.0, 1.0);
    if (t == 0.0) {
      // Initial: full icon matches SVG
      canvas.drawPath(p1, paint);
      canvas.drawPath(p2, paint);
      canvas.drawPath(circlePath, paint);
      return;
    }

    Path extractPortion(Path path, double fraction) {
      fraction = fraction.clamp(0.0, 1.0);
      final Path out = Path();
      for (final metric in path.computeMetrics(forceClosed: false)) {
        final double len = metric.length;
        if (len <= 0) continue;
        final double end = len * fraction;
        if (end > 0) {
          out.addPath(metric.extractPath(0, end), Offset.zero);
        }
      }
      return out;
    }

    double mapSegment(double x, double a, double b) {
      if (x <= a) return 0.0;
      if (x >= b) return 1.0;
      return (x - a) / (b - a);
    }

    // Timeline: p1 (0..0.45), p2 (0.45..0.9), circle (0.9..1)
    final double f1 = mapSegment(t, 0.0, 0.45);
    final double f2 = mapSegment(t, 0.45, 0.9);
    final double f3 = mapSegment(t, 0.9, 1.0);

    // Draw in order
    if (f1 > 0) {
      canvas.drawPath(f1 < 1.0 ? extractPortion(p1, f1) : p1, paint);
    }
    if (f2 > 0) {
      canvas.drawPath(f2 < 1.0 ? extractPortion(p2, f2) : p2, paint);
    }
    if (f3 > 0) {
      canvas.drawPath(
          f3 < 1.0 ? extractPortion(circlePath, f3) : circlePath, paint);
    }
  }

  @override
  bool shouldRepaint(_BeefPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
