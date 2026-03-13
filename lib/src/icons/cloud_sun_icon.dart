import 'package:flutter/material.dart';
import '../core/animated_svg_icon_base.dart';

/// Animated Cloud Sun Icon - Sun rays pulse
class CloudSunIcon extends AnimatedSVGIcon {
  const CloudSunIcon({
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
  String get animationDescription => "Sun rays pulse";

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) {
    return CloudSunPainter(
      color: color,
      animationValue: animationValue,
      strokeWidth: strokeWidth,
    );
  }
}

class CloudSunPainter extends CustomPainter {
  final Color color;
  final double animationValue;
  final double strokeWidth;

  CloudSunPainter({
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

    final cloudPath = Path();
    cloudPath.moveTo(13 * scale, 22 * scale);
    cloudPath.lineTo(7 * scale, 22 * scale);
    cloudPath.arcToPoint(
      Offset(11.9 * scale, 16 * scale),
      radius: Radius.circular(5 * scale),
      clockwise: true,
      largeArc: true,
    );
    cloudPath.lineTo(13 * scale, 16 * scale);
    cloudPath.arcToPoint(
      Offset(13 * scale, 22 * scale),
      radius: Radius.circular(3 * scale),
      clockwise: true,
    );
    cloudPath.close();
    canvas.drawPath(cloudPath, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CloudSunPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
