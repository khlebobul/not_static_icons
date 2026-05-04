import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Bookmark Off Icon - slash draws across the static bookmark on hover/tap
class BookmarkOffIcon extends AnimatedSVGIcon {
  const BookmarkOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
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
  String get animationDescription => 'Slash draws across the bookmark';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BookmarkOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BookmarkOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BookmarkOffPainter({
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

    // Path 1 (bottom with tabs):
    // M19 19v1a1 1 0 0 1-1.496.868l-4.512-2.578a2 2 0 0 0-1.984 0l-4.512 2.578
    // A1 1 0 0 1 5 20V5
    final Path p1 = Path()
      ..moveTo(19 * s, 19 * s)
      ..relativeLineTo(0, 1 * s)
      ..relativeArcToPoint(
        Offset(-1.496 * s, 0.868 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
      )
      ..relativeLineTo(-4.512 * s, -2.578 * s)
      ..relativeArcToPoint(
        Offset(-1.984 * s, 0),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..relativeLineTo(-4.512 * s, 2.578 * s)
      ..arcToPoint(
        Offset(5 * s, 20 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
      )
      ..lineTo(5 * s, 5 * s);
    canvas.drawPath(p1, paint);

    // Path 3 (top): M8.656 3H17a2 2 0 0 1 2 2v8.344
    final Path p3 = Path()
      ..moveTo(8.656 * s, 3 * s)
      ..lineTo(17 * s, 3 * s)
      ..relativeArcToPoint(
        Offset(2 * s, 2 * s),
        radius: Radius.circular(2 * s),
        clockwise: true,
      )
      ..relativeLineTo(0, 8.344 * s);
    canvas.drawPath(p3, paint);

    // Slash: m2 2 20 20 — reveals from top-left to bottom-right
    final Path slashPath = Path()
      ..moveTo(2 * s, 2 * s)
      ..lineTo(22 * s, 22 * s);

    if (t == 0.0) {
      canvas.drawPath(slashPath, paint);
    } else {
      // Stroke-reveal: slash draws from top-left corner to bottom-right
      final out = Path();
      for (final metric in slashPath.computeMetrics()) {
        final double end = metric.length * t;
        if (end > 0) out.addPath(metric.extractPath(0, end), Offset.zero);
      }
      canvas.drawPath(out, paint);
    }
  }

  @override
  bool shouldRepaint(_BookmarkOffPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
