import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Palette Icon - Paint dots pulse
class PaletteIcon extends AnimatedSVGIcon {
  const PaletteIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Paint dots pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return PalettePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class PalettePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  PalettePainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;

    // Palette shape: M12 22a1 1 0 0 1 0-20 10 9 0 0 1 10 9 5 5 0 0 1-5 5h-2.25a1.75 1.75 0 0 0-1.4 2.8l.3.4a1.75 1.75 0 0 1-1.4 2.8z
    final palettePath = Path();

    // M12 22
    palettePath.moveTo(12 * scale, 22 * scale);

    // a1 1 0 0 1 0-20 - arc from (12,22) to (12,2)
    // rx=1, ry=1 is too small for 20 unit distance, SVG auto-scales
    // sweep=1 means clockwise
    palettePath.arcToPoint(
      Offset(12 * scale, 2 * scale),
      radius: Radius.circular(10 * scale), // Auto-scaled radius
      clockwise: true,
    );

    // 10 9 0 0 1 10 9 - elliptical arc from (12,2) to (22,11)
    // rx=10, ry=9, sweep=1 (clockwise)
    palettePath.arcToPoint(
      Offset(22 * scale, 11 * scale),
      radius: Radius.elliptical(10 * scale, 9 * scale),
      clockwise: true,
    );

    // 5 5 0 0 1-5 5 - arc from (22,11) to (17,16)
    // rx=5, ry=5, sweep=1 (clockwise)
    palettePath.arcToPoint(
      Offset(17 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
    );

    // h-2.25 - horizontal line to (14.75, 16)
    palettePath.lineTo(14.75 * scale, 16 * scale);

    // a1.75 1.75 0 0 0-1.4 2.8 - arc from (14.75,16) to (13.35, 18.8)
    // sweep=0 (counter-clockwise)
    palettePath.arcToPoint(
      Offset(13.35 * scale, 18.8 * scale),
      radius: Radius.circular(1.75 * scale),
      clockwise: false,
    );

    // l.3.4 - line to (13.65, 19.2)
    palettePath.lineTo(13.65 * scale, 19.2 * scale);

    // a1.75 1.75 0 0 1-1.4 2.8 - arc from (13.65, 19.2) to (12.25, 22)
    // sweep=1 (clockwise)
    palettePath.arcToPoint(
      Offset(12.25 * scale, 22 * scale),
      radius: Radius.circular(1.75 * scale),
      clockwise: true,
    );

    // z - close path back to (12, 22)
    palettePath.close();

    canvas.drawPath(palettePath, paint);

    // Animation - dots pulse with staggered timing (only when animating)
    double pulseScale(double staggerOffset) {
      if (animationValue == 0 || animationValue == 1) {
        return 1.0; // Static size at start and end
      }
      // Ease in/out for smooth start and end
      final easeInOut = math.sin(animationValue * math.pi);
      final phase = (animationValue + staggerOffset) % 1.0;
      return 1.0 + math.sin(phase * math.pi * 2) * 0.8 * easeInOut;
    }

    // Paint dots (filled circles)
    // Dot 1: cx="13.5" cy="6.5" r=".5"
    canvas.drawCircle(
      Offset(13.5 * scale, 6.5 * scale),
      0.5 * scale * pulseScale(0.0),
      fillPaint,
    );

    // Dot 2: cx="17.5" cy="10.5" r=".5"
    canvas.drawCircle(
      Offset(17.5 * scale, 10.5 * scale),
      0.5 * scale * pulseScale(0.25),
      fillPaint,
    );

    // Dot 3: cx="6.5" cy="12.5" r=".5"
    canvas.drawCircle(
      Offset(6.5 * scale, 12.5 * scale),
      0.5 * scale * pulseScale(0.5),
      fillPaint,
    );

    // Dot 4: cx="8.5" cy="7.5" r=".5"
    canvas.drawCircle(
      Offset(8.5 * scale, 7.5 * scale),
      0.5 * scale * pulseScale(0.75),
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(PalettePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
