import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/animated_svg_icon_base.dart';

/// Animated Calendar 1 Icon - The "1" appears
class Calendar1Icon extends AnimatedSVGIcon {
  const Calendar1Icon({
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
  String get animationDescription => "The number 1 appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return Calendar1Painter(
      color: color,
      progress: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class Calendar1Painter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  Calendar1Painter({
    required this.color,
    required this.progress,
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

    // Calendar Body (Static)
    // rect x="3" y="4" width="18" height="18" rx="2"
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(3 * scale, 4 * scale, 18 * scale, 18 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(rect, paint);

    // Top Lines
    // M16 2v4
    canvas.drawLine(
        Offset(16 * scale, 2 * scale), Offset(16 * scale, 6 * scale), paint);
    // M8 2v4
    canvas.drawLine(
        Offset(8 * scale, 2 * scale), Offset(8 * scale, 6 * scale), paint);

    // Horizontal Line
    // M3 10h18
    canvas.drawLine(
        Offset(3 * scale, 10 * scale), Offset(21 * scale, 10 * scale), paint);

    // The "1" (Animated)
    // M11 14h1v4
    // Path: 11,14 -> 12,14 -> 12,18

    // Animate scale or drawing?
    // Let's do scale from center of "1".
    // Center roughly 11.5, 16.

    // Or just draw it if progress > 0?
    // User prefers "return to original".
    // So 0 -> 1 -> 0? Or 0 -> 1 and stay?
    // Usually hover effect is 0->1.
    // If we want it to "appear", it implies it's hidden at 0?
    // But original icon has it.
    // So maybe it scales up and down? Or pulses?
    // Let's make it pulse.

    // Pulse: 1.0 -> 1.5 -> 1.0
    final pulse = math.sin(progress * math.pi);
    final oneScale = 1.0 + pulse * 0.5;

    canvas.save();
    // Pivot at center of "1"
    canvas.translate(11.5 * scale, 16 * scale);
    canvas.scale(oneScale);
    canvas.translate(-11.5 * scale, -16 * scale);

    final onePath = Path();
    onePath.moveTo(11 * scale, 14 * scale);
    onePath.lineTo(12 * scale, 14 * scale);
    onePath.lineTo(12 * scale, 18 * scale);
    canvas.drawPath(onePath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(Calendar1Painter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
