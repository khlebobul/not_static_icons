import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Check Check Icon - Double checkmark bounces
class CheckCheckIcon extends AnimatedSVGIcon {
  const CheckCheckIcon({
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
  String get animationDescription => "Double check bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CheckCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Check Check icon
class CheckCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CheckCheckPainter({
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

    // First check: M18 6 L7 17 L2 12
    final check1Path = Path();
    check1Path.moveTo(18 * scale, 6 * scale);
    check1Path.lineTo(7 * scale, 17 * scale);
    check1Path.lineTo(2 * scale, 12 * scale);
    canvas.drawPath(check1Path, paint);

    // Second check: M22 10 L14.5 17.5 L13 16
    final check2Path = Path();
    check2Path.moveTo(22 * scale, 10 * scale);
    check2Path.lineTo(14.5 * scale, 17.5 * scale);
    check2Path.lineTo(13 * scale, 16 * scale);
    canvas.drawPath(check2Path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CheckCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
