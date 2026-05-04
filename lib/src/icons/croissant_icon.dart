import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Croissant Icon - stroke-reveal drawing of the whole icon on hover/tap
class CroissantIcon extends AnimatedSVGIcon {
  const CroissantIcon({
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
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => 'Stroke-reveal drawing of the icon';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CroissantPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CroissantPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CroissantPainter({
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

    // Path 1: M10.2 18H4.774a1.5 1.5 0 0 1-1.352-.97 11 11 0 0 1 .132-6.487
    final Path p1 = Path()
      ..moveTo(10.2 * s, 18 * s)
      ..lineTo(4.774 * s, 18 * s)
      ..relativeArcToPoint(
        Offset(-1.352 * s, -0.97 * s),
        radius: Radius.circular(1.5 * s),
        clockwise: true,
      )
      ..relativeArcToPoint(
        Offset(0.132 * s, -6.487 * s),
        radius: Radius.circular(11 * s),
        clockwise: true,
      );

    // Path 2: M18 10.2V4.774a1.5 1.5 0 0 0-.97-1.352 11 11 0 0 0-6.486.132
    final Path p2 = Path()
      ..moveTo(18 * s, 10.2 * s)
      ..lineTo(18 * s, 4.774 * s)
      ..relativeArcToPoint(
        Offset(-0.97 * s, -1.352 * s),
        radius: Radius.circular(1.5 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(-6.486 * s, 0.132 * s),
        radius: Radius.circular(11 * s),
        clockwise: false,
      );

    // Path 3: M18 5a4 3 0 0 1 4 3 2 2 0 0 1-2 2 10 10 0 0 0-5.139 1.42
    final Path p3 = Path()
      ..moveTo(18 * s, 5 * s)
      ..relativeArcToPoint(
        Offset(4 * s, 3 * s),
        radius: Radius.elliptical(4 * s, 3 * s),
        clockwise: true,
      )
      ..relativeArcToPoint(
        Offset(-2 * s, 2 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeArcToPoint(
        Offset(-5.139 * s, 1.42 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
      );

    // Path 4: M5 18a3 4 0 0 0 3 4 2 2 0 0 0 2-2 10 10 0 0 1 1.42-5.14
    final Path p4 = Path()
      ..moveTo(5 * s, 18 * s)
      ..relativeArcToPoint(
        Offset(3 * s, 4 * s),
        radius: Radius.elliptical(3 * s, 4 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(2 * s, -2 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(1.42 * s, -5.14 * s),
        radius: Radius.circular(10 * s),
        clockwise: true,
      );

    // Path 5: M8.709 2.554a10 10 0 0 0-6.155 6.155 1.5 1.5 0 0 0 .676 1.626
    //         l9.807 5.42a2 2 0 0 0 2.718-2.718l-5.42-9.807a1.5 1.5 0 0 0-1.626-.676
    final Path p5 = Path()
      ..moveTo(8.709 * s, 2.554 * s)
      ..relativeArcToPoint(
        Offset(-6.155 * s, 6.155 * s),
        radius: Radius.circular(10 * s),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(0.676 * s, 1.626 * s),
        radius: Radius.circular(1.5 * s),
        clockwise: false,
      )
      ..relativeLineTo(9.807 * s, 5.42 * s)
      ..relativeArcToPoint(
        Offset(2.718 * s, -2.718 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..relativeLineTo(-5.42 * s, -9.807 * s)
      ..relativeArcToPoint(
        Offset(-1.626 * s, -0.676 * s),
        radius: Radius.circular(1.5 * s),
        clockwise: false,
      );

    final List<Path> paths = [p1, p2, p3, p4, p5];

    if (t == 0.0) {
      for (final p in paths) {
        canvas.drawPath(p, paint);
      }
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

    // Distribute evenly across the 5 paths
    for (int i = 0; i < paths.length; i++) {
      final double a = i / paths.length;
      final double b = (i + 1) / paths.length;
      final double f = seg(t, a, b);
      if (f > 0) {
        canvas.drawPath(extractPortion(paths[i], f), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_CroissantPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
