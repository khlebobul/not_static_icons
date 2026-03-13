import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Hail Icon - Hail bounces
class CloudHailIcon extends AnimatedSVGIcon {
  const CloudHailIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1000),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Hail bounces";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudHailPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudHailPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudHailPainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 24.0;

    // Cloud
    final cloudPath = Path();
    cloudPath.moveTo(4 * scale, 14.899 * scale);
    cloudPath.arcToPoint(
      Offset(15.71 * scale, 8 * scale),
      radius: Radius.circular(7 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(17.5 * scale, 8 * scale);
    cloudPath.arcToPoint(
      Offset(20 * scale, 16.242 * scale),
      radius: Radius.circular(4.5 * scale),
      clockwise: true,
      largeArc: false,
    );
    canvas.drawPath(cloudPath, paint);

    // Hail with staggered fall animation (full opacity)
    final oscillation = 4 * animationValue * (1 - animationValue);

    // Column 1 (x=8, x=16)
    canvas.save();
    canvas.translate(0, oscillation * 2.0 * scale);
    canvas.drawLine(
        Offset(16 * scale, 14 * scale), Offset(16 * scale, 16 * scale), paint);
    canvas.drawLine(
        Offset(8 * scale, 14 * scale), Offset(8 * scale, 16 * scale), paint);
    canvas.drawCircle(Offset(16 * scale, 20 * scale), 0.5 * scale, fillPaint);
    canvas.drawCircle(Offset(8 * scale, 20 * scale), 0.5 * scale, fillPaint);
    canvas.restore();

    // Column 2 (x=12) - slight delay
    final t2 = (animationValue * 1.4 - 0.15).clamp(0.0, 1.0);
    final osc2 = 4 * t2 * (1 - t2);
    canvas.save();
    canvas.translate(0, osc2 * 2.0 * scale);
    canvas.drawLine(
        Offset(12 * scale, 16 * scale), Offset(12 * scale, 18 * scale), paint);
    canvas.drawCircle(Offset(12 * scale, 22 * scale), 0.5 * scale, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudHailPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
