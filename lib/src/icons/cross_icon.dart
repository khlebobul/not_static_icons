import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cross Icon - cross pulses (scales) from center on hover/tap
class CrossIcon extends AnimatedSVGIcon {
  const CrossIcon({
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
  String get animationDescription => 'Cross pulses outward from center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return _CrossPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class _CrossPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _CrossPainter({
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

    // Cross path: M4 9a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h4a1 1 0 0 1 1 1v4a2 2 0 0 0 2 2h2
    //             a2 2 0 0 0 2-2v-4a1 1 0 0 1 1-1h4a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-4
    //             a1 1 0 0 1-1-1V4a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2v4a1 1 0 0 1-1 1z
    void drawCross() {
      final Path cross = Path()
        ..moveTo(4 * s, 9 * s)
        ..arcToPoint(Offset(2 * s, 11 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(2 * s, 13 * s)
        ..arcToPoint(Offset(4 * s, 15 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(8 * s, 15 * s)
        ..arcToPoint(Offset(9 * s, 16 * s),
            radius: Radius.circular(1 * s), clockwise: true)
        ..lineTo(9 * s, 20 * s)
        ..arcToPoint(Offset(11 * s, 22 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(13 * s, 22 * s)
        ..arcToPoint(Offset(15 * s, 20 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(15 * s, 16 * s)
        ..arcToPoint(Offset(16 * s, 15 * s),
            radius: Radius.circular(1 * s), clockwise: true)
        ..lineTo(20 * s, 15 * s)
        ..arcToPoint(Offset(22 * s, 13 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(22 * s, 11 * s)
        ..arcToPoint(Offset(20 * s, 9 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(16 * s, 9 * s)
        ..arcToPoint(Offset(15 * s, 8 * s),
            radius: Radius.circular(1 * s), clockwise: false)
        ..lineTo(15 * s, 4 * s)
        ..arcToPoint(Offset(13 * s, 2 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(11 * s, 2 * s)
        ..arcToPoint(Offset(9 * s, 4 * s),
            radius: Radius.circular(2 * s), clockwise: false)
        ..lineTo(9 * s, 8 * s)
        ..arcToPoint(Offset(8 * s, 9 * s),
            radius: Radius.circular(1 * s), clockwise: false)
        ..close();
      canvas.drawPath(cross, paint);
    }

    if (t == 0.0) {
      drawCross();
    } else {
      // Pulse: scale from center (12, 12)
      final double scale = 1.0 + 0.22 * math.sin(math.pi * t);
      canvas.save();
      canvas.translate(12 * s, 12 * s);
      canvas.scale(scale, scale);
      canvas.translate(-12 * s, -12 * s);
      drawCross();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CrossPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
