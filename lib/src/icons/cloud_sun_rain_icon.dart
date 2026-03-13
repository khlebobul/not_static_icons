import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Sun Rain Icon - Sun rays pulse and rain falls
class CloudSunRainIcon extends AnimatedSVGIcon {
  const CloudSunRainIcon({
    super.key,
    super.size = 40.0,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 1500),
    super.strokeWidth = 2.0,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  String get animationDescription => "Sun rays pulse and rain falls";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudSunRainPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudSunRainPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudSunRainPainter({
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

    // Sun (static)
    // M12 2v2
    canvas.drawLine(
        Offset(12 * scale, 2 * scale), Offset(12 * scale, 4 * scale), paint);
    // m4.93 4.93 1.41 1.41
    canvas.drawLine(Offset(4.93 * scale, 4.93 * scale),
        Offset(6.34 * scale, 6.34 * scale), paint);
    // M20 12h2
    canvas.drawLine(
        Offset(20 * scale, 12 * scale), Offset(22 * scale, 12 * scale), paint);
    // m19.07 4.93-1.41 1.41
    canvas.drawLine(Offset(19.07 * scale, 4.93 * scale),
        Offset(17.66 * scale, 6.34 * scale), paint);

    // Sun arc: M15.947 12.65a4 4 0 0 0-5.925-4.128
    final sunArc = Path();
    sunArc.moveTo(15.947 * scale, 12.65 * scale);
    sunArc.arcToPoint(
      Offset(10.022 * scale, 8.522 * scale),
      radius: Radius.circular(4 * scale),
      clockwise: false,
    );
    canvas.drawPath(sunArc, paint);

    // Cloud floats up slightly
    final oscillation = 4 * animationValue * (1 - animationValue);
    final floatOffset = -oscillation * 1.5;

    canvas.save();
    canvas.translate(0, floatOffset * scale);

    // Cloud: M3 20a5 5 0 1 1 8.9-4H13a3 3 0 0 1 2 5.24
    final cloudPath = Path();
    cloudPath.moveTo(3 * scale, 20 * scale);
    cloudPath.arcToPoint(
      Offset(11.9 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(13 * scale, 16 * scale);
    cloudPath.arcToPoint(
      Offset(15 * scale, 21.24 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    canvas.drawPath(cloudPath, paint);

    canvas.restore();

    // Rain with falling animation (full opacity, staggered)
    canvas.save();
    canvas.translate(0, oscillation * 2.0 * scale);
    // M11 20v2
    canvas.drawLine(
        Offset(11 * scale, 20 * scale), Offset(11 * scale, 22 * scale), paint);
    canvas.restore();

    final t2 = (animationValue * 1.4 - 0.15).clamp(0.0, 1.0);
    final osc2 = 4 * t2 * (1 - t2);
    canvas.save();
    canvas.translate(0, osc2 * 2.0 * scale);
    // M7 19v2
    canvas.drawLine(
        Offset(7 * scale, 19 * scale), Offset(7 * scale, 21 * scale), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudSunRainPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
