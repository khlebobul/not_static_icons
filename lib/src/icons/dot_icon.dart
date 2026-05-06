import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Dot Icon - dot pulses from the center
class DotIcon extends AnimatedSVGIcon {
  const DotIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 650),
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
  String get animationDescription => 'Dot pulses from the center';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _DotPainter(color, animationValue, strokeWidth);
}

class _DotPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  _DotPainter(this.color, this.animationValue, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final t = animationValue.clamp(0.0, 1.0);
    final pulse = t == 0.0 ? 1.0 : 1.0 + 0.75 * math.sin(math.pi * t);
    canvas.drawCircle(Offset(12.1 * s, 12.1 * s), 1 * s * pulse, paint);
  }

  @override
  bool shouldRepaint(_DotPainter old) =>
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
