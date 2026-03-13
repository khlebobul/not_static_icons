import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Check Icon - Checkmark appears
class CloudCheckIcon extends AnimatedSVGIcon {
  const CloudCheckIcon({
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
  String get animationDescription => "Checkmark appears";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudCheckPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudCheckPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudCheckPainter({
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

    // Cloud: M5.516 16.07A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 3.501 7.327
    final cloudPath = Path();
    cloudPath.moveTo(5.516 * scale, 16.07 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(21.001 * scale, 15.327 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    // Checkmark with scale animation
    final oscillation = 4 * animationValue * (1 - animationValue);
    final checkScale = 1.0 + oscillation * 0.2;

    canvas.save();
    canvas.translate(13.25 * scale, 18.25 * scale);
    canvas.scale(checkScale);
    canvas.translate(-13.25 * scale, -18.25 * scale);

    // Checkmark: m17 15-5.5 5.5L9 18
    final checkPath = Path();
    checkPath.moveTo(17 * scale, 15 * scale);
    checkPath.lineTo(11.5 * scale, 20.5 * scale);
    checkPath.lineTo(9 * scale, 18 * scale);
    canvas.drawPath(checkPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudCheckPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
