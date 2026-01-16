import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Check Icon - Checkmark bounces
class CheckIcon extends AnimatedSVGIcon {
  const CheckIcon({
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
  String get animationDescription => "Check bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Check icon
class CheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CheckPainter({
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

    // Animation - scale bounce
    final oscillation = 4 * animationValue * (1 - animationValue);
    final scaleAnim = 1.0 + oscillation * 0.15;

    canvas.save();
    canvas.translate(12 * scale, 12 * scale);
    canvas.scale(scaleAnim);
    canvas.translate(-12 * scale, -12 * scale);

    // Path: M20 6 L9 17 L4 12
    final checkPath = Path();
    checkPath.moveTo(20 * scale, 6 * scale);
    checkPath.lineTo(9 * scale, 17 * scale);
    checkPath.lineTo(4 * scale, 12 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
