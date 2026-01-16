import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Chef Hat Icon - Hat bounces
class ChefHatIcon extends AnimatedSVGIcon {
  const ChefHatIcon({
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
  String get animationDescription => "Chef hat bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return ChefHatPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

/// Painter for Chef Hat icon
class ChefHatPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  ChefHatPainter({
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

    // Animation - slight bounce up
    final oscillation = 4 * animationValue * (1 - animationValue);
    final bounceOffset = oscillation * 1.5;

    canvas.save();
    canvas.translate(0, -bounceOffset * scale);

    // Main hat shape
    final hatPath = Path();
    hatPath.moveTo(17 * scale, 21 * scale);
    hatPath.arcToPoint(
      Offset(18 * scale, 20 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    hatPath.lineTo(18 * scale, 14.65 * scale);
    // Simplified curve for the top
    hatPath.cubicTo(
      18 * scale, 14.193 * scale,
      18.316 * scale, 13.806 * scale,
      18.727 * scale, 13.609 * scale,
    );
    // Top cloud shape (simplified)
    hatPath.cubicTo(
      20.5 * scale, 12.5 * scale,
      21 * scale, 10 * scale,
      19 * scale, 8 * scale,
    );
    hatPath.cubicTo(
      18 * scale, 7 * scale,
      17 * scale, 6.5 * scale,
      16 * scale, 6.5 * scale,
    );
    hatPath.cubicTo(
      15 * scale, 4 * scale,
      13 * scale, 3 * scale,
      12 * scale, 3 * scale,
    );
    hatPath.cubicTo(
      11 * scale, 3 * scale,
      9 * scale, 4 * scale,
      8 * scale, 6.5 * scale,
    );
    hatPath.cubicTo(
      7 * scale, 6.5 * scale,
      6 * scale, 7 * scale,
      5 * scale, 8 * scale,
    );
    hatPath.cubicTo(
      3 * scale, 10 * scale,
      3.5 * scale, 12.5 * scale,
      5.273 * scale, 13.609 * scale,
    );
    hatPath.cubicTo(
      5.684 * scale, 13.806 * scale,
      6 * scale, 14.193 * scale,
      6 * scale, 14.65 * scale,
    );
    hatPath.lineTo(6 * scale, 20 * scale);
    hatPath.arcToPoint(
      Offset(7 * scale, 21 * scale),
      radius: Radius.circular(1 * scale),
      clockwise: false,
    );
    hatPath.close();
    canvas.drawPath(hatPath, paint);

    // Band line: M6 17h12
    final bandPath = Path();
    bandPath.moveTo(6 * scale, 17 * scale);
    bandPath.lineTo(18 * scale, 17 * scale);
    canvas.drawPath(bandPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ChefHatPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
