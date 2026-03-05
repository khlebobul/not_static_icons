import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Clock Fading Icon - Clock fades in/out
class ClockFadingIcon extends AnimatedSVGIcon {
  const ClockFadingIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Clock fades in/out";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ClockFadingPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class ClockFadingPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ClockFadingPainter({
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

    // Main arc: M12 2a10 10 0 0 1 7.38 16.75
    final mainArc = Path();
    mainArc.moveTo(12 * scale, 2 * scale);
    mainArc.arcToPoint(
      Offset(19.38 * scale, 18.75 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(mainArc, paint);

    // Calculate fading effect - segments fade in/out with animation
    final oscillation = 4 * animationValue * (1 - animationValue);

    // When animationValue == 0 or 1, all segments are fully visible
    // During animation, segments fade with different phases
    double getFadeOpacity(double phase) {
      if (animationValue == 0 || animationValue == 1) return 1.0; // Fully visible at start and end
      final fade = (math.sin(animationValue * math.pi * 2 + phase) + 1) / 2;
      return 0.3 + fade * 0.7; // Range from 0.3 to 1.0
    }

    // Segment 1: M4.636 5.235a10 10 0 0 1 .891-.857
    final seg1Paint = Paint()
      ..color = color.withValues(alpha: getFadeOpacity(0))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final seg1 = Path();
    seg1.moveTo(4.636 * scale, 5.235 * scale);
    seg1.arcToPoint(
      Offset(5.527 * scale, 4.378 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: true,
    );
    canvas.drawPath(seg1, seg1Paint);

    // Segment 2: M2.5 8.875a10 10 0 0 0-.5 3
    final seg2Paint = Paint()
      ..color = color.withValues(alpha: getFadeOpacity(math.pi / 2))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final seg2 = Path();
    seg2.moveTo(2.5 * scale, 8.875 * scale);
    seg2.arcToPoint(
      Offset(2 * scale, 11.875 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(seg2, seg2Paint);

    // Segment 3: M2.83 16a10 10 0 0 0 2.43 3.4
    final seg3Paint = Paint()
      ..color = color.withValues(alpha: getFadeOpacity(math.pi))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final seg3 = Path();
    seg3.moveTo(2.83 * scale, 16 * scale);
    seg3.arcToPoint(
      Offset(5.26 * scale, 19.4 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(seg3, seg3Paint);

    // Segment 4: M8.644 21.42a10 10 0 0 0 7.631-.38
    final seg4Paint = Paint()
      ..color = color.withValues(alpha: getFadeOpacity(3 * math.pi / 2))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final seg4 = Path();
    seg4.moveTo(8.644 * scale, 21.42 * scale);
    seg4.arcToPoint(
      Offset(16.275 * scale, 21.04 * scale),
      radius: Radius.circular(10 * scale),
      clockwise: false,
    );
    canvas.drawPath(seg4, seg4Paint);

    // Clock hands: M12 6v6l4 2
    final rotation = oscillation * math.pi / 6;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.rotate(rotation);
    canvas.translate(-12 * scale, -12 * scale);

    canvas.drawLine(
        Offset(12 * scale, 6 * scale), Offset(12 * scale, 12 * scale), paint);
    canvas.drawLine(
        Offset(12 * scale, 12 * scale), Offset(16 * scale, 14 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockFadingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
