import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Beaker Icon - original beaker geometry; liquid surface sloshes as a wave during animation
class BeakerIcon extends AnimatedSVGIcon {
  const BeakerIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.resetToStartOnComplete = true,
  });

  @override
  String get animationDescription =>
      'Beaker: liquid surface waves and shifts, then returns to original straight line';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _BeakerPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _BeakerPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _BeakerPainter({
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

    // Original geometry (always draw)
    // Path1: M4.5 3 h15
    canvas.drawLine(
      Offset(4.5 * scale, 3 * scale),
      Offset(19.5 * scale, 3 * scale),
      paint,
    );

    // Path2: M6 3 v16 a2 2 0 0 0 2 2 h8 a2 2 0 0 0 2 -2 V3
    final sides = Path()
      ..moveTo(6 * scale, 3 * scale)
      ..lineTo(6 * scale, 19 * scale)
      ..arcToPoint(
        Offset(8 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(16 * scale, 21 * scale)
      ..arcToPoint(
        Offset(18 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
        clockwise: false,
      )
      ..lineTo(18 * scale, 3 * scale);
    canvas.drawPath(sides, paint);

    // Liquid line base: M6 14 h12
    final x1 = 6 * scale;
    final x2 = 18 * scale;
    final yBase = 14 * scale;

    if (animationValue == 0.0) {
      canvas.drawLine(Offset(x1, yBase), Offset(x2, yBase), paint);
      return;
    }

    // Animated wave on the liquid surface
    final t = animationValue.clamp(0.0, 1.0);
    final amplitude = 1.4 * scale; // ~1.4px at 24x24
    final verticalShift = (math.sin(math.pi * t) * 0.8 * scale);
    final wavelength = (x2 - x1) / 2.0; // two crests across width
    final phase = 2 * math.pi * t;

    final steps = 16;
    final dx = (x2 - x1) / steps;
    final wave = Path()..moveTo(x1, yBase);
    for (int i = 0; i <= steps; i++) {
      final x = x1 + dx * i;
      final y = yBase +
          verticalShift +
          amplitude * math.sin(2 * math.pi * (x - x1) / wavelength + phase);
      if (i == 0) {
        wave.moveTo(x, y);
      } else {
        wave.lineTo(x, y);
      }
    }
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(_BeakerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
