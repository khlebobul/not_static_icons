import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Copy Minus Icon - Minus line pulses
class CopyMinusIcon extends AnimatedSVGIcon {
  const CopyMinusIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 800),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Minus line pulses";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CopyMinusPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CopyMinusPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CopyMinusPainter({
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

    // Front rect
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8 * scale, 8 * scale, 14 * scale, 14 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(frontRect, paint);

    // Back document
    final backPath = Path();
    backPath.moveTo(4 * scale, 16 * scale);
    backPath.cubicTo(
      2.9 * scale,
      16 * scale,
      2 * scale,
      15.1 * scale,
      2 * scale,
      14 * scale,
    );
    backPath.lineTo(2 * scale, 4 * scale);
    backPath.cubicTo(
      2 * scale,
      2.9 * scale,
      2.9 * scale,
      2 * scale,
      4 * scale,
      2 * scale,
    );
    backPath.lineTo(14 * scale, 2 * scale);
    backPath.cubicTo(
      15.1 * scale,
      2 * scale,
      16 * scale,
      2.9 * scale,
      16 * scale,
      4 * scale,
    );
    canvas.drawPath(backPath, paint);

    // Minus line with pulse: x1="12" x2="18" y1="15" y2="15"
    final oscillation = 4 * animationValue * (1 - animationValue);
    final pulseScale = 1.0 + oscillation * 0.2;

    canvas.save();
    canvas.translate(15 * scale, 15 * scale);
    canvas.scale(pulseScale, 1.0);
    canvas.translate(-15 * scale, -15 * scale);

    canvas.drawLine(
        Offset(12 * scale, 15 * scale), Offset(18 * scale, 15 * scale), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CopyMinusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
