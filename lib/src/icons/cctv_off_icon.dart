import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated CCTV Off Icon - camera body flickers like signal loss; slash always static
class CctvOffIcon extends AnimatedSVGIcon {
  const CctvOffIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
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
  String get animationDescription => 'Camera flickers like signal loss; slash static';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CctvOffPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CctvOffPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CctvOffPainter({
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

    // Flicker: rapid oscillation that fades out toward the end
    // At t=0: alpha=1 (full). During animation: flickering. At t=1: alpha≈0 then resets.
    final double flickerAlpha = t == 0.0
        ? 1.0
        : ((math.sin(t * math.pi * 12) + 1) / 2) * (1.0 - t * 0.6) + 0.1;

    final Paint flickerPaint = Paint()
      ..color = color.withValues(alpha: flickerAlpha.clamp(0.0, 1.0))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Path 1 (arm + bracket):
    // m12.309 6.652 4.797 2.401a1 1 0 0 1 .447 1.341
    // l-.501 1.001.605.605h2.725a1 1 0 0 1 .894 1.447l-.724 1.448
    final Path p1 = Path()
      ..moveTo(12.309 * s, 6.652 * s)
      ..relativeLineTo(4.797 * s, 2.401 * s)
      ..relativeArcToPoint(
        Offset(0.447 * s, 1.341 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
      )
      ..relativeLineTo(-0.501 * s, 1.001 * s)
      ..relativeLineTo(0.605 * s, 0.605 * s)
      ..relativeLineTo(2.725 * s, 0)
      ..relativeArcToPoint(
        Offset(0.894 * s, 1.447 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
      )
      ..relativeLineTo(-0.724 * s, 1.448 * s);
    canvas.drawPath(p1, flickerPaint);

    // Path 2 (camera body):
    // m15.166 15.166-.719 1.439a1 1 0 0 1-1.342.447
    // L3.61 12.3a2.92 2.92 0 0 1-1.3-3.91L3.69 5.6a2.9 2.9 0 0 1 .873-1.037
    final Path p2 = Path()
      ..moveTo(15.166 * s, 15.166 * s)
      ..relativeLineTo(-0.719 * s, 1.439 * s)
      ..relativeArcToPoint(
        Offset(-1.342 * s, 0.447 * s),
        radius: Radius.circular(1 * s),
        clockwise: true,
      )
      ..lineTo(3.61 * s, 12.3 * s)
      ..relativeArcToPoint(
        Offset(-1.3 * s, -3.91 * s),
        radius: Radius.circular(2.92 * s),
        clockwise: true,
      )
      ..lineTo(3.69 * s, 5.6 * s)
      ..relativeArcToPoint(
        Offset(0.873 * s, -1.037 * s),
        radius: Radius.circular(2.9 * s),
        clockwise: true,
      );
    canvas.drawPath(p2, flickerPaint);

    // Indicator dot (flickers too): M7 9h.01
    canvas.drawLine(
      Offset(7 * s, 9 * s),
      Offset(7.01 * s, 9 * s),
      flickerPaint,
    );

    // Stand (always static): M2 19h3.76a2 2 0 0 0 1.8-1.1l1.441-2.902
    final Path stand = Path()
      ..moveTo(2 * s, 19 * s)
      ..relativeLineTo(3.76 * s, 0)
      ..relativeArcToPoint(
        Offset(1.8 * s, -1.1 * s),
        radius: Radius.circular(2 * s),
        clockwise: false,
      )
      ..relativeLineTo(1.441 * s, -2.902 * s);
    canvas.drawPath(stand, paint);

    // Stand base (static): M2 21v-4
    canvas.drawLine(Offset(2 * s, 21 * s), Offset(2 * s, 17 * s), paint);

    // Slash always static: m2 2 20 20
    canvas.drawLine(Offset(2 * s, 2 * s), Offset(22 * s, 22 * s), paint);
  }

  @override
  bool shouldRepaint(_CctvOffPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
