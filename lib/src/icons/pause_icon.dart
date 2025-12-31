import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Pause Icon - Bars move apart and back
class PauseIcon extends AnimatedSVGIcon {
  const PauseIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 600),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
  });

  @override
  String get animationDescription => "Pause bars move apart";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return PausePainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Pause icon
class PausePainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  PausePainter({
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

    // Animation - bars move apart
    final oscillation = 4 * animationValue * (1 - animationValue);
    final spread = oscillation * 2.0;

    // Left bar: rect x="5" y="3" width="5" height="18" rx="1"
    final leftBar = RRect.fromRectAndRadius(
      Rect.fromLTWH((5 - spread) * scale, 3 * scale, 5 * scale, 18 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(leftBar, paint);

    // Right bar: rect x="14" y="3" width="5" height="18" rx="1"
    final rightBar = RRect.fromRectAndRadius(
      Rect.fromLTWH((14 + spread) * scale, 3 * scale, 5 * scale, 18 * scale),
      Radius.circular(1 * scale),
    );
    canvas.drawRRect(rightBar, paint);
  }

  @override
  bool shouldRepaint(PausePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
