import 'package:flutter/material.dart';
import 'dart:math';
import '../core/animated_svg_icon_base.dart';

/// Animated Annoyed Icon - Rolling eyes upward
class AnnoyedIcon extends AnimatedSVGIcon {
  const AnnoyedIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
  });

  @override
  String get animationDescription => "Rolling eyes upward";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return AnnoyedPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Annoyed icon
class AnnoyedPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  AnnoyedPainter({
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
    Offset p(double x, double y) => Offset(x * scale, y * scale);

    // Main face circle (circle cx="12" cy="12" r="10")
    canvas.drawCircle(p(12, 12), 10 * scale, paint);

    // Mouth (path d="M8 15h8")
    canvas.drawLine(p(8, 15), p(16, 15), paint);

    // Calculate eye roll animation
    // Eyes move from position 9 down to 8 (rolling up)
    final eyeOffset = sin(animationValue * pi) * 1.0;
    final leftEyeY = 9 - eyeOffset;
    final rightEyeY = 9 - eyeOffset;

    // Left eye (path d="M8 9h2") - animated vertically
    canvas.drawLine(p(8, leftEyeY), p(10, leftEyeY), paint);

    // Right eye (path d="M14 9h2") - animated vertically
    canvas.drawLine(p(14, rightEyeY), p(16, rightEyeY), paint);
  }

  @override
  bool shouldRepaint(AnnoyedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
