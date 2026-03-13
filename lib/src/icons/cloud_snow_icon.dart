import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Snow Icon - Snowflakes pulse
class CloudSnowIcon extends AnimatedSVGIcon {
  const CloudSnowIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1200),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Snowflakes pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudSnowPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudSnowPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudSnowPainter({
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

    // Cloud: M4 14.899A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.242
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
    );
    canvas.drawPath(cloudPath, paint);

    // Snowflakes with staggered falling (full opacity)
    final oscillation = 4 * animationValue * (1 - animationValue);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Row 1 (x=8, x=16 top) + Row 2 (x=12 top)
    canvas.save();
    canvas.translate(0, oscillation * 2.0 * scale);
    canvas.drawCircle(Offset(8 * scale, 15 * scale), 0.5 * scale, fillPaint);
    canvas.drawCircle(Offset(16 * scale, 15 * scale), 0.5 * scale, fillPaint);
    canvas.drawCircle(Offset(12 * scale, 17 * scale), 0.5 * scale, fillPaint);
    canvas.restore();

    // Row 2 (bottom dots) - slight delay
    final t2 = (animationValue * 1.4 - 0.15).clamp(0.0, 1.0);
    final osc2 = 4 * t2 * (1 - t2);
    canvas.save();
    canvas.translate(0, osc2 * 2.0 * scale);
    canvas.drawCircle(Offset(8 * scale, 19 * scale), 0.5 * scale, fillPaint);
    canvas.drawCircle(Offset(16 * scale, 19 * scale), 0.5 * scale, fillPaint);
    canvas.drawCircle(Offset(12 * scale, 21 * scale), 0.5 * scale, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudSnowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
